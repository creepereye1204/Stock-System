CREATE TABLE users (
    user_id VARCHAR2(20) PRIMARY KEY,
    balance NUMBER(20, 2) DEFAULT 0
);

CREATE TABLE currencies (
    currency_code VARCHAR2(3) PRIMARY KEY,
    exchange_rate NUMBER(20, 6)
);

CREATE TABLE transactions (
    tx_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id VARCHAR2(20),
    currency_code VARCHAR2(3),
    amount NUMBER(20, 2),
    tx_type VARCHAR2(10), -- 'BUY', 'SELL'
    tx_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO users (user_id, balance) VALUES ('admin', 1000000);
INSERT INTO currencies (currency_code, exchange_rate) VALUES ('USD', 1.0);
INSERT INTO currencies (currency_code, exchange_rate) VALUES ('KRW', 1300.0);
INSERT INTO currencies (currency_code, exchange_rate) VALUES ('JPY', 140.0);

COMMIT;
