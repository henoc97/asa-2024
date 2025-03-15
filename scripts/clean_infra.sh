#!/bin/bash

echo "[INFO] Début du nettoyage de l'infrastructure..."

# Arrêt des VMs
bash ./scripts/vm_manager.sh stop vm_ubuntu-web
bash ./scripts/vm_manager.sh stop vm_ubuntu-db
bash ./scripts/vm_manager.sh stop vm_ubuntu-backup

# Suppression des VMs
bash ./scripts/vm_manager.sh delete vm_ubuntu-web
bash ./scripts/vm_manager.sh delete vm_ubuntu-db
bash ./scripts/vm_manager.sh delete vm_ubuntu-backup

# Suppression du réseau
bash ./scripts/network_manager.sh delete

echo "[SUCCESS] Nettoyage terminé avec succès !"
