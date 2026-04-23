# Personal Dotfiles Managed by GNU Stow
## Git submodules
This repository uses git submodules for some configurations. After cloning, run:
```bash
git submodule update --init --recursive
```

## Stow cheatsheet
```bash
# Dry run commands
stow -n <OPTIONS>

# Remove all links
stow -D

# Link config files
stow -n -t ~/ -vv <PACKAGE_NAME>
```

## Use Gitleaks to detect sensitive files
* Install Gitleaks
* Install Python3 tool `pre-commit`
* [Setup `.pre-commit-config.yaml`](https://github.com/gitleaks/gitleaks/tree/master?tab=readme-ov-file#pre-commit)

## Config files list
* [x] bash
* [x] alacritty
* [x] git
* [x] Emacs server daemon
* [x] GIMP (Photoshop keymap)
