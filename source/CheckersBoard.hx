import flixel.group.FlxGroup;

class CheckersBoard extends FlxGroup
{
	public function new()
	{
		super();

		var size:Int = 64; // Size of each square on board
		var color1:Int = 0xff000000;
		var color2:Int = 0xff900202;

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
						// Using Bishops for now
						add(new CheckerPiece(x * size, y * size, AssetPaths.b_king__png));
				}
				else if (y > 4)
				{
					if ((x + y) % 2 == 0)
						add(new CheckerPiece(x * size, y * size, AssetPaths.w_bishop__png));
				}
			}
		}
	}
}
