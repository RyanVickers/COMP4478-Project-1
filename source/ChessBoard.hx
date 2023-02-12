import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.ui.FlxButton;

class ChessBoard extends FlxGroup
{
	public var chessPieces:FlxTypedGroup<ChessPiece> = new FlxTypedGroup<ChessPiece>();

	public function new()
	{
		super();

		var size:Int = 64; // Size of each square on board
		var color1:Int = 0xffcccccc;
		var color2:Int = 0xff000000;

		for (y in 0...8)
		{
			for (x in 0...8)
			{
				var square:Square = new Square(x * size, y * size, size, ((x + y) % 2 == 0) ? color1 : color2);
				add(square);
			}
		}

		// Adding pieces to chess board
		for (x in 0...8)
		{
			var pawn = new Pawn(x * size, 6 * size, AssetPaths.w_pawn__png, "white", true, this);
			// add(pawn);
			chessPieces.add(pawn);

			pawn = new Pawn(x * size, 1 * size, AssetPaths.b_pawn__png, "black", true, this);
			// add(pawn);
			chessPieces.add(pawn);
		}

		chessPieces.add(new Rook(0 * size, 7 * size, AssetPaths.w_rook__png, "white", true, this));
		chessPieces.add(new Knight(1 * size, 7 * size, AssetPaths.w_knight__png, "white", true, this));
		chessPieces.add(new Bishop(2 * size, 7 * size, AssetPaths.w_bishop__png, "white", true, this));
		chessPieces.add(new Queen(3 * size, 7 * size, AssetPaths.w_queen__png, "white", true, this));
		chessPieces.add(new King(4 * size, 7 * size, AssetPaths.w_king__png, "white", true, this));
		chessPieces.add(new Bishop(5 * size, 7 * size, AssetPaths.w_bishop__png, "white", true, this));
		chessPieces.add(new Knight(6 * size, 7 * size, AssetPaths.w_knight__png, "white", true, this));
		chessPieces.add(new Rook(7 * size, 7 * size, AssetPaths.w_rook__png, "white", true, this));

		chessPieces.add(new Rook(0 * size, 0 * size, AssetPaths.b_rook__png, "black", true, this));
		chessPieces.add(new Knight(1 * size, 0 * size, AssetPaths.b_knight__png, "black", true, this));
		chessPieces.add(new Bishop(2 * size, 0 * size, AssetPaths.b_bishop__png, "black", true, this));
		chessPieces.add(new Queen(3 * size, 0 * size, AssetPaths.b_queen__png, "black", true, this));
		chessPieces.add(new King(4 * size, 0 * size, AssetPaths.b_king__png, "black", true, this));
		chessPieces.add(new Bishop(5 * size, 0 * size, AssetPaths.b_bishop__png, "black", true, this));
		chessPieces.add(new Knight(6 * size, 0 * size, AssetPaths.b_knight__png, "black", true, this));
		chessPieces.add(new Rook(7 * size, 0 * size, AssetPaths.b_rook__png, "black", true, this));

		add(chessPieces);
		var restartButton:FlxButton = new FlxButton(FlxG.width / 2, 520, "Restart", function():Void
		{
			FlxG.resetState();
		});
		restartButton.label.size = 10;
		add(restartButton);

		var backButton:FlxButton = new FlxButton(FlxG.width / 2 - 100, 520, "Menu", function():Void
		{
			FlxG.switchState(new PlayState());
		});
		backButton.label.size = 10;
		add(backButton);
	}
}
