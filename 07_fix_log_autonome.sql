-- ============================================
-- Script 7 : Correction - Log autonome pour les refus
-- ============================================

CREATE OR REPLACE PROCEDURE ENREGISTRER_REFUS(
    p_no_prod NUMBER,
    p_quantite NUMBER,
    p_motif VARCHAR2
) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    INSERT INTO COMMANDE_REFUSEE (NO_PROD, QUANTITE_DEMANDEE, MOTIF)
    VALUES (p_no_prod, p_quantite, p_motif);
    COMMIT;
END;
/

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
        ENREGISTRER_REFUS(:NEW.NO_PROD, :NEW.QUANTITE,
            'Stock insuffisant : demandé ' || :NEW.QUANTITE || ', disponible ' || v_stock_dispo);

        RAISE_APPLICATION_ERROR(-20001, 'Commande refusée : stock insuffisant (disponible : ' || v_stock_dispo || ')');
    END IF;

    :NEW.MONTANT := :NEW.QUANTITE * v_prix;
END;
/