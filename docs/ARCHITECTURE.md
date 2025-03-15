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
    +---------+-----+ +--------+-----+ +-------+---------+
    |  Web Server   | |  Database    | |    Backup       |
    | vm_ubuntu-web | | vm_ubuntu-db | |vm_ubuntu-backup |
    |    Ubuntu     | |   Ubuntu     | |    Ubuntu       |
    |   22.04 LTS   | |  22.04 LTS   | |   22.04 LTS     |
    | 192.168.100.10| |192.168.100.20| |192.168.100.30   |
    +------|-------+  +--------|-----+ +-----------------+
           |                   |
      +------+-------------------+------------------+
      |            Stockage partagé NFS             |
      +---------------------------------------------+
```

## 🔧 Configuration Réseau

### Réseau principal

- **Nom** : `test_infra`
- **Type** : NAT Network (VirtualBox)
- **Plage IP** : `192.168.100.0/24`
- **Passerelle** : `192.168.100.1`
- **DNS** : `8.8.8.8`, `8.8.4.4`
- **DHCP** : Activé (plage `.100` à `.200`)

## 🖥️ Spécifications des VMs

### Serveur Web (vm_ubuntu-web)

- **OS** : Ubuntu Server 22.04 LTS
- **CPU** : 2 cores
- **RAM** : 2 Go
- **Stockage** : 20 Go (dynamique)
- **IP** : 192.168.100.10

### Base de données (vm_ubuntu-db)

- **OS** : Ubuntu Server 22.04 LTS
- **CPU** : 2 cores
- **RAM** : 2 Go
- **Stockage** : 20 Go (dynamique)
- **IP** : 192.168.100.20

### Serveur de sauvegarde (vm_ubuntu-backup)

- **OS** : Ubuntu Server 22.04 LTS
- **CPU** : 1 core
- **RAM** : 1 Go
- **Stockage** : 20 Go (dynamique)
- **IP** : 192.168.100.30
