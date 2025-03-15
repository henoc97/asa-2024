# 🚀 Projet ASA 2024-2025 - Automatisation d'Infrastructure Virtualisée

## 📋 Table des matières

- [Présentation](#-présentation)
- [Prérequis](#-prérequis)
- [Installation](#-installation)
- [Utilisation](#-utilisation)
- [Architecture](#-architecture)
- [Scripts](#-scripts)
- [Tests](#-tests)
- [Dépannage](#-dépannage)
- [Contribution](#-contribution)
- [Licence](#-licence)

## 🎯 Présentation

Ce projet permet de **déployer, gérer et superviser une infrastructure virtualisée** complète en utilisant **VirtualBox**. Il comprend :

- Un système de déploiement automatisé
- Une gestion centralisée des VMs
- Un réseau virtuel dédié
- Des outils de sauvegarde et restauration
- Un système de monitoring

## 💻 Prérequis

### Logiciels requis

- VirtualBox (version 6.1 ou supérieure)
- WSL 2 ou Linux
- Git

### Paquets système nécessaires

```bash
sudo apt update
sudo apt install -y bash virtualbox dos2unix
```

### Configuration requise

- RAM minimale : 8 Go
- Espace disque : 100 Go minimum
- Processeur : Compatible avec la virtualisation

## 🔧 Installation

1. Cloner le dépôt :

```bash
git clone https://github.com/henoc97/asa-2024.git
cd asa-2024
```

2. Rendre les scripts exécutables :

```bash
chmod +x scripts/*.sh
```

## 🎮 Utilisation

### Déploiement complet

```bash
bash ./scripts/deploy_infra.sh
```

➡️ Crée et configure :

- Le réseau virtuel
- Les VMs (Web, DB, Backup)
- Les connexions réseau

### Gestion des VMs

```bash
# Lister les VMs
bash ./scripts/vm_manager.sh list

# Démarrer une VM
bash ./scripts/vm_manager.sh start vm_ubuntu-web

# Créer un snapshot
bash ./scripts/vm_manager.sh snapshot vm_ubuntu-web
```

### Supervision

```bash
# Vérifier l'état de l'infrastructure
bash ./scripts/check_status.sh
```

### Nettoyage

```bash
bash ./scripts/clean_infra.sh
```

## 🏗 Architecture

Voir [`ARCHITECTURE.md`](docs/ARCHITECTURE.md) pour les détails complets de l'architecture.

### Vue d'ensemble

- Réseau : `test_infra` (192.168.100.0/24)
- 3 VMs Ubuntu :
  - Serveur Web (192.168.100.10)
  - Base de données (192.168.100.20)
  - Backup (192.168.100.30)

## 🛠 Scripts

| Script               | Description              | Usage                                                     |
| -------------------- | ------------------------ | --------------------------------------------------------- |
| `deploy_infra.sh`    | Déploiement complet      | `./deploy_infra.sh`                                       |
| `clean_infra.sh`     | Nettoyage infrastructure | `./clean_infra.sh`                                        |
| `vm_manager.sh`      | Gestion des VMs          | `./vm_manager.sh {create\|start\|stop\|delete} <vm_name>` |
| `network_manager.sh` | Gestion réseau           | `./network_manager.sh {create\|delete\|list}`             |
| `check_status.sh`    | Monitoring               | `./check_status.sh`                                       |

## 🧪 Tests

Voir [`TESTS.md`](tests/TESTS.md) pour :

- Les scénarios de test
- Les résultats attendus
- Les procédures de validation

## ⚠️ Dépannage

### Problèmes courants

1. **Erreur "NATNetwork already exists"**

   ```bash
   # Solution
   bash ./scripts/network_manager.sh delete
   ```

2. **VM non trouvée**

   ```bash
   # Vérifier l'existence
   bash ./scripts/vm_manager.sh list
   ```

3. **Problèmes de réseau**
   - Vérifier la configuration dans `config/network.conf`
   - S'assurer que VirtualBox a les droits nécessaires
