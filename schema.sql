-- Represent users using the application
CREATE TABLE "users" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Represent existing accounts
CREATE TABLE "accounts" (
    "id" INTEGER,
    "user_id" INTEGER,
    "type" TEXT NOT NULL CHECK (type IN ('debit', 'credit', 'saving')),
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id")
);

-- Represent executed transactions
CREATE TABLE "transactions" (
    "id" INTEGER,
    "account_id" INTEGER,
    "category_id" INTEGER,
    "type" TEXT NOT NULL CHECK (type IN ('income', 'expense')),
    "date" TEXT NOT NULL,
    "sum" REAL NOT NULL CHECK ("sum" > 0),
    "description" TEXT,
    PRIMARY KEY("id"),
    FOREIGN KEY("account_id") REFERENCES "accounts"("id"),
    FOREIGN KEY("category_id") REFERENCES "categories"("id")
);

-- Represent possible categories of a transaction
CREATE TABLE "categories" (
    "id" INTEGER,
    "account_id" INTEGER,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL CHECK (type IN ('income', 'expense')),
    PRIMARY KEY("id"),
    FOREIGN KEY("account_id") REFERENCES "accounts"("id")
);

-- Represent budget for a given period
CREATE TABLE "budgets" (
    "id" INTEGER,
    "account_id" INTEGER,
    "category_id" INTEGER,
    "amount" NUMERIC(12, 2) NOT NULL CHECK ("amount" >= 0),
    "period_start" TEXT NOT NULL,
    "period_end" TEXT NOT NULL,
    CHECK ("period_end" >= "period_start"),
    PRIMARY KEY("id"),
    FOREIGN KEY("account_id") REFERENCES "accounts"("id"),
    FOREIGN KEY("category_id") REFERENCES "categories"("id")
);

-- Create indexes to speed common searches
CREATE INDEX "transaction_date_search" ON "transactions" ("date");
CREATE INDEX "transaction_category_search" ON "transactions" ("category_id");
CREATE INDEX "transaction_account_search" ON "transactions" ("account_id");
