#!/bin/bash
set -e
sudo -v

#DEFINE SHELL COMO BASH
if [ "$SHELL" != "$(which bash)" ]; then 
  chsh -s "$(which bash)"
fi

#ATUALIZAÇÕES E INSTALAÇÕES GERAIS
sudo pacman -Syu python3 kitty zsh neovim git rclone man flameshot npm flatpak winetricks obs-studio zip unzip noto-fonts noto-fonts-emoji wget noto-fonts-extra discord pavucontrol steam fastfetch fakeroot --noconfirm
sudo pacman -S --needed flatpak

#INSTALAÇÕES FLATHUB (SPOTIFY, SOBER [ROBLOX], FLATSEAL, KDENLIVE)
flatpak install -y flathub \
  com.spotify.Client \
  org.vinegarhq.Sober \
  com.github.tchx84.Flatseal \
  org.kde.kdenlive

#SPOTIFY SCRIPT
bash <(curl -sSL https://spotx-official.github.io/run.sh)>

#INSTALANDO ASTRONVIM
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak
git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim 
rm -rf ~/.config/nvim/.git
nvim

#REMOVE PASTA DO YAY
rm -rf $HOME/yay

#DEFINE CAMINHO COMO /HOME/USUARIO
cd $HOME

#CLONA REPO DO YAY
git clone https://aur.archlinux.org/yay.git

#INSTALA DEPENDENCIAS
sudo pacman -Syu --needed base-devel debugedit --noconfirm

#ENTRA NA PASTA DO YAY
cd yay

#FAZ BUILD
makepkg -si

#AQUI TERÁ QUE ACEITAR MANUALMENTE NA INSTALAÇÃO GERAL
#...
#...

#ATUALIZA O YAY
yay -Syu --noconfirm

#REMOVENDO POSSIVEL OHMYZSH EXISTENTE ANTES DE INSTALAR DENOVO
rm -r /home/eomobbr/.oh-my-zsh

#INSTALANDO OHMYZSH
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

