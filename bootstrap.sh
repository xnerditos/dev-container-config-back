#!/bin/bash

if [[ -z "$GITHUB_USER" ]]; then
    echo "You must define GITHUB_USER!"
    exit 1;
fi
if [[ -z "$PACKAGE_ACCESS" ]]; then
    echo "You must define GITHUB_USER!"
    exit 1;
fi

dotnet nuget add source https://nuget.pkg.github.com/xnerditos/index.json -n "xnerditos" --username $GITHUB_USER --store-password-in-clear-text --password $PACKAGE_ACCESS

#sudo apt update 
#sudo apt upgrade -y 

if test -f "./github_key"; then
cat <<EOF >>$HOME/.ssh/config
AddKeysToAgent yes
IdentityFile /home/vscode/.ssh/github_key
EOF
cp ./github_key $HOME/.ssh/github_key
else
cat <<EOF >>$HOME/.ssh/config
AddKeysToAgent yes
#IdentityFile /home/vscode/.ssh/github_key
EOF
touch /home/vscode/.ssh/github_key
fi

chmod 600 /home/vscode/.ssh/github_key

cat <<EOF >>$HOME/.bashrc
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval \`ssh-agent\`
  ln -sf "\$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add
EOF

source $HOME/.bashrc

# wget -O ./vsls-reqs.sh https://aka.ms/vsls-linux-prereq-script
# chmod +x *.sh
# ./vsls-reqs.sh
# rm ./vsls-reqs.sh

