-- Find all accounts given user first and last name
SELECT *
FROM "accounts"
WHERE "user_id" IN (
    SELECT "id"
    FROM "users"
    WHERE "first_name" = 'Adam'
    AND "last_name" = 'Kosa'
);

-- Find all transactions related to a specific type of account of a user
SELECT *
FROM "transactions"
WHERE "account_id" IN (
    SELECT "id"
    FROM "accounts"
    WHERE "user_id" = (
        SELECT "id"
        FROM "users"
        WHERE "first_name" = 'Adam'
        AND "last_name" = 'Kosa'
    )
    AND "type" = 'debit'
);

-- Find all expense transactions for a given user in a specific category
SELECT *
FROM "transactions"
WHERE "type" = 'expense'
AND "category_id" = (
    SELECT "id"
    FROM "categories"
    WHERE "name" = 'utilities'
    AND "account_id" IN (
        SELECT "id"
        FROM "accounts"
        WHERE "user_id" = (
            SELECT "id"
            FROM "users"
            WHERE "first_name" = 'Adam'
            AND "last_name" = 'Kosa'
        )
    )
);

-- Find all categories for a given account
SELECT *
FROM "categories"
WHERE "account_id" IN (
    SELECT "id"
    FROM "accounts"
    WHERE "user_id" = (
        SELECT "id"
        FROM "users"
        WHERE "first_name" = 'Adam'
        AND "last_name" = 'Kosa'
    )
);

-- Find top 10 transactions most amount of money spent
SELECT *
FROM "transactions"
WHERE "category_id" IN (
    SELECT "id"
    FROM "categories"
    WHERE "type" = 'expense'
)
ORDER BY "sum" DESC,
LIMIT 10;

-- Add a new account
INSERT INTO "accounts" ("user_id", "type")
VALUES(1, 'saving');

-- Add a new category
INSERT INTO "categories" ("account_id", "name", "type")
VALUES (1, 'utilities', 'expense');

-- Add a new budget
INSERT INTO "budgets" ("account_id", "category_id", "amount", "period_start", "period_end")
VALUES (1, 1, 50000, 2025-01-01, 2025-03-31);
