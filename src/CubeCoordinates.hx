import Coordinates;

// https://www.redblobgames.com/grids/hexagons/#coordinates
@:structInit class CubeCoordinates {
	public var x:Int;
	public var y:Int;
	public var z:Int;

	public static function from(obj) {
		return new CubeCoordinates(obj.x, obj.y, obj.z);
	}

	public function new(x:Int, y:Int, z:Int) {
		this.x = x;
		this.y = y;
		this.z = z;
	}

	public function toOddr():Coordinates {
		var col:Int = this.x + Std.int((this.z - (this.z & 1)) / 2);
		var row:Int = this.z;
		var coords:Coordinates = { x: col, y: row };

		return coords;
	}

	public function distance(other: CubeCoordinates):Int {
		var distance:Float = (Math.abs(this.x - other.x) + Math.abs(this.y - other.y) + Math.abs(this.z - other.z)) / 2;

		return Std.int(distance);
	}

	public function toString() {
		return '${Type.getClass(this)} { x : ${this.x}, y : ${this.y}, z : ${this.z} }';
	}
}
