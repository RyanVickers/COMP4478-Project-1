class Queen extends ChessPiece
{
	public function new(X:Int, Y:Int, sprite:String)
	{
		super(X, Y, sprite);
		loadGraphic(sprite, true);
	}
}
