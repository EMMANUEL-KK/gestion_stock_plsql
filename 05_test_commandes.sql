-- ============================================
-- Script 5 : Test des commandes (mise à jour stock)
-- ============================================

-- Test 1 : Commande valide (stock suffisant)
INSERT INTO COMMANDE (NO_PROD, QUANTITE) VALUES (1, 2);
COMMIT;

-- Vérifier que le stock du produit 1 a bien diminué (10 -> 8)
SELECT NO_PROD, DESIGN_PROD, STOCK FROM PRODUIT WHERE NO_PROD = 1;

-- Vérifier que le montant a été calculé automatiquement
SELECT * FROM COMMANDE;

-- Vérifier le journal
SELECT * FROM LOG_STOCK;
