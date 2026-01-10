#!/bin/bash
set -e
sudo -v

sudo pacman -Syu python3 kitty zsh neovim git rclone man flameshot npm flatpak winetricks obs-studio zip unzip noto-fonts noto-fonts-emoji noto-fonts-extra discord pavucontrol steam fastfetch fakeroot --noconfirm
sudo pacman -S --needed flatpak
flatpak install flathub com.spotify.Client
flatpak install flathub org.vinegarhq.Sober
flatpak install flathub com.github.tchx84.Flatseal
flatpak install flathub org.kde.kdenlive

ZSHWAYPATH="$HOME/.zshrc"

add_alias(){
  grep -qxf "$1" "$ZSHWAYPATH" || echo "$1" >> "$ZSHWAYPATH"
}

add_alias "alias std='shutdown now'"
add_alias "alias rbt='reboot'"
add_alias "alias vi='nvim'"
add_alias "alias vim='nvim'"

#spotify script
bash <(curl -sSL https://spotx-official.github.io/run.sh)

#instalando astronvim
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak
git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim 
# remove template's git connection to set up your own later
rm -rf ~/.config/nvim/.git
nvim

rm -rf ~/yay
git clone https://aur.archlinux.org/yay.git
cd ~/yay
sudo pacman -S --needed base-devel
makepkg -si

