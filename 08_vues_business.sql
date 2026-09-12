-- ============================================
-- Script 8 : Vues de reporting business
-- ============================================

-- Vue 1 : Chiffre d'affaires total par produit
CREATE OR REPLACE VIEW V_CA_PAR_PRODUIT AS
SELECT
    p.NO_PROD,
    p.DESIGN_PROD,
    NVL(SUM(c.MONTANT), 0) AS CHIFFRE_AFFAIRES,
    NVL(SUM(c.QUANTITE), 0) AS QUANTITE_VENDUE
FROM PRODUIT p
LEFT JOIN COMMANDE c ON p.NO_PROD = c.NO_PROD
GROUP BY p.NO_PROD, p.DESIGN_PROD;

-- Vue 2 : Produits en alerte de stock bas (seuil : 10 unités)
CREATE OR REPLACE VIEW V_ALERTE_STOCK AS
SELECT
    NO_PROD,
    DESIGN_PROD,
    STOCK,
    CASE
        WHEN STOCK = 0 THEN 'RUPTURE'
        WHEN STOCK < 10 THEN 'CRITIQUE'
        ELSE 'OK'
    END AS NIVEAU_ALERTE
FROM PRODUIT
WHERE STOCK < 10;

-- Vue 3 : Tableau de bord des commandes refusées (analyse des pertes potentielles)
CREATE OR REPLACE VIEW V_PERTES_POTENTIELLES AS
SELECT
    cr.NO_PROD,
    p.DESIGN_PROD,
    COUNT(*) AS NB_REFUS,
    SUM(cr.QUANTITE_DEMANDEE * p.PRIX_UNITE) AS CA_PERDU_ESTIME
FROM COMMANDE_REFUSEE cr
JOIN PRODUIT p ON cr.NO_PROD = p.NO_PROD
GROUP BY cr.NO_PROD, p.DESIGN_PROD;