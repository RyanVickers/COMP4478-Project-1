import flixel.FlxSprite;

class Square extends FlxSprite
{
	public function new(X:Float, Y:Float, size:Int, color:Int)
	{
		super(X, Y);
		makeGraphic(size, size, color);
	}
}
