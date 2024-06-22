tree:
	tree -a  -I '.git' .

example:
	stow -n -t ~/ -vv bash

.PHONY: tree example
