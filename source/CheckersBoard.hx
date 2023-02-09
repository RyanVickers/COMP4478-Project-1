import flixel.group.FlxGroup;

class CheckersBoard extends FlxGroup
{
	var checkerPieces:FlxTypedGroup<CheckerPiece> = new FlxTypedGroup<CheckerPiece>();
	var size:Int = 64; // Size of each square on board
	public function new()
	{
		super();
		var color1:Int = 0xff36454F;
		var color2:Int = 0xffffffff;

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
						checkerPieces.add(new CheckerPiece(x * size, y * size, "black",this));
				}
				else if (y > 4)
				{
					if ((x + y) % 2 == 0)
						checkerPieces.add(new CheckerPiece(x * size, y * size, "red",this));
				}
			}
		}
		add(checkerPieces);
	}

	//check if a move is valid and if so then move the piece and if its a jump them remove the jumped piece
	public function validateAndMovePiece(piece:CheckerPiece, newX:Int, newY:Int):Bool{
		var allPieces = checkerPieces.members;
		//check if the desire new spot is taken, if so then move is invalid
		for(i in 0...allPieces.length){
			if (allPieces[i].x==newX && allPieces[i].y==newY){
				return false;
			}
		}
		var xDir = newX-piece.x;//get the x offset from current location to desired location
		var yDir = newY-piece.y;//get the y offset from current location to desired location
		trace("xDir: "+ xDir+" yDir: "+yDir);
		//check if direction is valid
		if(!piece.isKing){
			if(piece.pieceColor=="red" && yDir>0){
				//red pieces cant move down if theyre not kings so move is invalid
				trace("//red pieces cant move down if theyre not kings so move is invalid");
				return false;
			}
			else if(piece.pieceColor=="black" && yDir<0){
				//black pieces cant move up if theyre not kings so move is invalid
				trace("//black pieces cant move up if theyre not kings so move is invalid");
				return false;
			}
		}
		
		//check if the desired spot is 1 diagonal square away aka no jump
		if(Math.abs(xDir)==size && Math.abs(yDir)==size){
			//if the piece is kinged we dont have to check if the direction is valid, just move it
			piece.x = newX;
			piece.y = newY;
			return true;
		}
		//check if the desired spot is 2 diagonal squares away aka jump
		else if(Math.abs(xDir)==size*2 && Math.abs(yDir)==size*2){
			//check if theres a piece in between current location and desired location. i.e. is it a valid jump
			var jumpPieceX = piece.x + xDir/2;
			var jumpPieceY = piece.y + yDir/2;
			var jumpPiece:CheckerPiece=null;
			for(i in 0...allPieces.length){
				if (allPieces[i].x==jumpPieceX && allPieces[i].y==jumpPieceY){
					jumpPiece = allPieces[i];
				}
			}

			//if a jump piece was found and its the opposite color from the piece making the jump then the move is valid
			if(jumpPiece==null){
				trace("Jump piece not found");
				return false;
			}
			else if(piece.pieceColor!=jumpPiece.pieceColor){
				//make the move and delete the jumped piece
				piece.x=newX;
				piece.y=newY;
				checkerPieces.remove(jumpPiece,true);
				return true;
			}
		}
		return false;
	}
}
