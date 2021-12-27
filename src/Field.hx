import h2d.Scene;
import h2d.Bitmap;
import h2d.col.IPoint;
import h2d.col.IPolygon;
import haxe.ds.ObjectMap;

import Entity;

class Field extends ObjectMap<IPoint, Entity> {
	static var hex(default, null): IPolygon = new IPolygon([
		new IPoint(1, 14),
		new IPoint(31, 4),
		new IPoint(32, 4),
		new IPoint(62, 14),
		new IPoint(62, 29),
		new IPoint(32, 39),
		new IPoint(31, 39),
		new IPoint(1, 29),
	]);

	public var s2d(default, null): Scene;

	public function new(s2d) {
		super();

		this.s2d = s2d;

		for(coords in new HexShapedIterator(4)) {
			var tile = new Bitmap(hxd.Res.sandtile.toTile(), s2d);
			var pixels = this.coordToPixels(coords);

			tile.x = pixels.x;
			tile.y = pixels.y;

			var points: Array<IPoint> = [];
			for(point in hex) {
				points.push(point.add(pixels));
			}

			var entity: Entity = {
				coords: coords,
				component: tile,
				polygon: new IPolygon(points),
			};
			this.set(coords, entity);
		}
	}

	public function initOnClick(state: State) {
		for(coords in this.keys()) {
			var entity = this.get(coords);

			trace("s2d", this.s2d);
			trace("entity", entity);
			var interaction = new h2d.Interactive(64, 36, this.s2d, entity.polygon.toPolygon().getCollider());
			interaction.onClick = function(event: hxd.Event) {
				if (state.cursor.coords.x == coords.x && state.cursor.coords.y == coords.y) {
					state.selected.coords.x = coords.x;
					state.selected.coords.y = coords.y;
					state.units[0].coords.x = coords.x;
					state.units[0].coords.y = coords.y;
				} else {
					state.cursor.coords.x = coords.x;
					state.cursor.coords.y = coords.y;
				}
			}
		}
	}

	public function coordToPixels(coords: IPoint): IPoint {
		var colOffset:Int = Math.abs(coords.y) % 2 == 1 ? 0 : - 32;

		return new IPoint(Std.int(this.s2d.width / 2) + coords.x * 64 + colOffset,
				Std.int(this.s2d.height / 2) + coords.y * 30 - 16);
	}

	public function moveTo(entity: Entity):Void {
		var pixels = coordToPixels(entity.coords);

		entity.component.x = pixels.x + (entity.offset == null ? 0 : entity.offset.x);
		entity.component.y = pixels.y + (entity.offset == null ? 0 : entity.offset.y);
	}
}
