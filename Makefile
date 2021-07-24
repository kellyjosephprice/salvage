dev: run

run: build
	hl hello.hl

build: hello.hl

hello.hl: compile.hxml
	haxe compile.hxml
