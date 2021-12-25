.ONESHELL:

PID_FILE=.salvage.pid

.PHONY=watch
watch:
	while true; do
		make run
		inotifywait -re modify --exclude '/\.' .
		sleep 1
	done

.PHONY=run
run: stop build
	hl hello.hl & \
	PID=$$!
	echo $${PID} > ${PID_FILE}

.PHONY=stop
stop:
	if test -f ${PID_FILE}; then
		PID=`cat ${PID_FILE}`
		rm -rf ${PID_FILE}
		kill -9 $$PID || true
	fi

.PHONY=build
build: hello.hl

hello.hl: assets $(wildcard src/*) compile.hxml
	haxe compile.hxml

.PHONY=assets
assets: $(wildcard res/*)

res/brobear.png: assets/brobear.png
	cp assets/brobear.png res/brobear.png

res/sandtile.png: assets/sand-tile.png
	cp assets/sand-tile.png res/sandtile.png

res/toaster.png: assets/toaster-32.png
	cp assets/toaster-32.png res/toaster.png

res/tileselector.png: assets/tile-selector.png
	cp assets/tile-selector.png res/tileselector.png

res/tileselectorgreen.png: assets/tile-selector-green.png
	cp assets/tile-selector-green.png res/tileselectorgreen.png

clean: stop
	rm -rf hello.hl
