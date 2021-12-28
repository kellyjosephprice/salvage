import h2d.Bitmap;
import h2d.Scene;
import h2d.col.IPoint;
import h2d.col.IPolygon;

import Field;
import Coordinates;

class Main extends hxd.App {
	var state: State;

	static function main() {
		hxd.Res.initEmbed();
		new Main();
	}

	override function init():Void {
		super.init();

		s2d.scaleMode = Stretch(640, 360);

		var font:h2d.Font = hxd.res.DefaultFont.get();
		var tf = new h2d.Text(font);
		tf.text = "Salvage WIP";
		s2d.addChild(tf);

		state = {
			field: new Field(s2d),
			selected: {
				component: null,
				coords: { x: 0, y: 0 },
			},
			cursor: {
				component: null,
				coords: { x: 0, y: 0 },
			},
			units: [{
				component: null,
				coords: { x: 0, y: 0 },
				offset: { x: 16, y: 0 },
			}, {
				component: null,
				coords: { x: 0, y: -1 },
				offset: { x: 16, y: 0 },
			}],
		};

		state.field.initOnClick(state);

		var selector = new Bitmap(hxd.Res.tileselector.toTile(), s2d);
		var cursor = new Bitmap(hxd.Res.tileselectorgreen.toTile(), s2d);
		var toaster = new Bitmap(hxd.Res.toaster.toTile(), s2d);
		var brobear = new Bitmap(hxd.Res.brobear.toTile(), s2d);
		state.selected.component = selector;
		state.cursor.component = cursor;
		state.units[0].component = toaster;
		state.units[1].component = brobear;

		resolvePosition(state.selected);
		resolvePosition(state.cursor);
		resolvePosition(state.units[0]);
		resolvePosition(state.units[1]);

		function onEvent(event : hxd.Event) {
			if (event.kind == EKeyUp) { return; }

			switch(event.keyCode) {
				case 13: {
					state.units[0].coords.load(state.cursor.coords);
					state.selected.coords.load(state.cursor.coords);
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
		resolvePosition(state.selected);
		resolvePosition(state.cursor);
		resolvePosition(state.units[0]);
	}

	public function resolvePosition(entity: Entity):Void {
		var pixels = state.field.coordToPixels(entity.coords);

		entity.component.x = pixels.x + (entity.offset == null ? 0 : entity.offset.x);
		entity.component.y = pixels.y + (entity.offset == null ? 0 : entity.offset.y);
	}
}
