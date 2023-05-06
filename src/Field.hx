import h2d.Scene;
import h2d.Bitmap;
import h2d.col.IPoint;
import h2d.col.IPolygon;
import haxe.ds.ObjectMap;

import Entity;
import utils.Coordinates;
import utils.HexShapedIterator;

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
			var interaction = new h2d.Interactive(64, 36, this.s2d, entity.polygon.toPolygon().getCollider());

			interaction.onClick = function(event: hxd.Event) {
				trace('coords', coords);
				trace('state', state);
				if (state.cursor.coords.equals(coords)) {
					state.selected.coords.load(coords);
					state.units[0].coords.load(coords);
				} else {
					state.cursor.coords.load(coords);
				}
			}
		}

		return this;
	}

	public function coordToPixels(coords: Coordinates): Coordinates {
		var colOffset:Int = Math.abs(coords.y) % 2 == 1 ? 0 : - 32;

		return {
			x: Std.int(this.s2d.width / 2) + coords.x * 64 + colOffset,
			y: Std.int(this.s2d.height / 2) + coords.y * 30 - 16,
		};
	}

	override public function toString(): String {
		return [for(coords in this.keys()) '[$coords, ${this.get(coords)}]']
			.join("\n");
	}
}
