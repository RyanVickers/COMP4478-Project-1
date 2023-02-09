import flixel.FlxG;
import flixel.FlxSprite;

class CheckerPiece extends FlxSprite
{
	public var isSelected:Bool = false;
	public var isKing:Bool = false;
	public var pieceColor:String;
	var board:CheckersBoard;
	public function new(X:Float, Y:Float, Color:String, Board:CheckersBoard)
	{
		super(X, Y);
		loadGraphic(Color=="red"?AssetPaths.r_checker__png : AssetPaths.b_checker__png);
		pieceColor= Color;
		board=Board;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (FlxG.mouse.justPressed)
		{
			if (overlapsPoint(FlxG.mouse.getWorldPosition()))
			{
				isSelected = !isSelected;
			}
		}
		if (isSelected && FlxG.mouse.justReleased)
		{
			var newX = Math.floor(FlxG.mouse.x / 64) * 64;
			var newY = Math.floor(FlxG.mouse.y / 64) * 64;
			//if the player drags outside the board don't allow the move
			if(newX>=0 && newX<=448 && newY>=0 && newY<=448){
				board.validateAndMovePiece(this, newX, newY);
			}

			isSelected = false;

			//if the piece reaches the opposite end of the board than it started on then make it a king
			if(pieceColor=="red" && y==0 && !isKing){
				isKing=true;
				loadGraphic(AssetPaths.r_king_checker__png);
			}
			else if(pieceColor=="black" && y==448 && !isKing){
				isKing=true;
				loadGraphic(AssetPaths.b_king_checker__png);
			}
		}
	}
}
