# .devcontainer/setup.sh
#!/bin/bash

# Installation of Brew and Kubernetes tools 

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/$USER/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
source ~/.bashrc 

echo "✅ brew installed successfully"

brew install derailed/k9s/k9s

sudo apt-get install fzf -y

echo "✅ kubectx, kubens, fzf, homebrew, and k9s installed successfully"

# Start k3d cluster with three nodes
echo "✅ Intialize the Kuberentes cluster"

k3d cluster create Dragon --servers 2

# Adding Nodes to the cluster 

echo "✅ Adding Nodes to the Kuberentes cluster"

k3d node create Goku --cluster Dragon

k3d node create Beast --cluster Dragon

# Adding the config File

echo "✅ Adding the config files of kubernetes"

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Show the kubectl nodes 

echo "✅ Showing the kubernetes nodes"

kubectl get nodes 

