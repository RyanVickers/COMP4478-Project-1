package;

import flixel.FlxState;

class ChessState extends FlxState
{
	override public function create()
	{
		super.create();
		add(new ChessBoard());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
