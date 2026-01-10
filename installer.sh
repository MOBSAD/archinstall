#!/bin/bash
set -e
sudo -v

#CORES PRA FORMATAR
GREEN="\033[0;32m"
RED='\033[0;31m'
NC='\033[0m'

install_msg(){
  echo -ne "${GREEN} INSTALANDO $1 ${NC}\n"
  sleep 1
}

remove_msg(){
  echo -ne "${RED} REMOVENDO $1 ${NC}\n"
  sleep 1
}

warn_msg(){
  echo -ne "$1\n"
  sleep 1
}

install_base(){
  #ATUALIZAÇÕES E INSTALAÇÕES GERAIS
  install_msg "BASE"
  sudo pacman -Syu python3 kitty zsh neovim git rclone man flameshot npm flatpak winetricks obs-studio zip unzip noto-fonts noto-fonts-emoji wget noto-fonts-extra discord pavucontrol steam fastfetch fakeroot --noconfirm
  sudo pacman -S --needed flatpak

}

install_flatpak_applications(){
  #INSTALAÇÕES FLATHUB (SPOTIFY, SOBER [ROBLOX], FLATSEAL, KDENLIVE)
  install_msg "APLICAÇÕES FLATPAK"
  flatpak install -y flathub \
    com.spotify.Client \
    org.vinegarhq.Sober \
    com.github.tchx84.Flatseal \
    org.kde.kdenlive
}

install_spotx(){
  #SPOTIFY SCRIPT
  install_msg "SPOTX"
  curl -sSL https://spotx-official.github.io/run.sh -o spotx.sh
  bash spotx.sh -f
  rm spotx.sh
}

install_astronvim(){
  #REMOVENDO PASTA NVIM
  remove_msg "PASTA NVIM"
  rm -rf "$HOME/.config/nvim"

  #INSTALANDO ASTRONVIM
  install_msg "ASTRONVIM"
  git clone --depth 1 https://github.com/AstroNvim/template "$HOME/.config/nvim" 
  rm -rf "$HOME"/.config/nvim/.git
  #DEIXA PRA ABRIR DEPOIS E CONFIGURAR DEPOIS TAMBÉM
  #...
  #...
  warn_msg "ABRA O NVIM DEPOIS PRA INSTALAR TUDO COMO DEVE"

}

install_yay(){
  #REMOVE PASTA DO YAY
  remove_msg "REMOVENDO PASTA yay"
  rm -rf "$HOME/yay"

  #DEFINE CAMINHO COMO /HOME/USUARIO
  cd $HOME

  #CLONA REPO DO YAY
  install_msg "YAY"
  git clone https://aur.archlinux.org/yay.git

  #INSTALA DEPENDENCIAS
  install_msg "DEPENDENCIAS DO YAY"
  sudo pacman -Syu --needed base-devel debugedit --noconfirm

  #ENTRA NA PASTA DO YAY
  warn_msg "ENTRA NA PASTA DO YAY"
  cd yay

  #FAZ BUILD QUASE AUTOMATICAMENTE
  warn_msg "FAZ BUILD DO YAY"
  makepkg -si --noconfirm

  #AQUI TERÁ QUE ACEITAR MANUALMENTE NA INSTALAÇÃO GERAL
  #...
  #...

}

update_yay(){
  #ATUALIZA O YAY
  install_msg "UPDATES NO YAY"
  yay -Syu --noconfirm
}


install_ohmyzsh(){
  export CHSH=yes
  export RUNZSH=no

  #REMOVENDO POSSIVEL OHMYZSH E ARQUIVOS ZSH CASO EXISTENTES ANTES DE INSTALAR PARA EVITAR ERROS
  remove_msg "POSSIVEIS PASTAS QUE PODEM COMPROMETER O OHMYZSH"
  rm -rf "$HOME/.oh-my-zsh" "$HOME/.zshrc" "$HOME/.shell.pre-oh-my-zsh"

  #INSTALANDO OHMYZSH
  install_msg "OHMYZSH"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  #FAZ BACKUP DO ARQUIVO ORIGINAL .ZSHRC
  warn_msg "FAZENDO BACKUP DO .ZSHRC QUE VEM COM O OHMYZSH"
  mv "$HOME/.zshrc" "$HOME/.zshrc.bak"

  #MOVE O ARQUIVO DO GITHUB PRA "SUBSTITUIR" O ORIGINAL
  warn_msg "MOVE O ARQUIVO DO ZSH PRO SHELL DO USUARIO" 
  cp "$HOME/archinstall/zshrc" "$HOME/.zshrc"
}

reboot_system(){
  #CONTAGEM REGRESSIVA PRA REINICIAR
  for i in {10..1}; do
      echo -ne "Reiniciando em ${RED}$i${NC} segundos...\r"
      sleep 1
  done
  echo "" 

  sync
  sleep 1

  sudo reboot now
}


shell_bash(){
  #DEFINE SHELL COMO BASH
  if [ "$SHELL" != "$(which bash)" ]; then 
    chsh -s "$(which bash)"
    sudo chsh -s "$(which bash)"
  fi
}

shell_zsh(){
  #DEFINE SHELL COMO ZSH
  if [ "$SHELL" != "$(which zsh)" ]; then 
    chsh -s "$(which zsh)"
    sudo chsh -s "$(which zsh)"
  fi
}

main(){
  shell_bash
  install_base
  install_flatpak_applications
  install_spotx
  install_astronvim
  install_yay
  update_yay
  install_ohmyzsh
  shell_zsh
  reboot_system
}

main
