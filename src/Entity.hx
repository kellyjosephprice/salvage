import h2d.Bitmap;
import h2d.col.IPoint;
import h2d.col.IPolygon;

typedef Entity = {
	coords: IPoint,
	component: Bitmap,
	?offset: IPoint,
	?polygon: IPolygon,
}
