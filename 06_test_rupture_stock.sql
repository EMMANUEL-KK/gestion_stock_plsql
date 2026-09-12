-- ============================================
-- Script 6 : Test rupture de stock (doit être refusé)
-- ============================================

-- Le produit 4 (Écran) a un stock de 5. On tente d'en commander 100.
INSERT INTO COMMANDE (NO_PROD, QUANTITE) VALUES (4, 100);
