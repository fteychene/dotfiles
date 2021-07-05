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

# stow
# nload bind-tools gping xorg-xbacklight arandr unzip curl
# alacritty thefuck tmux powerline vim tig curl direnv espanso
# i3-gaps i3-scripts i3-scrot i3exit i3lock i3status-manjaro manjaro-i3-settings feh conky-i3 conky compton dunst rofi i3status-rust
# archlinux-java-run jre11-openjdk jre8-openjdk jre-openjdk
# code spotifyd spotify slack-desktop vlc zoom signal-desktop
# pulseaudio pulseaudio-alsa manjaro-pulse pa-applet pavucontrol
# linux510-virtualbox linux512-virtualbox
# nerd-fonts-complete noto-fonts ttf-font-awesome 
# docker vagrant clusterssh

### Brew
# gcc go vagrant-completion jq yq
# terraform packer vault 
# k3sup kubectl
# starship 
# maven gradle

# curl -L https://get.oh-my.fish | fish

### cargo install
# exa exa du-dust procs fselect ytop broot fd-find sd

install_requirements() {
    echo "- Install Requirements"
    # Dotfiles manager
    INSTALL="stow"
    # Display (i3)
    INSTALL="$INSTALL i3-gaps i3-scripts i3-scrot i3exit i3lock i3status-manjaro manjaro-i3-settings conky-i3 conky compton dunst rofi network-manager-applet"
    # Term
    INSTALL="$INSTALL rxvt-unicode rxvt-unicode-terminfo urxvt-resize-font-git zsh tmux powerline"
    # Utils
    INSTALL="$INSTALL vim arandr feh nload bind-tools curl tig"
    # Dev
    INSTALL="$INSTALL python-pip docker jq aws-cli clusterssh vagrant archlinux-java-run jre11-openjdk jre8-openjdk code"
    # Apps
    INSTALL="$INSTALL spotifyd spotify slack-desktop vlc zoom google-chrome"
    # Sound to use pulse
    INSTALL="$INSTALL pulseaudio pulseaudio-alsa manjaro-pulse pa-applet pavucontrol"
    # Misc (qt4 is for VLC display)
    INSTALL="$INSTALL qt4 "
    # Fonts
    INSTALL="$INSTALL nerd-fonts-complete noto-fonts ttf-font-awesome"
    # Modules
    INSTALL="$INSTALL linux50-virtualbox-host-modules xorg-xbacklight"

    # Install needed packages
    NEEDED=$(needed_packages)
    if [  "$NEEDED" != "" ]; then
        for PACKAGE in $NEEDED; do
          yay -S $PACKAGE
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

nerdfont() {
    rm -rf /tmp/nerd-fonts
    cd /tmp
    git clone git@github.com:ryanoasis/nerd-fonts.git
    cd nerd-fonts
    ./install.sh
}

BASE_DIR="$( cd "$( dirname "$0" )" && pwd )"

# Install
install_requirements
powerlinefont
nerdfont
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
sed -i -e  "s/Pale Moon/firefox/g" ~/.config/mimeapps.list
