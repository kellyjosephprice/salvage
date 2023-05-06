import scenes.Demo;

class Main extends hxd.App {
	var scene: scenes.Demo;

	static function main() {
		hxd.Res.initEmbed();
		new Main();
	}

	override function init():Void {
		super.init();

		s2d.scaleMode = Stretch(640, 360);

		var font:h2d.Font = hxd.res.DefaultFont.get();
		var tf = new h2d.Text(font);
		tf.text = "Salvage (wip)";
		s2d.addChild(tf);

		scene = new Demo(s2d);
	}

	override function update(dt:Float) {
		scene.update();
	}
}
