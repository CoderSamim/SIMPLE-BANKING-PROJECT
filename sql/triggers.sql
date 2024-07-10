
--4. create a trigger to prevent withdrawals that would result in a negative balance
CREATE OR REPLACE TRIGGER check_balance
BEFORE UPDATE ON accounts
FOR EACH ROW
WHEN (NEW.balance < 0)
BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds');
END;
/
