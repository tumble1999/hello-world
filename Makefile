help:
	@echo "make [target]"
	@echo "Targets:"
	@echo "- clean - clean the enviroment"
	@echo "- linux - build for linux"
	@echo "- dos - build for dos"

build:
	mkdir build

linux: build
	cd build; cmake ..
	cmake --build ./build
.PHONY: linux

dos:
	dosbox -c "make -f targets\dos.mak"
.PHONY:dos

clean:
	rm -rf build BUILD
.PHONY: clean
