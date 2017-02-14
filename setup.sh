#!/usr/bin/env bash

needed_packages() {
    # Check package needed
    INSTALLED=$(yaourt -Q)
    TOINSTALL=""
    for  PACKAGE in $INSTALL; do
        ISINSTALLED=$(echo "$INSTALLED" | grep "/$PACKAGE")
        if [ $? -eq 1 ]; then
            TOINSTALL="$TOINSTALL $PACKAGE"
        fi
    done

    echo "$TOINSTALL"
}

# Optional
# mytourbook_bin
install_requirements() {
    echo "- Install Requirements"
    # Dotfiles manager
    INSTALL="stow"
    # I3
    INSTALL="$INSTALL compton dunst rofi"
    # Editors
    INSTALL="$INSTALL vim"
    # Misc
    INSTALL="$INSTALL shutter"
    # ZSH
    INSTALL="zsh tmux"

    # Install needed packages
    NEEDED=$(needed_packages)
    if [  "$NEEDED" != "" ]; then
        yaourt -S $NEEDED
    fi
}

# For information, now is included in doftfiles-shell
powerlinefont(){
    # Powerline fonts installation
    rm -rf /tmp/fonts
    cd /tmp
    git clone https://github.com/powerline/fonts.git
    cd fonts
    ./install.sh
}

BASE_DIR="$( cd "$( dirname "$0" )" && pwd )"

# Install
install_requirements
powerlinefont
cd $BASE_DIR

echo "Install softwares in /opt"
sudo $BASE_DIR/opt/install.sh
$BASE_DIR/install.sh
