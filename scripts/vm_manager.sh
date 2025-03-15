#!/bin/bash


# Définition des chemins
VM_DIR="/mnt/c/Users/amavi/VirtualBox VMs"
CONFIG_FILE="$(dirname "$0")/../config/vm_templates.conf"

# Vérification de l'existance du fichier de configuration 
if [ ! -f "$CONFIG_FILE" ]; then
  echo "[ERREUR] Fichier de configuration $CONFIG_FILE introuvable !"
  exit 1
fi

# Chargement les variables des templates
source "$CONFIG_FILE"  

# Récupération des paramètres
ACTION=$1
VM_NAME=$2
TEMPLATE_NAME=$3

# Vérification de la validité des paramètres 
if [ "$ACTION" = "create" ]; then
  if [ -z "$VM_NAME" ] || [ -z "$TEMPLATE_NAME" ]; then
    echo "[ERREUR] Paramètres invalides. Usage: $0 create <vm_name> <template_name>"
    exit 1
  fi

  # Vérificatiion de la validité du template demandé
  if [[ "$TEMPLATE_NAME" != "$WEB_TEMPLATE" && "$TEMPLATE_NAME" != "$DB_TEMPLATE" && "$TEMPLATE_NAME" != "$BACKUP_TEMPLATE" ]]; then
    echo "[ERREUR] Le template '$TEMPLATE_NAME' n'est pas valide. Templates disponibles :"
    echo "- $WEB_TEMPLATE"
    echo "- $DB_TEMPLATE"
    echo "- $BACKUP_TEMPLATE"
    exit 1
  fi
fi

case $ACTION in
  create)
    echo "[INFO] Création de la VM '$VM_NAME' à partir du template '$TEMPLATE_NAME'..."
    "/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" clonevm "$TEMPLATE_NAME" --name "$VM_NAME" --register
    ;;

  list)
    echo "[INFO] Liste des VMs existantes :"
    "/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" list vms
    ;;

  start)
    if [ -z "$VM_NAME" ]; then
      echo "[ERREUR] Usage: $0 start <vm_name>"
      exit 1
    fi
    echo "[INFO] Démarrage de la VM '$VM_NAME'..."
    "/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" startvm "$VM_NAME" --type headless
    ;;

  stop)
    if [ -z "$VM_NAME" ]; then
      echo "[ERREUR] Usage: $0 stop <vm_name>"
      exit 1
    fi
    echo "[INFO] Arrêt de la VM '$VM_NAME'..."
    "/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" controlvm "$VM_NAME" poweroff
    ;;

  snapshot)
    if [ -z "$VM_NAME" ]; then
      echo "[ERREUR] Usage: $0 snapshot <vm_name>"
      exit 1
    fi
    echo "[INFO] Création d’un snapshot pour la VM '$VM_NAME'..."
    "/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" snapshot "$VM_NAME" take "snapshot_$(date +%F_%H-%M-%S)"
    ;;

  restore)
    if [ -z "$VM_NAME" ]; then
      echo "[ERREUR] Usage: $0 restore <vm_name>"
      exit 1
    fi
    echo "[INFO] Restauration du dernier snapshot pour la VM '$VM_NAME'..."
    "/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" snapshot "$VM_NAME" restorecurrent
    ;;

  delete)
    if [ -z "$VM_NAME" ]; then
      echo "[ERREUR] Usage: $0 delete <vm_name>"
      exit 1
    fi
    echo "[INFO] Suppression de la VM '$VM_NAME'..."
    "/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" unregistervm "$VM_NAME" --delete
    ;;

  *)
    echo "[ERREUR] Commande invalide. Usage: $0 {create|list|start|stop|snapshot|restore|delete} <vm_name>"
    exit 1
    ;;
esac
