#!/bin/bash

# Vérifier si le script est exécuté en tant que root
if [ "$EUID" -ne 0 ]; then
  echo "Veuillez exécuter ce script en tant que root (sudo)."
  exit 1
fi

echo "Update."
sudo apt update 
echo "Upgrade."
sudo apt upgrade -y 

echo "Installation de Docker via snap..."
sudo snap install docker || { echo "Échec de l'installation de Docker."; exit 1; }

echo "Attente de 5 secondes pour permettre à Docker de démarrer..."
sleep 5

sudo snap services

systemctl start docker
echo "Récupération de l'image pengbai/docker-supermario depuis Docker Hub..."
docker pull pengbai/docker-supermario || { echo "Échec du téléchargement de l'image Docker."; exit 1; }

echo "Exécution du conteneur Docker..."
docker run --name superrmario -p 80:8080 -d pengbai/docker-supermario || { echo "Échec de l'exécution du conteneur Docker."; exit 1; }

echo "Le conteneur 'supermario' est en cours d'exécution. Vous pouvez y accéder sur http://localhost."
