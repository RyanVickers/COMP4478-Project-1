package;

import flixel.FlxState;
import flixel.util.FlxColor;

class ChessState extends FlxState
{
	override public function create()
	{
		super.create();
		bgColor = FlxColor.BLACK;
		add(new ChessBoard());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
