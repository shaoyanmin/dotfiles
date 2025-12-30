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

# export EDITOR="emacsclient -nw"
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
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"


# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin


# >>> xmake >>>
test -f "$HOME/.xmake/profile" && source "$HOME/.xmake/profile"
# <<< xmake <<<

# Android Studio
export ANDROID_HOME=$HOME/Android/Sdk

# Add SDK tools to PATH
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

# Flutter
export PATH="$HOME/fvm/bin:$PATH"
