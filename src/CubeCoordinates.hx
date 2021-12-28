import Coordinates;

// https://www.redblobgames.com/grids/hexagons/#coordinates
@:structInit class CubeCoordinates {
	public var x:Int;
	public var y:Int;
	public var z:Int;

	public function new(x:Int, y:Int, z:Int) {
		this.x = x;
		this.y = y;
		this.z = z;
	}

	public function toOddr():Coordinates {
		var col:Int = this.x + Std.int((this.z - (this.z & 1)) / 2);
		var row:Int = this.z;
		var coords:Coordinates = { x: col, y: row };

		trace('toOddr', coords);

		return coords;
	}

	public function distance(other: CubeCoordinates):Int {
		var distance:Float = (Math.abs(this.x - other.x) + Math.abs(this.y - other.y) + Math.abs(this.z - other.z)) / 2;

		return Std.int(distance);
	}

	public function toString() {
		return 'CubeCoordinates [${this.x}, ${this.y}, ${this.z}]';
	}
}
