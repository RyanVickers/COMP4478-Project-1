import flixel.FlxG;
import flixel.FlxSprite;

class ChessPiece extends FlxSprite
{
	public var isSelected:Bool = false;
	public var pieceColor:String;

	var board:ChessBoard;
	var isAlive:Bool;

	public function new(X:Float, Y:Float, PieceImage:String, pieceColor:String, isAlive:Bool, Board:ChessBoard)
	{
		super(X, Y);
		loadGraphic(PieceImage);
		this.pieceColor = pieceColor;
		this.isAlive = true;
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
			if (piece.getType() == "pawn")
			{
				if ((pieceColor == "black" && xMovement == 0 && yMovement > 0 && yMovement <= (64 * (piece.isFirstMove() ? 2 : 1)))
					|| (pieceColor == "white" && xMovement == 0 && yMovement < 0 && yMovement >= (-64 * (piece.isFirstMove() ? 2 : 1))))
				{
					if (!isMoveBlocked(newX, newY))
					{
						this.setMoved();
						return true;
					}
					return false;
				}
				else if ((pieceColor == "black"
					&& (xMovement == 64 && yMovement == 64 || xMovement == -64 && yMovement == 64)
					|| (pieceColor == "white" && (xMovement == 64 && yMovement == -64 || xMovement == -64 && yMovement == -64))))
				{
					var allPieces = board.chessPieces.members;
					for (i in 0...allPieces.length)
					{
						if (allPieces[i].isAlive && allPieces[i].x == newX && allPieces[i].y == newY)
						{
							if ((this.pieceColor == "white" && allPieces[i].pieceColor == "black")
								|| (this.pieceColor == "black" && allPieces[i].pieceColor == "white"))
							{
								allPieces[i].kill();
								allPieces[i].isAlive = false;
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
			// check to see if the knight is being moved
			if (piece.getType() == "knight")
			{
				// check if it is a valid time for the knight to move to
				if (((xMovement == 64 || xMovement == -64)
					&& (yMovement == 128 || yMovement == -128)
					|| (xMovement == 128 || xMovement == -128)
					&& (yMovement == 64 || yMovement == -64)))
				{
					// Check if there's an enemy piece at the new location
					var allPieces = board.chessPieces.members;
					for (i in 0...allPieces.length)
					{
						var currentPiece = allPieces[i];
						if (currentPiece.isAlive && currentPiece.x == newX && currentPiece.y == newY)
						{
							if (this.pieceColor != currentPiece.pieceColor)
							{
								currentPiece.kill();
								currentPiece.isAlive = false; // set the killed piece to dead
							}
							else
							{
								return false;
							}
						}
					}
					// Move Knight
					this.setMoved();
					return true;
				}
				else
				{
					return false;
				}
			}
			// Validation for rook
			if (piece.getType() == "rook")
			{
				if (xMovement == 0 || yMovement == 0)
				{
					// Check if there's any piece in the path of the rook
					var allPieces = board.chessPieces.members;
					for (i in 0...allPieces.length)
					{
						var currentPiece = allPieces[i];
						if (currentPiece == this)
						{
							continue;
						}
						if (xMovement == 0)
						{
							// Check if the piece is in the path of the rook for column
							if (currentPiece.isAlive
								&& currentPiece.x == this.x
								&& ((currentPiece.y > this.y && currentPiece.y < newY)
									|| (currentPiece.y < this.y && currentPiece.y > newY)))
							{
								return false;
							}
						}
						else if (yMovement == 0)
						{
							// Check if the piece is in the path of the rook for row
							if (currentPiece.isAlive
								&& currentPiece.y == this.y
								&& ((currentPiece.x > this.x && currentPiece.x < newX)
									|| (currentPiece.x < this.x && currentPiece.x > newX)))
							{
								return false;
							}
						}
					}

					// Check if there's an enemy piece at the new location
					for (i in 0...allPieces.length)
					{
						var currentPiece = allPieces[i];
						if (currentPiece.isAlive && currentPiece.x == newX && currentPiece.y == newY)
						{
							if (this.pieceColor != currentPiece.pieceColor)
							{
								currentPiece.kill();
								currentPiece.isAlive = false; // set the killed piece to dead
							}
							else
							{
								return false;
							}
						}
					}
					// Move rook
					this.setMoved();
					return true;
				}
				else
				{
					return false;
				}
			}
			// Validation for Bishop
			if (piece.getType() == "bishop")
			{
				// Check if the bishop is moving diagonally
				if (Math.abs(xMovement) == Math.abs(yMovement))
				{
					// Check if there's any piece in the path of the bishop
					var allPieces = board.chessPieces.members;
					for (i in 0...allPieces.length)
					{
						var currentPiece = allPieces[i];
						if (currentPiece == this)
						{
							continue;
						}
						if (Math.abs(currentPiece.x - this.x) == Math.abs(currentPiece.y - this.y))
						{
							// Check if the piece lies in the path of the bishop
							if (((currentPiece.isAlive && currentPiece.x > this.x && currentPiece.x < newX)
								|| (currentPiece.x < this.x && currentPiece.x > newX))
								&& ((currentPiece.y > this.y && currentPiece.y < newY)
									|| (currentPiece.y < this.y && currentPiece.y > newY)))
							{
								return false;
							}
						}
					}

					// Check if there's an enemy piece at the new location
					for (i in 0...allPieces.length)
					{
						var currentPiece = allPieces[i];
						if (currentPiece.isAlive && currentPiece.x == newX && currentPiece.y == newY)
						{
							if (this.pieceColor != currentPiece.pieceColor)
							{
								currentPiece.kill();
								currentPiece.isAlive = false; // set the killed piece to dead
							}
							else
							{
								return false;
							}
						}
					}
					// Move Bishop
					this.setMoved();
					return true;
				}
				else
				{
					return false;
				}
			}

			if (piece.getType() == "king")
			{
				if (xMovement >= -64 && xMovement <= 64 && yMovement >= -64 && yMovement <= 64)
				{
					var allPieces = board.chessPieces.members;
					for (i in 0...allPieces.length)
					{
						var currentPiece = allPieces[i];
						if (currentPiece.isAlive && currentPiece.x == newX && currentPiece.y == newY)
						{
							if (this.pieceColor != currentPiece.pieceColor)
							{
								currentPiece.kill();
								currentPiece.isAlive = false; // set the killed piece to dead
							}
							else
							{
								return false;
							}
						}
					}
					this.setMoved();
					return true;
				}
				else
				{
					return false;
				}
			}

			if (piece.getType() == "queen")
			{
				if (xMovement == 0 || yMovement == 0 || xMovement == yMovement || xMovement == -yMovement)
				{
					var allPieces = board.chessPieces.members;
					for (i in 0...allPieces.length)
					{
						var currentPiece = allPieces[i];
						if (currentPiece == this)
						{
							continue;
						}
						// Check Horizontal
						if (xMovement == 0)
						{
							if (currentPiece.isAlive
								&& currentPiece.x == this.x
								&& ((currentPiece.y > this.y && currentPiece.y < newY)
									|| (currentPiece.y < this.y && currentPiece.y > newY)))
							{
								return false;
							}
						}
						// check Vertical
						else if (yMovement == 0)
						{
							if (currentPiece.isAlive
								&& currentPiece.y == this.y
								&& ((currentPiece.x > this.x && currentPiece.x < newX)
									|| (currentPiece.x < this.x && currentPiece.x > newX)))
							{
								return false;
							}
						}
						else if (xMovement == yMovement || xMovement == -yMovement)
						{
							// Check if the piece is on the same diagonal as the queen and lies in the path of the queen
							if (currentPiece.isAlive
								&& Math.abs(currentPiece.x - this.x) == Math.abs(currentPiece.y - this.y)
								&& ((currentPiece.x > this.x && currentPiece.x < newX)
									|| (currentPiece.x < this.x && currentPiece.x > newX))
								&& ((currentPiece.y > this.y && currentPiece.y < newY)
									|| (currentPiece.y < this.y && currentPiece.y > newY)))
							{
								return false;
							}
						}
					}

					// Check if there's an enemy piece at the new location
					for (i in 0...allPieces.length)
					{
						var currentPiece = allPieces[i];
						if (currentPiece.isAlive && currentPiece.x == newX && currentPiece.y == newY)
						{
							if (this.pieceColor != currentPiece.pieceColor)
							{
								currentPiece.kill();
								currentPiece.isAlive = false; // set the killed piece to dead
							}
							else
							{
								return false;
							}
						}
					}
					// Move Queen
					this.setMoved();
					return true;
				}
				else
				{
					return false;
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
			if (allPieces[i].isAlive && allPieces[i].x == newX && allPieces[i].y == newY)
			{
				return true;
			}
		}

		return false;
	}
}
