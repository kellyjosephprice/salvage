package scenes;

import h2d.Bitmap;
import h2d.Scene;

import Field;

class Demo {
	var state: State;
	var s2d: Scene;

	public function new(s2d) {
		state = {
			field: new Field(s2d),
			selected: {
				component: new Bitmap(hxd.Res.tileselector.toTile(), s2d),
				coords: { x: 0, y: 0 },
			},
			cursor: {
				component: new Bitmap(hxd.Res.tileselectorgreen.toTile(), s2d),
				coords: { x: 0, y: 0 },
				offset: { x: 0, y: -1 },
			},
			path: [{
				component: new Bitmap(hxd.Res.pathdotgreen.toTile(), s2d),
				coords: { x: -1, y: -1 },
				offset: { x: 3, y: -8 },
			}],
			units: [{
				component: new Bitmap(hxd.Res.toaster.toTile(), s2d),
				coords: { x: 0, y: 0 },
				offset: { x: 16, y: 0 },
			}, {
				component: new Bitmap(hxd.Res.brobear.toTile(), s2d),
				coords: { x: 0, y: -1 },
				offset: { x: 16, y: 0 },
			}],
		};

		state.field.initOnClick(state);

		resolvePosition(state.selected);
		resolvePosition(state.cursor);

		for (unit in state.units) {
			resolvePosition(unit);
		}

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

	public function update() {
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
