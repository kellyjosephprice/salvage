import Field;
import Coordinates;

@:structInit class State {
	public var field(default, default): Field;
	public var selected(default, default): Entity;
	public var cursor(default, default): Entity;
	public var units(default, default): Array<Entity>;
}
