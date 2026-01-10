#!/bin/bash
set -e
sudo -v

#DEFINE SHELL COMO BASH
if [ "$SHELL" != "$(which bash)" ]; then 
  chsh -s "$(which bash)"
  sudo chsh -s "$(which bash)"
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
curl -sSL https://spotx-official.github.io/run.sh -o spotx.sh
bash spotx.sh -f
rm spotx.sh

#REMOVENDO PASTA NVIM
rm -rf "$HOME/.config/nvim"

#INSTALANDO ASTRONVIM
git clone --depth 1 https://github.com/AstroNvim/template "$HOME/.config/nvim" 
rm -rf "$HOME"/.config/nvim/.git
#DEIXA PRA ABRIR DEPOIS E CONFIGURAR DEPOIS TAMBÉM
#...
#...

#REMOVE PASTA DO YAY
rm -rf "$HOME/yay"

#DEFINE CAMINHO COMO /HOME/USUARIO
cd $HOME

#CLONA REPO DO YAY
git clone https://aur.archlinux.org/yay.git

#INSTALA DEPENDENCIAS
sudo pacman -Syu --needed base-devel debugedit --noconfirm

#ENTRA NA PASTA DO YAY
cd yay

#FAZ BUILD QUASE AUTOMATICAMENTE
makepkg -si --noconfirm

#AQUI TERÁ QUE ACEITAR MANUALMENTE NA INSTALAÇÃO GERAL
#...
#...

#ATUALIZA O YAY
yay -Syu --noconfirm

export CHSH=yes
export RUNZSH=no

#REMOVENDO POSSIVEL OHMYZSH E ARQUIVOS ZSH CASO EXISTENTES ANTES DE INSTALAR PARA EVITAR ERROS
rm -rf "$HOME/.oh-my-zsh" "$HOME/.zshrc" "$HOME/.zsh_history" "$HOME/.shell.pre-oh-my-zsh"

#INSTALANDO OHMYZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

#FAZ BACKUP DO ARQUIVO ORIGINAL .ZSHRC
mv "$HOME/.zshrc" "$HOME/.zshrc.bak"

#MOVE O ARQUIVO DO GITHUB PRA "SUBSTITUIR" O ORIGINAL
mv "$HOME/archinstall/zshrc" "$HOME/.zshrc"

#DEFINE SHELL COMO ZSH
if [ "$SHELL" != "$(which zsh)" ]; then 
  chsh -s "$(which zsh)"
  sudo chsh -s "$(which zsh)"
fi

#CORES PRA FORMATAR
RED='\033[0;31m'
NC='\033[0m'

#CONTAGEM REGRESSIVA PRA REINICIAR
for i in {10..1}; do
    echo -ne "Reiniciando em ${RED}$i${NC} segundos...\r"
    sleep 1
done
echo ""

#SE REMOVE
rm -rf "$HOME/archinstall/"

sync
sleep 1

#FAZ REBOOT
reboot now
