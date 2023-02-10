import flixel.group.FlxGroup;

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
			var pawn = new Pawn(x * size, 6 * size, AssetPaths.w_pawn__png, "white", this);
			// add(pawn);
			chessPieces.add(pawn);

			pawn = new Pawn(x * size, 1 * size, AssetPaths.b_pawn__png, "black", this);
			// add(pawn);
			chessPieces.add(pawn);
		}

		chessPieces.add(new Rook(0 * size, 7 * size, AssetPaths.w_rook__png, "white", this));
		chessPieces.add(new Knight(1 * size, 7 * size, AssetPaths.w_knight__png, "white", this));
		chessPieces.add(new Bishop(2 * size, 7 * size, AssetPaths.w_bishop__png, "white", this));
		chessPieces.add(new Queen(3 * size, 7 * size, AssetPaths.w_queen__png, "white", this));
		chessPieces.add(new King(4 * size, 7 * size, AssetPaths.w_king__png, "white", this));
		chessPieces.add(new Bishop(5 * size, 7 * size, AssetPaths.w_bishop__png, "white", this));
		chessPieces.add(new Knight(6 * size, 7 * size, AssetPaths.w_knight__png, "white", this));
		chessPieces.add(new Rook(7 * size, 7 * size, AssetPaths.w_rook__png, "white", this));

		chessPieces.add(new Rook(0 * size, 0 * size, AssetPaths.b_rook__png, "black", this));
		chessPieces.add(new Knight(1 * size, 0 * size, AssetPaths.b_knight__png, "black", this));
		chessPieces.add(new Bishop(2 * size, 0 * size, AssetPaths.b_bishop__png, "black", this));
		chessPieces.add(new Queen(3 * size, 0 * size, AssetPaths.b_queen__png, "black", this));
		chessPieces.add(new King(4 * size, 0 * size, AssetPaths.b_king__png, "black", this));
		chessPieces.add(new Bishop(5 * size, 0 * size, AssetPaths.b_bishop__png, "black", this));
		chessPieces.add(new Knight(6 * size, 0 * size, AssetPaths.b_knight__png, "black", this));
		chessPieces.add(new Rook(7 * size, 0 * size, AssetPaths.b_rook__png, "black", this));

		add(chessPieces);
	}
}
