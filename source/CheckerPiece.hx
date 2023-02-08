import flixel.FlxG;
import flixel.FlxSprite;

class CheckerPiece extends FlxSprite
{
	public var isSelected:Bool = false;

	public function new(X:Float, Y:Float, PieceImage:String)
	{
		super(X, Y);
		loadGraphic(PieceImage);
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
			this.x = Math.floor(FlxG.mouse.x / 64) * 64;

			this.y = Math.floor(FlxG.mouse.y / 64) * 64;

			this.isSelected = false;
		}
	}
}
