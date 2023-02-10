class Bishop extends ChessPiece
{
	public function new(X:Int, Y:Int, sprite:String, pieceColor:String, board:ChessBoard)
	{
		super(X, Y, sprite, pieceColor, board);
		loadGraphic(sprite, true);
	}

	override public function getType():String
	{
		return "bishop";
	}
}
