-- Create the Package to handle banking operations (pacage head)
-- CREATE OR REPLACE PACKAGE banking_pkg AS
--     PROCEDURE create_customer(p_name VARCHAR2, p_address VARCHAR2, p_phone VARCHAR2);
--     PROCEDURE create_account(p_customer_id NUMBER, p_account_type VARCHAR2, p_balance NUMBER);
--     PROCEDURE make_transaction(p_account_id NUMBER, p_transaction_type VARCHAR2, p_amount NUMBER);
-- END banking_pkg;
-- /

--2. Create a Package(contain procedures, functions, and other PL/SQL constructs) TO handle banking operations (pacage head)
CREATE OR REPLACE PACKAGE banking_pkg AS
    PROCEDURE create_customer(p_name VARCHAR2, p_address VARCHAR2, p_phone VARCHAR2);
    PROCEDURE create_account(p_customer_id NUMBER, p_account_type VARCHAR2, p_initial_deposit NUMBER);
    PROCEDURE deposit(p_account_id NUMBER, p_amount NUMBER);
    PROCEDURE withdraw(p_account_id NUMBER, p_amount NUMBER);
    FUNCTION get_balance(p_account_id NUMBER) RETURN NUMBER;
END banking_pkg;
/

------------------------------------------------------------------------------------------------------------------------------

-- PACKAGE BODY
CREATE OR REPLACE PACKAGE BODY banking_pkg AS
    
    PROCEDURE create_customer(p_name VARCHAR2, p_address VARCHAR2, p_phone VARCHAR2) IS
    BEGIN
        INSERT INTO customers (customer_id, name, address, phone)
        VALUES (customers_seq.NEXTVAL, p_name, p_address, p_phone);
    END create_customer;

    
    PROCEDURE create_account(p_customer_id NUMBER, p_account_type VARCHAR2, p_initial_deposit NUMBER) IS
    BEGIN
        INSERT INTO accounts (account_id, customer_id, account_type, balance)
        VALUES (accounts_seq.NEXTVAL, p_customer_id, p_account_type, p_initial_deposit);
    END create_account;

    
    PROCEDURE deposit(p_account_id NUMBER, p_amount NUMBER) IS
    BEGIN
        UPDATE accounts SET balance = balance + p_amount WHERE account_id = p_account_id;
        INSERT INTO transactions (transaction_id, account_id, transaction_type, amount, transaction_date)
        VALUES (transactions_seq.NEXTVAL, p_account_id, 'DEPOSIT', p_amount, SYSDATE);
    END deposit;

    
    PROCEDURE withdraw(p_account_id NUMBER, p_amount NUMBER) IS
    BEGIN
        UPDATE accounts SET balance = balance - p_amount WHERE account_id = p_account_id;
        INSERT INTO transactions (transaction_id, account_id, transaction_type, amount, transaction_date)
        VALUES (transactions_seq.NEXTVAL, p_account_id, 'WITHDRAW', p_amount, SYSDATE);
    END withdraw;

    
    FUNCTION get_balance(p_account_id NUMBER) RETURN NUMBER IS
        v_balance NUMBER;
    BEGIN
        SELECT balance INTO v_balance FROM accounts WHERE account_id = p_account_id;
        RETURN v_balance;
    END get_balance;
    
END banking_pkg;
/

