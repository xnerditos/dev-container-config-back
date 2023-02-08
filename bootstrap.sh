#!/bin/bash

export HOME=/home/vscode

# Configure .net
#############################################
if [[ "$PACKAGE_ACCESS" != "" && "$GITHUB_USER" != "" ]]; then
    dotnet nuget add source https://nuget.pkg.github.com/xnerditos/index.json -n "xnerditos" --username $GITHUB_USER --store-password-in-clear-text --password $PACKAGE_ACCESS
fi
dotnet tool install --global altcover.global

# Get container scripts
#############################################
mkdir -p $HOME/setup
wget -O $HOME/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
#wget -O $HOME/setup/desktop-lite-debian.sh https://raw.githubusercontent.com/microsoft/vscode-dev-containers/main/script-library/desktop-lite-debian.sh
wget -O $HOME/setup/add-nuget-packet-source.sh https://raw.githubusercontent.com/xnerditos/dev-container-config-back/master/container-utils/add-nuget-packet-source.sh
wget -O $HOME/setup/add-github-ssh-key.sh https://raw.githubusercontent.com/xnerditos/dev-container-config-back/master/container-utils/add-github-ssh-key.sh
wget -O $HOME/setup/install-chrome.sh https://raw.githubusercontent.com/xnerditos/dev-container-config-back/master/container-utils/install-chrome.sh
chmod +x $HOME/setup/*.sh

mkdir -p $HOME/utils
wget -O $HOME/utils/edit-desktop-menu https://raw.githubusercontent.com/xnerditos/dev-container-config-back/master/container-utils/edit-desktop-menu.sh
wget -O $HOME/utils/run-detached https://raw.githubusercontent.com/xnerditos/dev-container-config-back/master/container-utils/run-detached.sh
chmod +x $HOME/utils/*

# Set up SSH to work as it should
#############################################

if test -f "./github_key"; then
    cat <<EOF >>$HOME/.ssh/config
AddKeysToAgent yes
IdentityFile $HOME/.ssh/github_key
EOF
    # If we have a github_key then copy it over
    cp ./github_key $HOME/.ssh/github_key
else
    cat <<EOF >>$HOME/.ssh/config
AddKeysToAgent yes
#IdentityFile $HOME/.ssh/github_key
EOF
    touch $HOME/.ssh/github_key
fi

chmod 600 $HOME/.ssh/github_key

cat <<EOF >>$HOME/.bashrc
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval \`ssh-agent\` &>/dev/null
  ln -sf "\$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add &>/dev/null
EOF

# Additional setup in home dir
#############################################
#cd $HOME
ln -s /workspaces $HOME/repos
#cd - &>/dev/null

# Additional stuff in .bashrc
#############################################
cat <<EOF >>$HOME/.bashrc
export PATH="\$PATH:\$HOME/.dotnet/tools:\$HOME/utils"
source \$HOME/.git-completion.bash
EOF

# Custom dev container config
#############################################
if test -f "./dev_container_custom_bootstrap.sh"; then
    ./dev_container_custom_bootstrap.sh
fi

# Package install and update
############################################
sudo apt update 
sudo apt upgrade -y 
sudo apt install xmlstarlet -y

# Node install and node packages
############################################
curl -sL https://deb.nodesource.com/setup_18.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
sudo apt install nodejs
rm /tmp/nodesource_setup.sh 
sudo npm i -g zx

# wget -O ./vsls-reqs.sh https://aka.ms/vsls-linux-prereq-script
# chmod +x *.sh
# ./vsls-reqs.sh
# rm ./vsls-reqs.sh

# finalization
#############################################
source $HOME/.bashrc
