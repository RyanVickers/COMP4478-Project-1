class Knight extends ChessPiece
{
	public function new(X:Int, Y:Int, sprite:String, pieceColor:String, isAlive:Bool, board:ChessBoard)
	{
		super(X, Y, sprite, pieceColor, isAlive, board);
		loadGraphic(sprite, true);
	}

	override public function getType():String
	{
		return "knight";
	}
}
