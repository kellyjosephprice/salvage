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

		state = new State({
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
		});

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

		state.field = new Field(s2d);
		state.field.initOnClick(state);

		var selector = new Bitmap(hxd.Res.tileselector.toTile(), s2d);
		var cursor = new Bitmap(hxd.Res.tileselectorgreen.toTile(), s2d);
		var toaster = new Bitmap(hxd.Res.toaster.toTile(), s2d);
		var brobear = new Bitmap(hxd.Res.brobear.toTile(), s2d);
		state.selected.component = selector;
		state.cursor.component = cursor;
		state.units[0].component = toaster;
		state.units[1].component = brobear;

		state.field.moveTo(state.selected);
		state.field.moveTo(state.cursor);
		state.field.moveTo(state.units[0]);
		state.field.moveTo(state.units[1]);

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
		state.field.moveTo(state.selected);
		state.field.moveTo(state.cursor);
		state.field.moveTo(state.units[0]);
	}
}
