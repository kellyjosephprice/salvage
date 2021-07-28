import h2d.Bitmap;
import h2d.col.IPoint;
import h2d.col.IPolygon;
import haxe.ds.ObjectMap;

typedef Entity = {
	coords: IPoint,
	component: Bitmap,
	?offset: IPoint,
	?polygon: IPolygon,
}

class Field extends ObjectMap<IPoint, Entity> {
}
