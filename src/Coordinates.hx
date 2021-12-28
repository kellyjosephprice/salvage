import h2d.col.IPoint;

@:structInit class Coordinates extends IPoint {
	public function new(x: Int, y: Int) {
		super();

		this.x = x;
		this.y = y;
	}
}
