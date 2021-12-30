import buddy.*;
import utest.Assert;

import h2d.col.IPoint;
import CubeCoordinates;
import Coordinates;

class CubeCoordinatesTest extends BuddySuite {
	public function new() {
		describe("CubeCoordinates", {
			describe(".toOddr()", {
				var tests: Array<Dynamic> = [
					[{ x:  0, y:  0, z:  0 }, { x:  0, y:  0 }],
					[{ x:  1, y: -1, z:  0 }, { x:  1, y:  0 }],
					[{ x:  1, y:  0, z: -1 }, { x:  0, y: -1 }],
					[{ x:  0, y:  1, z: -1 }, { x: -1, y: -1 }],
					[{ x: -1, y:  1, z:  0 }, { x: -1, y:  0 }],
					[{ x: -1, y:  0, z:  1 }, { x: -1, y:  1 }],
					[{ x:  0, y: -1, z:  1 }, { x:  0, y:  1 }],
				];

				for(test in tests) {
					var actual = CubeCoordinates.from(test[0]);
					var expected = Coordinates.from(test[1]);

					it('converts ${actual} -> ${expected}', {
						Assert.same(expected, actual.toOddr());
					});
				}
			});

			describe(".distance(other)", {
				var tests: Array<Dynamic> = [
					[{ x:  0, y:  0, z:  0 }, 0],
					[{ x:  1, y: -1, z:  0 }, 1],
					[{ x:  2, y:  1, z: -3 }, 3],
				];

				for(test in tests) {
					var origin = new CubeCoordinates(0, 0 ,0);
					var actual = CubeCoordinates.from(test[0]);
					var expected = test[1];

					it('calculates ${actual} -> ${Std.string(expected)}', {
						Assert.same(expected, origin.distance(actual));
					});
				}
			});
		});
	}
}
