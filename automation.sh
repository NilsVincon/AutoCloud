#!/bin/bash

# Vérifier si le script est exécuté en tant que root
if [ "$EUID" -ne 0 ]; then
  echo "Veuillez exécuter ce script en tant que root (sudo)."
  exit 1
fi

echo "Installation de Docker via snap..."
snap install docker || { echo "Échec de l'installation de Docker."; exit 1; }

echo "Attente de 5 secondes pour permettre à Docker de démarrer..."
sleep 5

systemctl start docker
echo "Récupération de l'image erudinsky/mario depuis Docker Hub..."
docker pull pengbai/docker-supermario || { echo "Échec du téléchargement de l'image Docker."; exit 1; }

echo "Exécution du conteneur Docker..."
docker run -d -p 80:8080 pengbai/docker-supermario || { echo "Échec de l'exécution du conteneur Docker."; exit 1; }

echo "Le conteneur 'supermario' est en cours d'exécution. Vous pouvez y accéder sur http://localhost."
