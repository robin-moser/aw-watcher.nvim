.PHONY: test
test:
	@nvim -l tests/minit.lua tests

.PHONY: run
run:
	@nvim -u ./tests/minit.lua

