sudo apt update
#sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
#sudo apt update
#sudo apt install docker-ce -y

sudo mkdir -p /etc/apt/keyrings
test -f "/etc/apt/keyrings/docker.gpg" || curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

test -f "/etc/apt/sources.list.d/docker.list" || echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

sudo usermod -aG docker ${USER}



