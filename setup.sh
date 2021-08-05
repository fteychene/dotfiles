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
echo "Install fonts"
sudo pacman -S powerline-fonts  
# nerd-fonts-complete noto-fonts ttf-font-awesome awesome-terminal-fonts 

echo 
echo "Install terminal utils"
sudo pacman -S alacritty thefuck tmux powerline vim
for PACKAGE in "direnv espanso"; do
    yay -S $PACKAGE
done

echo
echo "Install Oh-My-Fish"
curl -L https://get.oh-my.fish | fish
omf install spark
omf install weather
omf install agnoster
omf theme agnoster

echo
echo "Install tools"
sudo pacman -S nload bind-tools gping xorg-xbacklight arandr unzip curl feh tig stow

echo 
echo "Install Java"
sudo pacman -S jdk11-openjdk jdk8-openjdk jdk-openjdk
yay -S archlinux-java-run

echo 
echo "Install applications"
sudo pacman -S code spotifyd vlc signal-desktop
for PACKAGE in "spotify slack-desktop zoom"; do
    yay -S $PACKAGE
done

echo 
echo "Install container/virtualisation"
sudo pacman -S docker libvirt virtualbox linux510-virtualbox-host-modules linux512-virtualbox-host-modules vagrant
sudo usermod -aG libvirt $USER
sudo usermod -aG docker $USER

echo
echo "Stow configuration"
stow profile
stow git
stow i3
stow terminal
stow custom_bin
stow screenlayouts

source ~/.profile

echo
echo "Install brew"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo
echo "Install various with brew"
for PACKAGE in "gcc vagrant-completion jq yq starship go maven gradle docker-compose"; do
    brew install $PACKAGE
done

echo
echo "Install hashicorp tools with brew"
for PACKAGE in "terraform packer vault "; do
    yay -S $PACKAGE
done

echo
echo "Install Kubernetes tooling"
brew install kubectl
### Kubectl completion
mkdir -p ~/.config/completions/
git clone https://github.com/evanlucas/fish-kubectl-completions ~/.config/completions/fish-kubectl-completions
ln -s ~/.config/completions/fish-kubectl-completions/completions/kubectl.fish ~/.config/fish/kubectl.fish
### K3s
curl -sfL https://get.k3s.io | sh -

echo
echo "Install rust"
curl https://sh.rustup.rs -sSf | sh
rustup component add clippy rust-docs rust-std rustfmt cargo
rustup toolchain add stable
rustup toolchain add nightly
cargo install cross

echo
echo "Install rust commands"
for PACKAGE in "exa du-dust procs fselect ytop broot fd-find sd"; do
    cargo install $PACKAGE
done

echo
echo "Install Haskell"
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

echo 
echo "Install nix"
curl -L https://nixos.org/nix/install | sh

cd $BASE_DIR

echo
echo "Various config"
xdg-settings set default-web-browser firefox.desktop
sed -i -e  "s/Pale Moon/firefox/g" ~/.config/mimeapps.list
cp materialdesignicons-webfont.ttf   /usr/local/share/fonts/

echo
echo "Automatic installation done, dont forget to follow manuel steps"




