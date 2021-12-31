import buddy.*;
import utest.Assert;

class HexShapedIteratorTest extends BuddySuite {
	public function new() {
		describe("HexShapedIterator", {
			it('iterates over each coordinate in order', {
				var coords = [for(coord in new HexShapedIterator(1)) coord];
				var expected: Array<Coordinates> = [
					{ x : -1, y : -1 },
					{ x :  0, y : -1 },
					{ x : -1, y :  0 },
					{ x :  0, y :  0 },
					{ x :  1, y :  0 },
					{ x : -1, y :  1 },
					{ x :  0, y :  1 },
				];

				Assert.same(expected, coords);
			});
		});
	}
}
