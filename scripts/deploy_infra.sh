#!/bin/bash

echo "[INFO] Début du déploiement..."

# Création du réseau
bash ./scripts/network_manager.sh create

# Création des VMs avec un préfixe 'vm_'
bash ./scripts/vm_manager.sh create vm_ubuntu-web ubuntu-web
bash ./scripts/vm_manager.sh create vm_ubuntu-db ubuntu-db
bash ./scripts/vm_manager.sh create vm_ubuntu-backup ubuntu-backup

# Configuration réseau des VMs
bash ./scripts/network_manager.sh configure vm_ubuntu-web
bash ./scripts/network_manager.sh configure vm_ubuntu-db
bash ./scripts/network_manager.sh configure vm_ubuntu-backup

# Démarrage des VMs
bash ./scripts/vm_manager.sh start vm_ubuntu-web
bash ./scripts/vm_manager.sh start vm_ubuntu-db
bash ./scripts/vm_manager.sh start vm_ubuntu-backup

echo "[SUCCESS] Déploiement terminé avec succès !"
