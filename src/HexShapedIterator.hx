import Coordinates;

class HexShapedIterator {
	public var size: Int;
	public var current: CubeCoordinates;

	public function new(size: Int) {
		this.size = size;
		this.current = { x: -1, z: -size, y: size };
	}

	public function next(): Coordinates {
		this.current.x += 1;
		this.current.y = -this.current.x - this.current.z;

		if (this.current.distance({ x: 0, z: 0, y: 0 }) > this.size) {
			this.current.z += 1;

			if (this.current.z <= 0) {
				this.current.y = this.size;
				this.current.x = -this.current.z - this.current.y;
			} else {
				this.current.x = -this.size;
				this.current.y = -this.current.z - this.current.x;
			}
		}

		trace(this.current);

		return this.current.toOddr();
	}

	public function hasNext() {
		return !(this.current.x == 0 && this.current.z == this.size);
	}
}
