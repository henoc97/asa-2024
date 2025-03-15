# 🌐 Architecture du Projet ASA 2024-2025

## 📑 Table des matières

- [Vue d'ensemble](#-vue-densemble)
- [Diagramme d'architecture](#-diagramme-darchitecture)
- [Configuration réseau](#-configuration-réseau)
- [Spécifications des VMs](#-spécifications-des-vms)
- [Sécurité](#-sécurité)
- [Sauvegarde](#-sauvegarde)
- [Monitoring](#-monitoring)

## 🎯 Vue d'ensemble

Cette infrastructure virtualisée est conçue pour héberger une application web avec :

- Une séparation claire des responsabilités
- Une haute disponibilité
- Une politique de sauvegarde robuste
- Un monitoring complet

## 📊 Diagramme d'Architecture

### Infrastructure globale

```
                    +-------------------+
                    |     Internet      |
                    +--------+----------+
                             |
                    +--------+----------+
                    |   Routeur/NAT     |  (VirtualBox NAT Network)
                    +--------+----------+
                             |
     +----------------------------------------+
     |          Réseau test_infra             |
     |        (192.168.100.0/24)              |
     +----------------------------------------+
              |               |                |
    +---------+----+ +--------+-----+ +-------+--------+
    |  Web Server  | |  Database   | |    Backup      |
    | vm_ubuntu-web| | vm_ubuntu-db| |vm_ubuntu-backup|
    |    Ubuntu    | |   Ubuntu    | |    Ubuntu      |
    |   22.04 LTS  | |  22.04 LTS  | |   22.04 LTS   |
    | 192.168.100.10| |192.168.100.20| |192.168.100.30 |
    +------|-------+ +---------|----+ +---------------+
           |                   |
    +------+-------------------+------------------+
    |            Stockage partagé NFS            |
    +-------------------------------------------+
```

### Flux de données

```
Client → Web Server → Database
   ↑          ↓          ↓
   └──────── Backup ←────┘
```

## 🔧 Configuration Réseau

### Réseau principal

- **Nom** : `test_infra`
- **Type** : NAT Network (VirtualBox)
- **Plage IP** : `192.168.100.0/24`
- **Passerelle** : `192.168.100.1`
- **DNS** : `8.8.8.8`, `8.8.4.4`
- **DHCP** : Activé (plage `.100` à `.200`)

### Règles de pare-feu

| Source | Destination | Port   | Protocol | Description |
| ------ | ----------- | ------ | -------- | ----------- |
| Any    | Web         | 80/443 | TCP      | HTTP(S)     |
| Web    | DB          | 3306   | TCP      | MySQL       |
| Any    | Backup      | 22     | TCP      | SSH         |

## 🖥️ Spécifications des VMs

### Serveur Web (vm_ubuntu-web)

- **OS** : Ubuntu Server 22.04 LTS
- **CPU** : 2 cores
- **RAM** : 2 Go
- **Stockage** : 20 Go (dynamique)
- **IP** : 192.168.100.10
- **Services** :
  - Apache2/Nginx
  - PHP 8.1
  - ModSecurity

### Base de données (vm_ubuntu-db)

- **OS** : Ubuntu Server 22.04 LTS
- **CPU** : 2 cores
- **RAM** : 2 Go
- **Stockage** : 20 Go (dynamique)
- **IP** : 192.168.100.20
- **Services** :
  - MySQL 8.0
  - Redis (cache)
  - Fail2ban

### Serveur de sauvegarde (vm_ubuntu-backup)

- **OS** : Ubuntu Server 22.04 LTS
- **CPU** : 1 core
- **RAM** : 1 Go
- **Stockage** : 20 Go (dynamique)
- **IP** : 192.168.100.30
- **Services** :
  - Rsync
  - Cron
  - Monitoring

## 🔒 Sécurité

### Politique de sécurité

- Mises à jour automatiques activées
- Authentification par clé SSH uniquement
- Pare-feu UFW configuré
- SELinux en mode enforcing

### Certificats SSL

- Let's Encrypt pour HTTPS
- Renouvellement automatique

## 💾 Sauvegarde

### Stratégie

- Sauvegarde quotidienne des données
- Rétention : 7 jours glissants
- Snapshots VMs : hebdomadaire

### Volumes

| VM  | Volume         | Taille | Fréquence |
| --- | -------------- | ------ | --------- |
| Web | /var/www       | 5 GB   | Daily     |
| DB  | /var/lib/mysql | 10 GB  | Daily     |
| All | System         | 20 GB  | Weekly    |

## 📊 Monitoring

### Métriques surveillées

- CPU, RAM, Disque
- Temps de réponse services
- Logs système
- Tentatives de connexion

### Alertes

- Email sur événements critiques
- Rapport quotidien d'état
- Notification Slack/Teams
