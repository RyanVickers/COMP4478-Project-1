import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class PlayState extends FlxState
{
	override public function create():Void
	{
		// Add a title text
		var title:FlxText = new FlxText(0, 0, FlxG.width, "Choose a Game");
		title.setFormat(null, 32, 0xffffffff, "center");
		add(title);

		// Add a button to start the chess game
		var chessButton:FlxButton = new FlxButton(0, 100, "Chess", function():Void
		{
			FlxG.switchState(new ChessState());
		});
		chessButton.screenCenter(X);
		add(chessButton);

		// Add a button to start the checkers game
		var checkersButton:FlxButton = new FlxButton(0, 200, "Checkers", function():Void
		{
			FlxG.switchState(new CheckersState());
		});
		checkersButton.screenCenter(X);
		add(checkersButton);
	}
}
