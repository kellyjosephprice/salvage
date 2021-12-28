import h2d.Bitmap;
import h2d.col.IPoint;
import h2d.col.IPolygon;

import Coordinates;

@:structInit class Entity {
	public var component: Bitmap;
	public var coords: Coordinates;
	@:optional public var offset: Coordinates;
	@:optional public var polygon: IPolygon;
}
