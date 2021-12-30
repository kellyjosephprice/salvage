.ONESHELL:

PID_FILE=.salvage.pid

define watch-loop
while true; do
	printf "\033c"
	echo $(1)
	sleep 0.5
	$(2)
	inotifywait -qre modify --exclude '/\.' .
done
endef

.PHONY: watch
watch:
	$(call watch-loop, Starting Salvage!, make run)

.PHONY: run
run: stop build
	hl salvage.hl &
	PID=$$!
	echo $${PID} > ${PID_FILE}

.PHONY: stop
stop:
	if test -f ${PID_FILE}; then
		PID=`cat ${PID_FILE}`
		rm -rf ${PID_FILE}
		kill -9 $$PID || true
	fi

.PHONY: build
build: salvage.hl

.PHONY: watch-tests
watch-tests:
	$(call watch-loop, Running tests..., make tests)

.PHONY: tests
tests: tests.hl
	hl tests.hl

tests.hl: tests.hxml $(wildcard src/*) $(wildcard tests/*)
	haxe tests.hxml

.PHONY: deps
deps:
	haxelib install all

salvage.hl: assets $(wildcard src/*) compile.hxml
	@echo -n "\033[31m"
	haxe compile.hxml
	@echo -n "\033[0m"

.PHONY: assets
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

.PHONY: clean
clean: stop
	rm -rf salvage.hl
	rm -rf tests.hl
