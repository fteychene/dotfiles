export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export EDITOR="/usr/bin/vim"
export BROWSER="firefox"

export TERM=xterm

export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export PATH="$HOME/bin:$PATH"


export JAVA_HOME=/usr/lib/jvm/default
export PATH="$JAVA_HOME/bin:$PATH"

if [ -d "$HOME/.cargo" ]
then
    . "$HOME/.cargo/env"
fi

if [ -f "$HOME/.secrets" ]
then
    . "$HOME/.secrets"
fi