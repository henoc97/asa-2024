#!/bin/bash

NETWORK_CONFIG="$(dirname "$0")/../config/network.conf"

# Vérification de l'existance du fichier de configuration
if [ ! -f "$NETWORK_CONFIG" ]; then
  echo "[ERREUR] Fichier de configuration réseau $NETWORK_CONFIG introuvable !"
  exit 1
fi

# Chargement des variables réseau
source "$NETWORK_CONFIG"  

case $1 in
  create)
    # Vérification de l'existance du réseau
    EXISTING_NETWORK=$("/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" list natnetworks | grep "$NETWORK_NAME")
    if [ -n "$EXISTING_NETWORK" ]; then
      echo "[INFO] Le réseau '$NETWORK_NAME' existe déjà, pas besoin de le recréer."
    else
      echo "[INFO] Création du réseau virtuel '$NETWORK_NAME'..."
      "/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" natnetwork add --netname "$NETWORK_NAME" --network "$NETWORK_RANGE" --enable
    fi
    ;;

  configure)
    VM_NAME=$2
    if [ -z "$VM_NAME" ]; then
      echo "Usage: $0 configure <vm_name>"
      exit 1
    fi
    echo "[INFO] Configuration du réseau pour la VM '$VM_NAME'..."
    "/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" modifyvm "$VM_NAME" --nic1 natnetwork --nat-network1 "$NETWORK_NAME"
    ;;
    
  list)
    echo "[INFO] Affichage de la configuration réseau..."
    "/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" list natnetworks
    ;;
    
  delete)
    echo "[INFO] Suppression du réseau virtuel '$NETWORK_NAME'..."
    "/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" natnetwork remove --netname "$NETWORK_NAME"
    ;;
    
  *)
    echo "Usage: $0 {create|configure|list|delete} <vm_name>"
    exit 1
    ;;
esac
