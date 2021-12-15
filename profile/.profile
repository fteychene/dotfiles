export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export EDITOR="/usr/bin/vim"
export BROWSER="firefox"

export TERM=xterm
. "$HOME/.cargo/env"
. "$HOME/.nix-profile/etc/profile.d/nix.sh"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.gcloud-sdk/bin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export PATH="$HOME/bin:$PATH"

export JAVA_HOME=/usr/lib/jvm/default
export PATH="$JAVA_HOME/bin:$PATH"