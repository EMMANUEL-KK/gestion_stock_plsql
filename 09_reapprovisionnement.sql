-- ============================================
-- Script 9 : Réapprovisionnement automatique
-- ============================================

-- Table des demandes de réapprovisionnement
CREATE TABLE DEMANDE_REAPPRO (
    ID_DEMANDE NUMBER PRIMARY KEY,
    NO_PROD NUMBER REFERENCES PRODUIT(NO_PROD),
    STOCK_ACTUEL NUMBER,
    QUANTITE_SUGGEREE NUMBER,
    DATE_DEMANDE DATE DEFAULT SYSDATE,
    STATUT VARCHAR2(20) DEFAULT 'EN_ATTENTE'
);

CREATE SEQUENCE SEQ_DEMANDE_REAPPRO START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER TRG_DEMANDE_REAPPRO_ID
BEFORE INSERT ON DEMANDE_REAPPRO
FOR EACH ROW
BEGIN
    :NEW.ID_DEMANDE := SEQ_DEMANDE_REAPPRO.NEXTVAL;
END;
/

-- Trigger : après mise à jour du stock, vérifier s'il faut réapprovisionner
CREATE OR REPLACE TRIGGER TRG_ALERTE_REAPPRO
AFTER UPDATE OF STOCK ON PRODUIT
FOR EACH ROW
WHEN (NEW.STOCK < 10)
DECLARE
    v_demande_existante NUMBER;
BEGIN
    -- Vérifier qu'il n'y a pas déjà une demande en attente pour ce produit
    SELECT COUNT(*) INTO v_demande_existante
    FROM DEMANDE_REAPPRO
    WHERE NO_PROD = :NEW.NO_PROD AND STATUT = 'EN_ATTENTE';

    IF v_demande_existante = 0 THEN
        INSERT INTO DEMANDE_REAPPRO (NO_PROD, STOCK_ACTUEL, QUANTITE_SUGGEREE)
        VALUES (:NEW.NO_PROD, :NEW.STOCK, 50 - :NEW.STOCK);
    END IF;
END;
/