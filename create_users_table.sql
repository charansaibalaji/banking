-- Enable foreign keys (only works in SQLite)
PRAGMA foreign_keys = ON;

CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    phone_number TEXT NOT NULL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE security_questions (
    question_id INTEGER PRIMARY KEY,
    question_text TEXT NOT NULL
);

CREATE TABLE user_security_answers (
    user_id INTEGER,
    question_id INTEGER,
    answer TEXT NOT NULL,
    PRIMARY KEY (user_id, question_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (question_id) REFERENCES security_questions(question_id)
);

CREATE TABLE accounts (
    account_id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    account_number TEXT NOT NULL UNIQUE,
    balance REAL DEFAULT 100000.00,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE transactions (
    transaction_id INTEGER PRIMARY KEY,
    account_id INTEGER NOT NULL,
    description TEXT,
    amount REAL,
    transaction_type TEXT CHECK(transaction_type IN ('credit', 'debit')),
    transaction_date TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY,
    sender_id INTEGER NOT NULL,
    receiver_account_number TEXT NOT NULL,
    amount REAL,
    status TEXT CHECK(status IN ('success', 'failed')),
    processed_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(user_id)
);
