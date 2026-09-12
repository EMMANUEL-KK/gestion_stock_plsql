-- ============================================
-- Script 3 : Gestion automatique du stock
-- ============================================

-- Trigger 1 : Empêcher une commande si la quantité dépasse le stock disponible
CREATE OR REPLACE TRIGGER TRG_VERIF_STOCK
BEFORE INSERT ON COMMANDE
FOR EACH ROW
DECLARE
    v_stock_dispo NUMBER;
    v_prix NUMBER;
BEGIN
    SELECT STOCK, PRIX_UNITE INTO v_stock_dispo, v_prix
    FROM PRODUIT
    WHERE NO_PROD = :NEW.NO_PROD;

    IF :NEW.QUANTITE > v_stock_dispo THEN
        INSERT INTO COMMANDE_REFUSEE (NO_PROD, QUANTITE_DEMANDEE, MOTIF)
        VALUES (:NEW.NO_PROD, :NEW.QUANTITE, 'Stock insuffisant : demandé ' || :NEW.QUANTITE || ', disponible ' || v_stock_dispo);

        RAISE_APPLICATION_ERROR(-20001, 'Commande refusée : stock insuffisant (disponible : ' || v_stock_dispo || ')');
    END IF;

    -- Calcul automatique du montant de la commande
    :NEW.MONTANT := :NEW.QUANTITE * v_prix;
END;
/

-- Trigger 2 : Mettre à jour le stock après une commande validée
CREATE OR REPLACE TRIGGER TRG_MAJ_STOCK
AFTER INSERT ON COMMANDE
FOR EACH ROW
BEGIN
    UPDATE PRODUIT
    SET STOCK = STOCK - :NEW.QUANTITE
    WHERE NO_PROD = :NEW.NO_PROD;

    INSERT INTO LOG_STOCK (USERNAME, OPERATION, DETAILS)
    VALUES (USER, 'COMMANDE', 'Commande N°' || :NEW.NO_CMD || ' - Produit ' || :NEW.NO_PROD || ' - Quantité: ' || :NEW.QUANTITE);
END;
/