#!/usr/bin/env bash

BASE_DIR="$( cd "$( dirname "$0" )" && pwd )"

cd $BASE_DIR

echo "Fteychene dotfiles installation script"
echo "One day this will done with Rust, just because"

echo
echo "Updating OS"
sudo pacman -Syu

echo
echo "Install i3 utils"
sudo pacman -S i3-gaps i3-scripts i3-scrot i3exit i3lock manjaro-i3-settings conky-i3 conky compton dunst rofi i3status-rust  # i3status-manjaro

echo
echo "Install pulseaudio"
sudo pacman -S pulseaudio pulseaudio-alsa manjaro-pulse pa-applet pavucontrol

echo 
echo "Install terminal utils"
sudo pacman -S alacritty thefuck tmux powerline vim fish bash-completion
for PACKAGE in "direnv espanso"; do
    yay -S $PACKAGE
done


echo
echo "Install fonts"
sudo pacman -S noto-fonts ttf-font-awesome awesome-terminal-fonts
yay noto-fonts-emoji
yay -S powerline-fonts-git 
# nerd-fonts-complete 

echo
echo "Install tools"
sudo pacman -S nload bind-tools gping xorg-xbacklight arandr unzip curl feh tig stow

echo 
echo "Install Java"
sudo pacman -S jdk11-openjdk jdk8-openjdk jdk-openjdk
yay -S archlinux-java-run

echo 
echo "Install applications"
sudo pacman -S code spotifyd vlc signal-desktop firefox spotify-launcher
for PACKAGE in "slack-desktop zoom"; do
    yay -S $PACKAGE
done

echo

echo 
echo "Install container/virtualisation"
sudo pacman -S docker libvirt iptables-nft qemu virtualbox vagrant virt-manager
sudo usermod -aG libvirt $USER
sudo usermod -aG docker $USER

echo
for KERNEL in $(mhwd-kernel -li | tail -n +3 | awk '{print $2}' | sed 's/^ *//g'); do
echo "Install virtualbox host module for $KERNEL"
    sudo pacman -S $KERNEL-virtualbox-host-modules
done


systemctl enable libvirtd.service
systemctl enable virtlogd.service
systemctl enable virtnetworkd.socket

echo
echo "Stow configuration"
rm ~/.profile
stow profile
stow git
rm -R ~/.config/dunst
rm -R ~/.i3
stow i3
rm -R ~/.config/fish/config.fish
stow terminal
stow custom_bin
stow screenlayouts

echo
echo "Install OhMyFish"
if [ ! -d "$HOME/.local/share/omf" ]
then
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install_omf
    fish install_omf --path=$HOME/.local/share/omf--config=~/.config/omf --noninteractive
    rm -f install_omf
else
    echo "OhMyFish is already installed"
fi

echo
echo "Install brew"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

for PACKAGE in "gcc vagrant-completion jq yq starship go maven gradle docker-compose terraform packer vault"; do
    echo
    echo "Install $PACKAGE with brew"
    brew install $PACKAGE
done

echo
echo "Install Kubernetes & tooling"
echo "Install kubectl"
brew install kubectl
echo "Install "
### K3s
curl -sfL https://get.k3s.io | INSTALL_K3S_SKIP_ENABLE sh -
### Minikube
brew install minikube kind
brew install helm kustomize

echo
echo "Install rust"
curl https://sh.rustup.rs -sSf | sh
rustup component add clippy rust-docs rust-std rustfmt cargo rust-analysis
rustup toolchain add stable
rustup toolchain add nightly
cargo install cross

echo
echo "Install rust commands"
for PACKAGE in "bat exa du-dust procs fselect ytop broot fd-find sd"; do
    cargo install $PACKAGE
done

echo
echo "Install Haskell"
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

echo 
echo "Install nix"
curl -L https://nixos.org/nix/install | sh


pip3 install argcomplete

cd $BASE_DIR

echo
echo "Various config"
xdg-settings set default-web-browser firefox.desktop
sed -i -e  "s/Pale Moon/firefox/g" ~/.config/mimeapps.list
sudo pacman -R palemoon-bin

echo
echo "Create idea link to ~/.idea/idea"
mkdir ~/.idea
ln -s ~/.idea/idea ~/bin/idea


echo
echo "Automatic installation done, dont forget to follow manuel steps"
