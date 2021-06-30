help:
	@echo "make [target]"
	@echo "Targets:"
	@echo "- clean - clean the enviroment"

build:
	mkdir build

clean:
	rm -rf build
.PHONY: clean
