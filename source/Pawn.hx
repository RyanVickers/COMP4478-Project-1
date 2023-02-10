class Pawn extends ChessPiece
{
	var hasMoved:Bool = false;

	public function new(X:Int, Y:Int, sprite:String, pieceColor:String, board:ChessBoard)
	{
		super(X, Y, sprite, pieceColor, board);
		loadGraphic(sprite, true);
	}

	override public function getType():String
	{
		return "pawn";
	}

	override public function isFirstMove():Bool
	{
		return !hasMoved;
	}

	override public function setMoved()
	{
		hasMoved = true;
	}
}
