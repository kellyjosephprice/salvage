import h2d.Bitmap;
import h2d.Scene;
import h2d.col.IPoint;
import h2d.col.IPolygon;
import Field;
import Coordinates;

typedef State = {
	field: Field,
	selected: Entity,
	cursor: Entity,
	units: Array<Entity>,
};

class Main extends hxd.App {
	var state: State;

	static function main() {
		hxd.Res.initEmbed();
		new Main();
	}

	override function init():Void {
		super.init();

		s2d.scaleMode = Stretch(640, 360);
		//s2d.scaleMode = Stretch(960, 540);
		//s2d.scaleMode = Stretch(1280, 720);

		var font:h2d.Font = hxd.res.DefaultFont.get();
		var tf = new h2d.Text(font);
		tf.text = "Salvage WIP";
		s2d.addChild(tf);

		state = {
			field: null,
			selected: {
				component: null,
				coords: new IPoint(0, 0),
			},
			cursor: {
				component: null,
				coords: new IPoint(0, 0),
			},
			units: [{
				component: null,
				coords: new IPoint(0, 0),
				offset: new IPoint(16, 0),
			}, {
				component: null,
				coords: new IPoint(0, -1),
				offset: new IPoint(16, 0),
			}],
		};

		var polygon = new IPolygon([
			new IPoint(1, 14),
			new IPoint(31, 4),
			new IPoint(32, 4),
			new IPoint(62, 14),
			new IPoint(62, 29),
			new IPoint(32, 39),
			new IPoint(31, 39),
			new IPoint(1, 29),
		]);

		var field = new Field();
		for(coords in new HexShapedIterator(4)) {
			var tile = new Bitmap(hxd.Res.sandtile.toTile(), s2d);
			var pixels = coordToPixels(coords);

			tile.x = pixels.x;
			tile.y = pixels.y;

			var points: Array<IPoint> = [];
			for(point in polygon) {
				points.push(point.add(pixels));
			}

			var entity: Entity = {
				coords: coords,
				component: tile,
				polygon: new IPolygon(points),
			};
			field.set(coords, entity);

			var interaction = new h2d.Interactive(64, 36, s2d, entity.polygon.toPolygon().getCollider());
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

		state.field = field;

		var selector = new Bitmap(hxd.Res.tileselector.toTile(), s2d);
		var cursor = new Bitmap(hxd.Res.tileselectorgreen.toTile(), s2d);
		var toaster = new Bitmap(hxd.Res.toaster.toTile(), s2d);
		var brobear = new Bitmap(hxd.Res.brobear.toTile(), s2d);
		state.selected.component = selector;
		state.cursor.component = cursor;
		state.units[0].component = toaster;
		state.units[1].component = brobear;

		moveTo(state.selected);
		moveTo(state.cursor);
		moveTo(state.units[0]);
		moveTo(state.units[1]);

		function onEvent(event : hxd.Event) {
			if (event.kind == EKeyUp) { return; }

			switch(event.keyCode) {
				case 13: {
					state.units[0].coords.x = state.cursor.coords.x;
					state.units[0].coords.y = state.cursor.coords.y;
					state.selected.coords.x = state.cursor.coords.x;
					state.selected.coords.y = state.cursor.coords.y;
				}
				case 37: state.cursor.coords.x -= 1;
				case 38: state.cursor.coords.y -= 1;
				case 39: state.cursor.coords.x += 1;
				case 40: state.cursor.coords.y += 1;
			}
		}
		hxd.Window.getInstance().addEventTarget(onEvent);
	}

	override function update(dt:Float) {
		moveTo(state.selected);
		moveTo(state.cursor);
		moveTo(state.units[0]);
	}

	private function moveTo(entity: Entity):Void {
		var pixels = coordToPixels(entity.coords);

		entity.component.x = pixels.x + (entity.offset == null ? 0 : entity.offset.x);
		entity.component.y = pixels.y + (entity.offset == null ? 0 : entity.offset.y);
	}

	private function coordToPixels(coords: IPoint): IPoint {
		var colOffset:Int = Math.abs(coords.y) % 2 == 1 ? 0 : - 32;

		return new IPoint(Std.int(s2d.width / 2) + coords.x * 64 + colOffset,
				Std.int(s2d.height / 2) + coords.y * 30 - 16);
	}
}
