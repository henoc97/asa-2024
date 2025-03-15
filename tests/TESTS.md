# 🧪 Tests et Validation

## ✅ Scénarios de test

### 1️⃣ Déploiement de l’infrastructure

**Commande :**

```bash

bash ./scripts/deploy_infra.sh

```

**Résultat attendu :**

- Création du réseau `test_infra`
- Clonage et démarrage des VMs `vm_ubuntu-web`, `vm_ubuntu-db`, `vm_ubuntu-backup`
- Les VMs sont visibles avec `bash ./scripts/vm_manager.sh list`

### 2️⃣ Vérification du réseau

**Commande :**

```bash

bash ./scripts/network_manager.sh list

```

**Résultat attendu :**

```

Name: test_infra

Network: 192.168.100.0/24

Gateway: 192.168.100.1

```

### 3️⃣ Vérification du fonctionnement des VMs

**Commande :**

```bash

bash ./scripts/vm_manager.sh list

```

**Résultat attendu :**

Les VMs `vm_ubuntu-web`, `vm_ubuntu-db`, `vm_ubuntu-backup` doivent être listées.

### 4️⃣ Nettoyage de l’infrastructure

**Commande :**

```bash

bash ./scripts/clean_infra.sh

```

**Résultat attendu :**

- Arrêt des VMs
- Suppression des VMs
- Suppression du réseau

## ⚠️ Problèmes et solutions

-**Erreur "NATNetwork already exists"**

👉 Solution : Supprimer le réseau avant de le recréer

```bash

  bash ./scripts/network_manager.sh delete

```

-**Erreur "Could not find a registered machine"**

👉 Solution : Vérifier que la VM existe avec :

```bash

  bash ./scripts/vm_manager.sh list

```

## 🔍 Procédures de validation

### 1️⃣ Validation du déploiement

**Étapes de validation :**

1. Exécuter `bash ./scripts/check_status.sh`

   - Vérifier que toutes les VMs sont en état "RUNNING"
   - Vérifier que le réseau est "ACTIVE"

### 2️⃣ Validation des sauvegardes

**Étapes de validation :**

1. Créer des snapshots pour chaque VM :

```bash
bash ./scripts/vm_manager.sh snapshot vm_ubuntu-web
bash ./scripts/vm_manager.sh snapshot vm_ubuntu-db
bash ./scripts/vm_manager.sh snapshot vm_ubuntu-backup
```

2. Vérifier la présence des snapshots :

```bash
"/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" snapshot vm_ubuntu-web list
"/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" snapshot vm_ubuntu-db list
"/mnt/c/Program Files/Oracle/VirtualBox/VBoxManage.exe" snapshot vm_ubuntu-backup list
```

### 3️⃣ Validation de la restauration

**Étapes de validation :**

1. Tester la restauration d'une VM :

```bash
bash ./scripts/vm_manager.sh restore vm_ubuntu-web
```

2. Vérifier l'état après restauration :

```bash
bash ./scripts/check_status.sh
```

### 4️⃣ Validation du nettoyage

**Étapes de validation :**

1. Exécuter le nettoyage :

```bash
bash ./scripts/clean_infra.sh
```

2. Vérifier que tout est supprimé :

```bash
# Vérifier qu'aucune VM n'existe
bash ./scripts/vm_manager.sh list

# Vérifier qu'aucun réseau n'existe
bash ./scripts/network_manager.sh list
```

## 📋 Checklist de validation finale

- [ ] Toutes les VMs démarrent correctement
- [ ] Le réseau est correctement configuré
- [ ] Les VMs peuvent communiquer entre elles
- [ ] Les snapshots peuvent être créés et restaurés
- [ ] Le nettoyage supprime correctement toute l'infrastructure
- [ ] Aucune erreur dans les logs système
