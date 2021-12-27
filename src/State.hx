import Field;
import Coordinates;

typedef StateProps = {
	field: Field,
	selected: Entity,
	cursor: Entity,
	units: Array<Entity>,
};

class State {
	public var field(default, default): Field;
	public var selected(default, default): Entity;
	public var cursor(default, default): Entity;
	public var units(default, default): Array<Entity>;

	public function new(props: StateProps) {
		this.field = props.field;
		this.selected = props.selected;
		this.cursor = props.cursor;
		this.units = props.units;
	}

	public function set_field(field) return field;
}
