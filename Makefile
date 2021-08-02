.PHONY=dev
dev: run

.PHONY=run
run: build
	hl hello.hl

.PHONY=build
build: hello.hl

hello.hl: assets $(wildcard src/*) compile.hxml
	haxe compile.hxml

.PHONY=assets
assets: $(wildcard res/*)

res/sandtile.png: assets/sand-tile.png
	cp assets/sand-tile.png res/sandtile.png

res/trail.png: assets/trails.png
	cp assets/trails.png res/trail.png

res/toaster.png: assets/toaster-32.png
	cp assets/toaster-32.png res/toaster.png

res/tileselector.png: assets/tile-selector.png
	cp assets/tile-selector.png res/tileselector.png

res/tileselectorgreen.png: assets/tile-selector-green.png
	cp assets/tile-selector-green.png res/tileselectorgreen.png

clean:
	rm -rf hello.hl
