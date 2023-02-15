import flixel.FlxState;
import flixel.util.FlxColor;

class CheckersState extends FlxState
{
	override public function create()
	{
		bgColor = FlxColor.BLACK;
		super.create();
		add(new CheckersBoard());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
