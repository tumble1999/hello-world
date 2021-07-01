help:
	@echo "make [target]"
	@echo "Targets:"
	@echo "- clean - clean the enviroment"
	@echo "- linux - build for linux (gcc)"
	@echo "- dos - build for dos (djgpp)"
	@echo "- nds - build for Nintendo DS (libnds)"

build:
	mkdir build

linux: build
	cd build; cmake ..
	cmake --build ./build
.PHONY: linux

dos:
	dosbox -c "make -f targets\dos.mak"
.PHONY:dos

nds: build
	@echo "Make $@"
	make -f targets/nds.mak
.PHONY:dos


clean:
	rm -rf build BUILD
.PHONY: clean
