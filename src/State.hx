import Field;

@:structInit class State {
	public var field(default, default): Field;
	public var selected(default, default): Entity;
	public var cursor(default, default): Entity;
	public var path(default, default): Array<Entity>;
	public var units(default, default): Array<Entity>;
}
