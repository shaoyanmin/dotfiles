# This file is read each time a login shell is started.
# All other interactive shells will only read .bashrc; this is particularly
# important for language settings, see below.

test -z "$PROFILEREAD" && . /etc/profile || true

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
#export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# Some people don't like fortune. If you uncomment the following lines,
# you will have a fortune each time you log in ;-)

#if [ -x /usr/bin/fortune ] ; then
#    echo
#    /usr/bin/fortune
#    echo
#fi


# Added by Toolbox App
export PATH="$PATH:/home/ian/.local/share/JetBrains/Toolbox/scripts"

# NPM Versions Manager
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# appimage default dir
# export PATH="$HOME/Applications"

# Wayland
## Fix env vars warnning for fcitx
unset GTK_IM_MODULE
unset QT_IM_MODULE
unset SDL_IM_MODULE


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/ian/.opam/opam-init/init.sh' && . '/home/ian/.opam/opam-init/init.sh' > /dev/null 2> /dev/null || true
# END opam configuration
