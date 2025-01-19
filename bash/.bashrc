# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

export PS1="\[$(tput setaf 104)\]\u\[$(tput setaf 8)\]@\[$(tput setaf 104)\]\h \[$(tput setaf 105)\]\w \[$(tput sgr0)\]$ "

test -s ~/.alias && . ~/.alias || true
test -s ~/.envars && . ~/.envars || true

eval "$(zoxide init bash --cmd j)"

export EDITOR="emacsclient -nw"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# amber-lang.com
export PATH="$VOLTA_HOME/bin:$PATH:~/.local/bin"

# https://yazi-rs.github.io/docs/quick-start/
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# pnpm
export PNPM_HOME="/home/ian/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
