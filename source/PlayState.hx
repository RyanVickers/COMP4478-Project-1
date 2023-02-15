import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	override public function create():Void
	{
		bgColor = FlxColor.WHITE;
		var logo:FlxSprite = new FlxSprite(0, 25, AssetPaths.logo__png);
		logo.screenCenter(X);

		add(logo);
		// Add a title text
		var text:FlxText = new FlxText(0, 125, FlxG.width, "Choose a Game");
		text.setFormat(null, 32, 0xff000000, "center");
		add(text);

		// Add a button to start the chess game
		var chessButton:FlxButton = new FlxButton(0, 225, "Chess", function():Void
		{
			FlxG.switchState(new ChessState());
		});
		chessButton.screenCenter(X);
		// Double the size of the button
		chessButton.scale.set(2, 2);
		chessButton.width = chessButton.width * 2;
		chessButton.height = chessButton.height * 2;

		add(chessButton);

		// Add a button to start the checkers game
		var checkersButton:FlxButton = new FlxButton(0, 300, "Checkers", function():Void
		{
			FlxG.switchState(new CheckersState());
		});
		checkersButton.screenCenter(X);
		// Double the size of the button
		checkersButton.scale.set(2, 2);
		checkersButton.width = checkersButton.width * 2;
		checkersButton.height = checkersButton.height * 2;

		add(checkersButton);

		var quitButton:FlxButton = new FlxButton(0, 375, "Quit", function():Void
		{
			lime.system.System.exit(0);
		});

		quitButton.screenCenter(X); // Center the button on the screen
		// Double the size of the button
		quitButton.scale.set(2, 2);
		quitButton.width = quitButton.width * 2;
		quitButton.height = quitButton.height * 2;

		add(quitButton); // Add the button to the game state
	}
}
