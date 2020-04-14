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
    INSTALL="$INSTALL i3-gaps i3-scripts i3-scrot i3exit i3lock i3status-manjaro manjaro-i3-settings conky-i3 conky compton dunst rofi"
    # Term
    INSTALL="$INSTALL rxvt-unicode rxvt-unicode-terminfo urxvt-resize-font-git zsh tmux powerline"
    # Utils
    INSTALL="$INSTALL vim arandr feh nload bind-tools curl tig"
    # Dev
    INSTALL="$INSTALL python-pip docker jq aws-cli clusterssh vagrant archlinux-java-run jre10-openjdk jre8-openjdk"
    # Apps
    INSTALL="$INSTALL spotify slack-desktop google-chrome vlc keybase keybase-gui zoom"
    # Sound to use pulse
    INSTALL="$INSTALL pulseaudio pulseaudio-alsa manjaro-pulse pa-applet pavucontrol"
    # Misc (qt4 is for VLC display)
    INSTALL="$INSTALL thefuck qt4 network-manager-applet unzip"
    # Fonts
    INSTALL="$INSTALL ttf-emojione-color nerd-fonts-complete noto-fonts"
    # Modules
    INSTALL="$INSTALL linux50-virtualbox-host-modules xorg-xbacklight"

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

xdg-settings set default-web-browser google-chrome-stable.desktop

echo "Install rust"
curl https://sh.rustup.rs -sSf | sh

echo "Create development group"
sudo groupadd development
sudo usermod -aG development $USER

#echo "Install softwares in /opt"
#sudo $BASE_DIR/opt/install.sh $USER

echo "Stow configuration"
$BASE_DIR/install.sh

echo "Various config"
sed -i -e  "s/Pale Moon/google-chrome-stable/g" ~/.config/mimeapps.list
