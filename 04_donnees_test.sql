-- ============================================
-- Script 4 : Données de test
-- ============================================

INSERT INTO PRODUIT (NO_PROD, DESIGN_PROD, PRIX_UNITE, STOCK) VALUES (1, 'Ordinateur portable', 6500.00, 10);
INSERT INTO PRODUIT (NO_PROD, DESIGN_PROD, PRIX_UNITE, STOCK) VALUES (2, 'Souris sans fil', 150.00, 50);
INSERT INTO PRODUIT (NO_PROD, DESIGN_PROD, PRIX_UNITE, STOCK) VALUES (3, 'Clavier mécanique', 450.00, 20);
INSERT INTO PRODUIT (NO_PROD, DESIGN_PROD, PRIX_UNITE, STOCK) VALUES (4, 'Écran 24 pouces', 1800.00, 5);

COMMIT;

SELECT * FROM PRODUIT; 