-- ============================================
-- Script 10 : Gestion des rôles et sécurité
-- À exécuter en tant que SYS AS SYSDBA
-- ============================================

-- Créer un rôle "lecture seule" (ex: pour un comptable/manager)
CREATE ROLE ROLE_LECTURE_STOCK;
GRANT SELECT ON gestion_stock.PRODUIT TO ROLE_LECTURE_STOCK;
GRANT SELECT ON gestion_stock.COMMANDE TO ROLE_LECTURE_STOCK;
GRANT SELECT ON gestion_stock.V_CA_PAR_PRODUIT TO ROLE_LECTURE_STOCK;
GRANT SELECT ON gestion_stock.V_ALERTE_STOCK TO ROLE_LECTURE_STOCK;
GRANT SELECT ON gestion_stock.V_PERTES_POTENTIELLES TO ROLE_LECTURE_STOCK;

-- Créer un rôle "gestionnaire" (peut modifier les commandes/stock)
CREATE ROLE ROLE_GESTIONNAIRE_STOCK;
GRANT SELECT, INSERT, UPDATE ON gestion_stock.PRODUIT TO ROLE_GESTIONNAIRE_STOCK;
GRANT SELECT, INSERT ON gestion_stock.COMMANDE TO ROLE_GESTIONNAIRE_STOCK;
GRANT SELECT ON gestion_stock.DEMANDE_REAPPRO TO ROLE_GESTIONNAIRE_STOCK;

-- Créer un utilisateur "comptable" avec accès lecture seule uniquement
CREATE USER comptable IDENTIFIED BY comptable123;
GRANT CONNECT TO comptable;
GRANT ROLE_LECTURE_STOCK TO comptable;

-- Créer un utilisateur "employe_stock" avec droits de gestionnaire
CREATE USER employe_stock IDENTIFIED BY employe123;
GRANT CONNECT TO employe_stock;
GRANT ROLE_GESTIONNAIRE_STOCK TO employe_stock;

-- Définir les rôles par défaut pour qu'ils soient actifs immédiatement à la connexion
ALTER USER comptable DEFAULT ROLE ROLE_LECTURE_STOCK;
ALTER USER employe_stock DEFAULT ROLE ROLE_GESTIONNAIRE_STOCK;