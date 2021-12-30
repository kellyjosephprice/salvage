import h2d.col.IPoint;

@:structInit class Coordinates extends IPoint {
	public static function from(obj) {
		return new Coordinates(obj.x, obj.y);
	}

	public function new(x: Int, y: Int) {
		super();

		this.x = x;
		this.y = y;
	}

	public override function toString() {
		return '${Type.getClass(this)} { x : ${this.x}, y : ${this.y} }';
	}
}
