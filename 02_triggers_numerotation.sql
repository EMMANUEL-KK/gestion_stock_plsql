-- ============================================
-- Script 2 : Numérotation automatique des commandes
-- ============================================

-- Séquence pour les numéros de commande
CREATE SEQUENCE SEQ_COMMANDE START WITH 1 INCREMENT BY 1;

-- Trigger d'auto-incrémentation du NO_CMD
CREATE OR REPLACE TRIGGER TRG_COMMANDE_NUM
BEFORE INSERT ON COMMANDE
FOR EACH ROW
WHEN (NEW.NO_CMD IS NULL)
BEGIN
    :NEW.NO_CMD := SEQ_COMMANDE.NEXTVAL;
END;
/