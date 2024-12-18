#!/bin/bash

# Mettre à jour le système
echo "Mise à jour des dépôts..."
sudo apt update && sudo apt upgrade -y

# Installer les dépendances nécessaires
echo "Installation des dépendances..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Ajouter la clé GPG officielle de Docker
echo "Ajout de la clé GPG Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Ajouter le dépôt Docker
echo "Ajout du dépôt Docker..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu bionic stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Mettre à jour les dépôts
echo "Mise à jour des dépôts après ajout de Docker..."
sudo apt update

# Installer Docker
echo "Installation de Docker..."
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Démarrer et activer Docker
echo "Démarrage et activation du service Docker..."
sudo systemctl start docker
sudo systemctl enable docker

# Ajouter l'utilisateur au groupe Docker (facultatif)
echo "Ajout de l'utilisateur actuel au groupe Docker pour éviter sudo..."
sudo usermod -aG docker $USER

echo "Récupération de l'image pengbai/docker-supermario depuis Docker Hub..."
docker pull pengbai/docker-supermario || { echo "Échec du téléchargement de l'image Docker."; exit 1; }

echo "Exécution du conteneur Docker..."
docker run --name superrmario -p 80:8080 -d pengbai/docker-supermario || { echo "Échec de l'exécution du conteneur Docker."; exit 1; }

echo "Le conteneur 'supermario' est en cours d'exécution. Vous pouvez y accéder sur http://localhost."
