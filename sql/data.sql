-- Insert initial data
INSERT INTO customers (customer_id, name, address, phone) VALUES (1, 'John Doe', '123 Elm Street', '555-1234');
INSERT INTO accounts (account_id, customer_id, account_type, balance) VALUES (1, 1, 'Checking', 1000);
INSERT INTO transactions (transaction_id, account_id, transaction_type, amount, transaction_date) VALUES (1, 1, 'Deposit', 1000, SYSDATE);
