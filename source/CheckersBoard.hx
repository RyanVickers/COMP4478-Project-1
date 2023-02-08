import flixel.group.FlxGroup;

class CheckersBoard extends FlxGroup
{
	public function new()
	{
		super();

		var size:Int = 64; // Size of each square on board
		var color1:Int = 0xff36454F;
		var color2:Int = 0xffffffff;
		var checkerPieces = new FlxTypedGroup<CheckerPiece>();

		for (y in 0...8)
		{
			// Creating Board
			for (x in 0...8)
			{
				var square:Square = new Square(x * size, y * size, size, ((x + y) % 2 == 0) ? color1 : color2);
				add(square);

				// Adding Checker Pieces
				if (y < 3)
				{
					if ((x + y) % 2 == 0)
						checkerPieces.add(new CheckerPiece(x * size, y * size, "black"));
				}
				else if (y > 4)
				{
					if ((x + y) % 2 == 0)
						checkerPieces.add(new CheckerPiece(x * size, y * size, "red"));
				}
			}
		}
		add(checkerPieces);
	}
}
