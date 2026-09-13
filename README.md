# Système de Gestion de Stock avec Automatisation par Triggers (Oracle PL/SQL)

Application de base de données développée sous **Oracle PL/SQL** permettant la gestion automatisée et sécurisée des stocks d'un entrepôt ou d'une entreprise.

## 📋 Description

Ce projet implémente une solution de gestion de stock robuste qui automatise les processus critiques :

- **Gestion des produits et stocks** : Suivi des références, des quantités et des seuils d'alerte.
- **Automatisation par Triggers** : Numérotation séquentielle des enregistrements, mise à jour dynamique des stocks lors des commandes et détection des ruptures.
- **Vues analytiques et financières** : Suivi du chiffre d'affaires par produit et calcul des pertes potentielles en rupture de stock.
- **Sécurité et Contrôle d'Accès (RBAC)** : Séparation stricte des rôles entre la lecture seule (`ROLE_LECTURE_STOCK`) et la gestion opérationnelle (`ROLE_GESTIONNAIRE_STOCK`).

## 🛠️ Technologies utilisées

- **Oracle Database 11g Express Edition** — SGBD relationnel
- **SQL*Plus** — Interface de ligne de commande
- **PL/SQL** — Programmation procédurale (Procédures, Fonctions, Déclencheurs)
- **Windows 10** — Environnement de développement

## ⚙️ Fonctionnalités & Structure des Scripts

L'application s'appuie sur une structure modulaire séquentielle composée de 10 scripts SQL :

- `01_creation_tables.sql` : Création des tables principales (`PRODUIT`, `COMMANDE`, `DEMANDE_REAPPRO`, `LOG_STOCK`).
- `02_triggers_numerotation.sql` : Automatisation des identifiants et clés primaires.
- `03_triggers_stock.sql` : Triggers de mise à jour des stocks et vérification des seuils.
- `04_donnees_test.sql` à `06_test_rupture_stock.sql` : Insertion des jeux de données et tests de validation des commandes.
- `07_fix_log_autonome.sql` : Gestion des transactions autonomes pour l'écriture des logs.
- `08_vues_business.sql` : Vues SQL pour le chiffre d'affaires et les alertes.
- `09_reapprovisionnement.sql` : Logique de commande automatique en cas de stock bas.
- `10_gestion_roles.sql` : Implémentation du modèle RBAC et création des profils utilisateurs (`comptable`, `employe_stock`).

## 🚀 Installation & Exécution

1. Se connecter à Oracle Database en tant qu'administrateur sous SQL*Plus :
```sql
CONNECT sys as sysdba;
Exécuter les scripts dans l'ordre séquentiel (de 01 à 10) :

SQL
@chemin_vers_le_dossier/01_creation_tables.sql
@chemin_vers_le_dossier/02_triggers_numerotation.sql
-- Exécuter les scripts suivants de la même manière jusqu'au script 10
👤 Auteur
KIRE Ange Aubrey Emmanuel

Étudiant en Génie Informatique — Faculté des Sciences Dhar El Mahraz (FSDM), Fès

📄 Contexte
Projet réalisé dans le cadre du parcours académique en Génie Informatique, illustrant la maîtrise des bases de données relationnelles avancées, de l'automatisation par triggers et de l'administration de la sécurité sous Oracle.
