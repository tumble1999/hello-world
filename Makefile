help:
	@echo "make [target]"
	@echo "Targets:"
	@echo "- clean - clean the enviroment"
	@echo "- linux - build for linux"

build:
	mkdir build

linux: build
	cd build; cmake ..
	cmake --build ./build
.PHONY: linux

clean:
	rm -rf build
.PHONY: clean
