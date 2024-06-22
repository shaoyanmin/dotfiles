# Personal Dotfiles Managed by GNU Stow
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
* [Setup `.git/hooks/pre-commit`](https://akashchandwani.medium.com/what-is-gitleaks-and-how-to-use-it-a05f2fb5b034), add `exec gitleaks protect --staged -v` to the end of that file

## Config files list
* [x] bash
* [x] alacritty
* [ ] git
