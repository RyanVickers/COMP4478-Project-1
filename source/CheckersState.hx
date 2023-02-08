import flixel.FlxState;

class CheckersState extends FlxState
{
	override public function create()
	{
		super.create();
		add(new CheckersBoard());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
