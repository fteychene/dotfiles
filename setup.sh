#!/usr/bin/env bash

needed_packages() {
    # Check package needed
    INSTALLED=$(yaourt -Q)
    TOINSTALL=""
    for PACKAGE in $INSTALL; do
        ISINSTALLED=$(echo "$INSTALLED" | grep "/$PACKAGE")
        if [ $? -eq 1 ]; then
            TOINSTALL="$TOINSTALL $PACKAGE"
        fi
    done

    echo "$TOINSTALL"
}

install_requirements() {
    echo "- Install Requirements"
    # Dotfiles manager
    INSTALL="stow"
    # Display (i3)
    INSTALL="$INSTALL i3-gaps i3-scripts i3-scrot i3exit i3lock i3status-manjaro manjaro-i3-settings conky-i3 conky compton dunst rofi network-manager-applet"
    # Term
    INSTALL="$INSTALL rxvt-unicode rxvt-unicode-terminfo zsh tmux tmuxinator powerline"
    # Utils
    INSTALL="$INSTALL vim arandr feh glances nload bind-tools curl tig"
    # Dev
    INSTALL="$INSTALL python-pip docker jq aws-cli clusterssh"
    # Apps
    INSTAL="$INSTALL spotify slack-desktop atom google-chrome vlc"
    # Misc (GT4 is for layoutingVLC in a window cause apparretly i3 can't manage it solo)
    INSTAL="$INSTALL thefuck epson-inkjet-printer-escpr qt4"

    # Install needed packages
    NEEDED=$(needed_packages)
    if [  "$NEEDED" != "" ]; then
        for PACKAGE in $NEEDED; do
          yaourt -S $PACKAGE
        done
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
