# Arch setup script

Script de pós instalação para Arch Linux / Manjaro

## O que faz
- Atualiza o sistema
- Instala pacotes base
- Configura flatpak
- Instala yay e pacotes AUR
- Configura aliases
- Instala AstroNvim
- Define zsh como shell padrão

## Requisitos
- Possuir a biblioteca multilib habilitada (por padrão ela está comentada em /etc/pacman.conf)
- Arch Linux / Manjaro
- Conexão com a internet
- Usuário com acesso a sudo

## Como utilizar
git clone https://github.com/MOBSAD/archinstall.git
cd archinstall
chmod +x installer.sh
./instaler.sh
