# Déploiement Automatisé d'une Infrastructure Applicative

**Auteur :** Alaa Boughammoura  
**Projet :** TP ICC 2026

## Description du projet

Ce projet a pour objectif de déployer automatiquement une infrastructure applicative composée de deux machines virtuelles :
- Une **VM applicative (APP)** qui exécute une application **Flask**.
- Une **VM base de données (BDD)** qui exécute **PostgreSQL**.

Le déploiement est entièrement automatisé en utilisant :
- **Terraform** pour la création de l'infrastructure (IaC).
- **Ansible** pour la configuration des serveurs et le déploiement de l'application.

L'application Flask se connecte à la base de données PostgreSQL et affiche un message récupéré depuis celle-ci. **Aucun secret sensible (mot de passe, clé SSH, IP publique) n'est versionné sur ce dépôt.**

## Architecture du projet

Le projet est structuré en deux parties principales :

```text
.
├── ansible/
│   ├── ansible.cfg
│   ├── playbook.yml
│   └── roles/
│       ├── app/
│       └── bdd/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── provider.tf
│   ├── outputs.tf
│   ├── terraform.tfvars.example
│   └── modules/
│       ├── app/
│       └── bdd/
└── README.md

Fonctionnement du projet

Le déploiement se déroule en plusieurs étapes :
1. Création de l'infrastructure avec Terraform

Terraform crée deux machines virtuelles :

    VM BDD : Héberge la base de données.

    VM APP : Héberge l'application Python.

Note : La VM BDD est créée avant la VM APP afin que l'application puisse se connecter à la base de données dès son lancement.
2. Configuration des serveurs avec Ansible

Une fois les machines créées, Ansible configure automatiquement les serveurs (en respectant l'idempotence et sans utiliser les modules shell ou command) :

Le rôle BDD :

    Installe PostgreSQL.

    Crée un groupe et l'utilisateur cytech_usr.

    Crée la base de données cytech.

    Initialise la base avec une table et y insère la valeur attendue.

Le rôle APP :

    Installe les dépendances Python.

    Crée un environnement virtuel (venv).

    Déploie l'application Flask.

    Crée un service systemd pour lancer l'application en arrière-plan.

3. Test de l'application

À la fin du déploiement, une requête HTTP est exécutée automatiquement via Ansible pour vérifier que l'application fonctionne. L'application doit retourner la réponse suivante : hello Alaa Boughammoura.
Déploiement du projet

Pour lancer l'environnement, placez-vous dans le dossier terraform et lancez les commandes :
Bash

terraform init
terraform apply

Une fois terminé, vous pourrez accéder à l'application depuis un navigateur :
Plaintext

http://<IP_APP>:8080

Exemple de configuration (terraform.tfvars.example)

Le fichier terraform.tfvars.example permet de définir les variables utilisées par Terraform. En voici un exemple :
Terraform

# Configuration Proxmox
proxmox_endpoint = "[https://192.168.100.100:8006/api2/json](https://192.168.100.100:8006/api2/json)"
proxmox_user     = "terraform@pme"
proxmox_password = "CHANGEME"  # Remplacer par le vrai mot de passe

# Configuration VM
vm_template = "ubuntu-template"
vm_storage  = "local-lvm"
vm_bridge   = "vmbr0"

# Configuration application & base de données
app_user    = "cytech_usr"
app_dir     = "/home/cytech_usr/app"
db_name     = "cytech"
db_user     = "cytech_usr"
db_password = "CHANGEME"  # Remplacer par le vrai mot de passe

Technologies utilisées:
    Terraform
    Ansible
    Proxmox
    Python / Flask
    PostgreSQL