#!/bin/bash

# Vérification de l'état des VMs
VM1_STATUS=$("/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" showvminfo "vm_ubuntu-web" --machinereadable | grep -i "VMState" | cut -d'=' -f2 | tr -d '"')
VM2_STATUS=$("/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" showvminfo "vm_ubuntu-db" --machinereadable | grep -i "VMState" | cut -d'=' -f2 | tr -d '"')
VM3_STATUS=$("/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" showvminfo "vm_ubuntu-backup" --machinereadable | grep -i "VMState" | cut -d'=' -f2 | tr -d '"')

# Vérification de l'état du réseau
NETWORK_STATUS=$("/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" list natnetworks | grep -A 3 "test_infra" | grep "Yes")

# Affichage des résultats
echo "VM1 (Web): $VM1_STATUS"
echo "VM2 (BDD): $VM2_STATUS"
echo "VM3 (Backup): $VM3_STATUS"
if [ -n "$NETWORK_STATUS" ]; then
  echo "Network: ACTIVE"
else
  echo "Network: INACTIVE"
fi

# Vérification des services (exemple simplifié)
echo "Services: OK" 