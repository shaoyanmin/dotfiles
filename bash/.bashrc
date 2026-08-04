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

# Terminal title:
# - Local shell: Git repository root, or current directory outside Git.
# - Interactive SSH: SSH alias/IP from the local SSH config.
# - Restore local title immediately after SSH disconnects.

_set_terminal_title() {
    [[ -t 1 ]] || return

    # Write directly to the terminal so SSH/rsync stdout stays clean.
    printf '\033]0;%s\007' "$1" > /dev/tty
}

_update_terminal_title() {
    local title_path

    title_path="$(git rev-parse --show-toplevel 2>/dev/null)" ||
        title_path="$PWD"

    # Collapse the home directory to ~.
    case "$title_path" in
        "$HOME")
            title_path='~'
            ;;
        "$HOME"/*)
            title_path="~${title_path#"$HOME"}"
            ;;
    esac

    _set_terminal_title "$title_path"
}

# Wrap directly invoked SSH sessions.
# rsync, scp and non-terminal SSH calls do not trigger this.
ssh() {
    local ssh_config remote_user remote_host status

    if [[ -t 1 ]]; then
        ssh_config="$(command ssh -G "$@" 2>/dev/null)"

        remote_user="$(
            awk '$1 == "user" { print $2; exit }' <<<"$ssh_config"
        )"

        # "host" preserves the SSH alias; if no alias is used, it is the IP/host.
        remote_host="$(
            awk '$1 == "host" { print $2; exit }' <<<"$ssh_config"
        )"

        _set_terminal_title \
            "SSH: ${remote_user:+${remote_user}@}${remote_host:-unknown}"
    fi

    command ssh "$@"
    status=$?

    # Restore Git/path title immediately after disconnecting.
    _update_terminal_title

    return "$status"
}

# Run last so the local title stays synchronized after every command.
case ";${PROMPT_COMMAND:-};" in
    *";_update_terminal_title;"*) ;;
    *)
        PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND;}_update_terminal_title"
        ;;
esac

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


# Android Studio
export ANDROID_HOME=$HOME/Android/Sdk
# Deprecated but still used by some older tools to find the .android folder
export ANDROID_SDK_HOME=$HOME

# Add SDK tools to PATH
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

# Flutter
export PATH="$HOME/fvm/bin:$PATH"
# >>> xmake >>>
test -f "/home/ian/.xmake/profile" && source "/home/ian/.xmake/profile"
# <<< xmake <<<


# Added by Antigravity CLI installer
export PATH="/home/ian/.local/bin:$PATH"
