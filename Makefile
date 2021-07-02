help:
	@echo "make [target]"
	@echo "Targets:"
	@echo "- clean - Clean the enviroment"
	@echo "- all - Build all targets at the same time"
	@echo "- linux - Build for linux (gcc)"
	@echo "- dos - Build for dos (djgpp)"
	@echo "- nds - Build for Nintendo DS (libnds)"
	@echo "- wii - Build for Nintendo WII (libogc)"

build:
	@mkdir build

all: linux dos nds

linux: build
	@echo "------------------------------"
	@echo "Building for $@"
	@echo "------------------------------"
	@cd build; cmake ..
	@cmake --build ./build
.PHONY: linux

dos:
	@echo "------------------------------"
	@echo "Building for $@"
	@echo "------------------------------"
	@touch LOG.TXT
	@dosbox -c "scripts\dos.bat"
	@echo "------------------------------"
	@cat LOG.TXT
	@rm LOG.TXT
.PHONY:dos

nds: build
	@echo "------------------------------"
	@echo "Building for $@"
	@echo "------------------------------"
	@make -f targets/nds.mak
.PHONY:nds

wii: build
	@echo "------------------------------"
	@echo "Building for $@"
	@echo "------------------------------"
	@make -f "targets/wii.mak"
.PHONY:wii


clean:
	rm -rf build BUILD
.PHONY: clean
