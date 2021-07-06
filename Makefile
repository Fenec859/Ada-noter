compile:
	mkdir -p ./obj
	gprbuild -Pnoter
	@echo "Compiled succesfully"
run:
	./noter