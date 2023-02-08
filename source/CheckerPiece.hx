import flixel.FlxG;
import flixel.FlxSprite;

class CheckerPiece extends FlxSprite
{
	public var isSelected:Bool = false;
	public var isKing:Bool = false;
	public var pieceColor:String;
	public function new(X:Float, Y:Float, Color:String)
	{
		super(X, Y);
		loadGraphic(Color=="red"?AssetPaths.r_checker__png : AssetPaths.b_checker__png);
		pieceColor= Color;
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

			validateAndMove(Math.floor(FlxG.mouse.x / 64) * 64,Math.floor(FlxG.mouse.y / 64) * 64);

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

	function validateAndMove(newX:Int, newY:Int){
		//make sure the move is valid 
		var valid:Bool = false;
		if(isKing && ((newX==x+64 || newX==x-64)&&(newY==y+64 || newY==y-64))){
			valid=true;
		}
		else if(pieceColor=="red" && ((newX==x+64 || newX==x-64)&&(newY==y-64))){
			valid= true;
		}
		else if(pieceColor=="black" && (newX==x+64 || newX==x-64)&&(newY==y+64)){
			valid= true;
		}
		if(valid){
			x = newX;
			y= newY;
		}
	}
}
