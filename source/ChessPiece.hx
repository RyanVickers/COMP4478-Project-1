import flixel.FlxG;
import flixel.FlxSprite;

class ChessPiece extends FlxSprite
{
	public var isSelected:Bool = false;
	public var pieceColor:String;

	var board:ChessBoard;

	public function new(X:Float, Y:Float, PieceImage:String, pieceColor:String, Board:ChessBoard)
	{
		super(X, Y);
		loadGraphic(PieceImage);
		this.pieceColor = pieceColor;
		board = Board;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (FlxG.mouse.justPressed)
		{
			if (this.overlapsPoint(FlxG.mouse.getWorldPosition()))
			{
				this.isSelected = !this.isSelected;
			}
		}
		if (this.isSelected && FlxG.mouse.justReleased)
		{
			if (validateMove(this, Math.floor(FlxG.mouse.x / 64) * 64, Math.floor(FlxG.mouse.y / 64) * 64))
			{
				this.x = Math.floor(FlxG.mouse.x / 64) * 64;

				this.y = Math.floor(FlxG.mouse.y / 64) * 64;

				this.isSelected = false;
			}
		}
	}

	private function validateMove(piece, newX:Int, newY:Int):Bool
	{
		var xMovement = newX - this.x;
		var yMovement = newY - this.y;

		// First check if the new position will still be on the board
		if (newX >= 0 && newX <= 64 * 7 && newY >= 0 && newY <= 64 * 7)
		{
			// Check which type of piece the player is moving
			if (piece.getType() == "pawn")
			{
				// Check if its the pawns first move
				if (piece.isFirstMove())
				{
					// Check if the piece is moving one or two spots forwards
					if ((pieceColor == "black" && xMovement == 0 && yMovement > 0 && yMovement <= (64 * 2))
						|| (pieceColor == "white" && xMovement == 0 && yMovement < 0 && yMovement >= (-64 * 2)))
					{
						// Check if the piece is being blocked
						if (!isMoveBlocked(newX, newY))
						{
							this.setMoved();
							return true;
						}
						return false;
					}
					// Check if the player is trying to take the enemies piece
					else if ((pieceColor == "black" && xMovement == 64 || xMovement == -64 && yMovement == 64)
						|| (pieceColor == "white" && xMovement == 64 || xMovement == -64 && yMovement == -64))
					{
						// Iterate through the pieces and see if theres an enemy piece, if there is then kill the enemy piece
						var allPieces = board.chessPieces.members;
						for (i in 0...allPieces.length)
						{
							if (allPieces[i].x == newX && allPieces[i].y == newY)
							{
								if (this.pieceColor == "white" && allPieces[i].pieceColor == "black")
								{
									allPieces[i].kill();
									return true;
								}
								else if (this.pieceColor == "black" && allPieces[i].pieceColor == "white")
								{
									allPieces[i].kill();
									return true;
								}
							}
						}

						return false;
					}
					else
					{
						return false;
					}
				}
				else
				{
					// Check if the piece is moving one spot forward
					if ((pieceColor == "black" && xMovement == 0 && yMovement > 0 && yMovement <= 64)
						|| (pieceColor == "white" && xMovement == 0 && yMovement < 0 && yMovement >= -64))
					{
						// Check if the move is blocked
						if (!isMoveBlocked(newX, newY))
						{
							this.setMoved();
							return true;
						}
						return false;
					}
					// Check if the player is trying to take the enemies piece
					else if ((pieceColor == "black" && xMovement == 64 || xMovement == -64 && yMovement == 64)
						|| (pieceColor == "white" && xMovement == 64 || xMovement == -64 && yMovement == -64))
					{
						// Iterate through the pieces and see if theres an enemy piece, if there is then kill the enemy piece
						var allPieces = board.chessPieces.members;
						for (i in 0...allPieces.length)
						{
							if (allPieces[i].x == newX && allPieces[i].y == newY)
							{
								if (this.pieceColor == "white" && allPieces[i].pieceColor == "black")
								{
									allPieces[i].kill();
									return true;
								}
								else if (this.pieceColor == "black" && allPieces[i].pieceColor == "white")
								{
									allPieces[i].kill();
									return true;
								}
							}
						}

						return false;
					}
					else
					{
						return false;
					}
				}
			}
			else
			{
				return true;
			}
		}

		return false;
	}

	public function getType():String
	{
		return "";
	}

	public function isFirstMove():Bool
	{
		return false;
	}

	public function setMoved() {}

	// Check if theres a piece blocking the players move
	private function isMoveBlocked(newX:Int, newY:Int):Bool
	{
		var allPieces = board.chessPieces.members;
		for (i in 0...allPieces.length)
		{
			if (allPieces[i].x == newX && allPieces[i].y == newY)
			{
				return true;
			}
		}

		return false;
	}
}
