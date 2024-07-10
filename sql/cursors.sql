--3. Create Cursors FOR fetching multiple rows from a query(fetch all transactions for a specific account)
CREATE OR REPLACE PROCEDURE get_transactions(p_account_id NUMBER) IS
    CURSOR trans_cursor IS
        SELECT transaction_id, transaction_type, amount, transaction_date
        FROM transactions
        WHERE account_id = p_account_id;

    v_trans trans_cursor%ROWTYPE;
BEGIN
    OPEN trans_cursor;
    LOOP
        FETCH trans_cursor INTO v_trans;
        EXIT WHEN trans_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || v_trans.transaction_id || 
                             ', Type: ' || v_trans.transaction_type || 
                             ', Amount: ' || v_trans.amount || 
                             ', Date: ' || v_trans.transaction_date);
    END LOOP;
    CLOSE trans_cursor;
END get_transactions;
/


