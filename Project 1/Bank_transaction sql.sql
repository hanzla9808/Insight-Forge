USE bank_finance_db;
SELECT  COUNT(*)
FROM transaction_raw;
DESCRIBE transaction_raw;
SELECT *
FROM transaction_raw LIMIT 10;
SELECT 
COUNT(*) AS total_rows,
SUM(CASE WHEN Customer_Name IS NULL THEN 1 ELSE 0 END) AS missing_names,
SUM(CASE WHEN Merchant_Name IS NULL THEN 1 ELSE 0 END) AS missing_merchant_name,
 SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS missing_city,
 SUM(CASE WHEN Customer_Age IS NULL THEN 1 ELSE 0 END) AS missing_ages,
 SUM(CASE WHEN Customer_Income IS NULL THEN 1 ELSE 0 END) AS missing_incomes,
 SUM(CASE WHEN Account_Balance IS NULL THEN 1 ELSE 0 END) AS missing_balances
 FROM transaction_raw;
 SHOW COLUMNS FROM transaction_raw;
 ALTER TABLE transaction_raw
 CHANGE COLUMN `ï»¿Transaction_ID` `Transaction_ID` Text;
 SHOW COLUMNS FROM transaction_raw;
 SELECT 
SUM(CASE WHEN Transaction_ID IS NULL OR TRIM(Transaction_ID)='' THEN 1 ELSE 0 END) AS missing_transaction_id,
SUM(CASE WHEN Customer_ID IS NULL OR TRIM(Customer_ID)='' THEN 1 ELSE 0 END) AS missing_Customer_id,
SUM(CASE WHEN Customer_Name IS NULL OR TRIM(Customer_Name)='' THEN 1 ELSE 0 END) AS missing_Customer_Name,
SUM(CASE WHEN Merchant_Name IS NULL OR TRIM(Merchant_Name)='' THEN 1 ELSE 0 END) AS missing_MerchNT_name,
SUM(CASE WHEN Transaction_Date IS NULL OR TRIM(Transaction_Date)='' THEN 1 ELSE 0 END) AS missing_transaction_date,
SUM(CASE WHEN Transaction_Amount IS NULL OR TRIM(Transaction_Amount)='' THEN 1 ELSE 0 END) AS missing_transaction_amount,
SUM(CASE WHEN Currency IS NULL OR TRIM(Currency)='' THEN 1 ELSE 0 END) AS missing_Currency,
SUM(CASE WHEN Card_Type IS NULL OR TRIM(Card_Type)='' THEN 1 ELSE 0 END) AS missing_Card_Type,
SUM(CASE WHEN Merchant_Category IS NULL OR TRIM(Merchant_Category)='' THEN 1 ELSE 0 END) AS missing_Merchant_Category,
SUM(CASE WHEN Country IS NULL OR TRIM(Country)='' THEN 1 ELSE 0 END) AS missing_Country,
SUM(CASE WHEN City IS NULL OR TRIM(City)='' THEN 1 ELSE 0 END) AS missing_City,
SUM(CASE WHEN Transaction_Type IS NULL OR TRIM(Transaction_Type)='' THEN 1 ELSE 0 END) AS missing_transaction_Type,
SUM(CASE WHEN Fraud_Flag IS NULL OR TRIM(Fraud_Flag)='' THEN 1 ELSE 0 END) AS missing_Fraud_Flag,
SUM(CASE WHEN Customer_Age IS NULL OR TRIM(Customer_Age)='' THEN 1 ELSE 0 END) AS missing_Customer_Age,
SUM(CASE WHEN Customer_Income IS NULL OR TRIM(Customer_Income)='' THEN 1 ELSE 0 END) AS missing_Customer_Income,
SUM(CASE WHEN Account_Balance IS NULL OR TRIM(Account_Balance)='' THEN 1 ELSE 0 END) AS missing_Account_Balance,
SUM(CASE WHEN Payment_Channel IS NULL OR TRIM(Payment_Channel)='' THEN 1 ELSE 0 END) AS missing_Payment_Channel,
SUM(CASE WHEN `Status` IS NULL OR TRIM(`Status`)='' THEN 1 ELSE 0 END) AS missing_Status
 FROM transaction_raw;
 SELECT
 Transaction_ID,
 COUNT(*)  AS Occurances
 FROM transaction_raw
 GROUP BY Transaction_ID HAVING COUNT(*) > 1 ;
 SELECT  COUNT(*) FROM(SELECT
 Transaction_ID,
 COUNT(*)  AS Occurances
 FROM transaction_raw
 GROUP BY Transaction_ID HAVING COUNT(*) > 1 ) AS Duplicates;
 SELECT  COUNT(*) FROM(SELECT *
 FROM transaction_raw
 GROUP BY Transaction_ID,Customer_ID,Customer_Name,Merchant_Name,Transaction_Date
 ,Transaction_Amount,Currency,Card_Type,Merchant_Category,Country,City,Transaction_Type,Fraud_Flag,
Customer_Age,Customer_Income,Account_Balance,Payment_Channel,`Status`  HAVING COUNT(*) > 1 ) AS Duplicates;
SELECT  SUM(duplicate_count - 1) FROM(SELECT COUNT(*) AS duplicate_count
 FROM transaction_raw
 GROUP BY Transaction_ID,Customer_ID,Customer_Name,Merchant_Name,Transaction_Date
 ,Transaction_Amount,Currency,Card_Type,Merchant_Category,Country,City,Transaction_Type,Fraud_Flag,
Customer_Age,Customer_Income,Account_Balance,Payment_Channel,`Status`  HAVING COUNT(*) > 1 ) AS Duplicates;
SELECT
Country,
Count(*) AS total_records
FROM transaction_raw GROUP BY Country ORDER BY  Country;
SELECT
UPPER(TRIM(Country)) AS Standerized_country,
COUNT(*) AS total_record
FROM transaction_raw
GROUP BY upper(TRIM(Country))
ORDER BY Standerized_country;
CREATE TABLE transaction_cleaned AS 
SELECT * FROM transaction_raw;
SELECT COUNT(*) AS total_rows
FROM transaction_cleaned;
UPDATE transaction_cleaned
SET Country =
    CASE
        WHEN UPPER(TRIM(Country)) IN ('AUSTRALIA', 'AUSTRLIA')
            THEN 'Australia'
        WHEN UPPER(TRIM(Country)) = 'CANADA'
            THEN 'Canada'
        WHEN UPPER(TRIM(Country)) = 'FRANCE'
            THEN 'France'
        WHEN UPPER(TRIM(Country)) IN ('GERMANY', 'GRMANY')
            THEN 'Germany'
        WHEN UPPER(TRIM(Country)) = 'IRELAND'
            THEN 'Ireland'
        WHEN UPPER(TRIM(Country)) = 'NETHERLANDS'
            THEN 'Netherlands'
        WHEN UPPER(TRIM(Country)) = 'SINGAPORE'
            THEN 'Singapore'
        WHEN UPPER(TRIM(Country)) IN  ('UAE','uae')
            THEN 'UAE'
        WHEN UPPER(TRIM(Country)) = 'UNITED KINGDOM'
            THEN 'United Kingdom'
        WHEN UPPER(TRIM(Country)) IN ('UNITED STATES', 'UNTIED STATES')
            THEN 'United States'
        ELSE TRIM(Country)
    END;
    SELECT Country, COUNT(*) FROM transaction_cleaned
    GROUP BY Country ORDER BY Country;
    SELECT
    Merchant_Category,
    COUNT(*) AS total
FROM transaction_cleaned
GROUP BY Merchant_Category
ORDER BY Merchant_Category;
UPDATE transaction_cleaned
SET Merchant_Category =
    CASE
        WHEN LOWER(TRIM(Merchant_Category)) = 'clothing' THEN 'Clothing'
        WHEN LOWER(TRIM(Merchant_Category)) = 'dining' THEN 'Dining'
        WHEN LOWER(TRIM(Merchant_Category)) = 'electronics' THEN 'Electronics'
        WHEN LOWER(TRIM(Merchant_Category)) = 'entertainment' THEN 'Entertainment'
        WHEN LOWER(TRIM(Merchant_Category)) = 'fuel' THEN 'Fuel'
        WHEN LOWER(TRIM(Merchant_Category)) = 'groceries' THEN 'Groceries'
        WHEN LOWER(TRIM(Merchant_Category)) = 'healthcare' THEN 'Healthcare'
        WHEN LOWER(TRIM(Merchant_Category)) = 'online retail' THEN 'Online Retail'
        WHEN LOWER(TRIM(Merchant_Category)) = 'travel' THEN 'Travel'
        WHEN LOWER(TRIM(Merchant_Category)) = 'utilities' THEN 'Utilities'
        ELSE TRIM(Merchant_Category)
    END;
    SELECT Merchant_Category, COUNT(*) FROM transaction_cleaned
    GROUP BY Merchant_Category
    ORDER BY Merchant_Category;
    SELECT Payment_Channel, COUNT(*) AS total 
    FROM transaction_cleaned
    GROUP BY Payment_Channel
    ORDER BY Payment_Channel;
    UPDATE transaction_cleaned
    SET Payment_Channel=TRIM(Payment_Channel);
     SELECT Payment_Channel, COUNT(*) AS total 
    FROM transaction_cleaned
    GROUP BY Payment_Channel
    ORDER BY Payment_Channel;
    SELECT
    Card_Type,
    COUNT(*) AS total
FROM transaction_cleaned
GROUP BY Card_Type
ORDER BY Card_Type;
SELECT
    Transaction_Type,
    COUNT(*) AS total
FROM transaction_cleaned
GROUP BY Transaction_Type
ORDER BY Transaction_Type;
SELECT
    `Status`,
    COUNT(*) AS total
FROM transaction_cleaned
GROUP BY `Status`
ORDER BY `Status`;
SELECT
    Currency,
    COUNT(*) AS total
FROM transaction_cleaned
GROUP BY Currency
ORDER BY Currency;
SELECT Transaction_Date
FROM transaction_cleaned
LIMIT 30;
SELECT
    SUM(CASE
        WHEN TRIM(Transaction_Date) REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
        THEN 1 ELSE 0
    END) AS `YYYY-MM-DD`,

    SUM(CASE
        WHEN TRIM(Transaction_Date) REGEXP '^[0-9]{4}/[0-9]{2}/[0-9]{2}$'
        THEN 1 ELSE 0
    END) AS `YYYY/MM/DD`,

    SUM(CASE
        WHEN TRIM(Transaction_Date) REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
        THEN 1 ELSE 0
    END) AS `DD/MM/YYYY`,

    SUM(CASE
        WHEN TRIM(Transaction_Date) REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
        THEN 1 ELSE 0
    END) AS `MM-DD-YYYY`,

    SUM(CASE
        WHEN TRIM(Transaction_Date) REGEXP '^[0-9]{1,2} [A-Za-z]{3} [0-9]{4}$'
        THEN 1 ELSE 0
    END) AS `DD Mon YYYY`,

    SUM(CASE
        WHEN Transaction_Date IS NULL OR TRIM(Transaction_Date) = ''
        THEN 1 ELSE 0
    END) AS `Missing Dates`

FROM transaction_cleaned;
ALTER TABLE transaction_cleaned
ADD COLUMN Transaction_Date_Standarized DATE;
UPDATE transaction_cleaned
SET Transaction_Date_Standarized =
    CASE
        WHEN TRIM(Transaction_Date) REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
            THEN STR_TO_DATE(TRIM(Transaction_Date), '%Y-%m-%d')

        WHEN TRIM(Transaction_Date) REGEXP '^[0-9]{4}/[0-9]{2}/[0-9]{2}$'
            THEN STR_TO_DATE(TRIM(Transaction_Date), '%Y/%m/%d')

        WHEN TRIM(Transaction_Date) REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
            THEN STR_TO_DATE(TRIM(Transaction_Date), '%d/%m/%Y')

        WHEN TRIM(Transaction_Date) REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
            THEN STR_TO_DATE(TRIM(Transaction_Date), '%m-%d-%Y')

        WHEN TRIM(Transaction_Date) REGEXP '^[0-9]{1,2} [A-Za-z]{3} [0-9]{4}$'
            THEN STR_TO_DATE(TRIM(Transaction_Date), '%d %b %Y')

        ELSE NULL
    END;
    SELECT
    SUM(CASE
        WHEN TRIM(Transaction_Date_Standarized) REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
        THEN 1 ELSE 0
    END) AS `YYYY-MM-DD`,

    SUM(CASE
        WHEN TRIM(Transaction_Date_Standarized) REGEXP '^[0-9]{4}/[0-9]{2}/[0-9]{2}$'
        THEN 1 ELSE 0
    END) AS `YYYY/MM/DD`,

    SUM(CASE
        WHEN TRIM(Transaction_Date_Standarized) REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'
        THEN 1 ELSE 0
    END) AS `DD/MM/YYYY`,

    SUM(CASE
        WHEN TRIM(Transaction_Date_Standarized) REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
        THEN 1 ELSE 0
    END) AS `MM-DD-YYYY`,

    SUM(CASE
        WHEN TRIM(Transaction_Date_Standarized) REGEXP '^[0-9]{1,2} [A-Za-z]{3} [0-9]{4}$'
        THEN 1 ELSE 0
    END) AS `DD Mon YYYY`,

    SUM(CASE
        WHEN Transaction_Date IS NULL OR TRIM(Transaction_Date_Standarized) = ''
        THEN 1 ELSE 0
    END) AS `Missing Dates`

FROM transaction_cleaned;
SELECT Transaction_Amount
FROM transaction_cleaned
LIMIT 30;
SELECT
    SUM(CASE
        WHEN TRIM(Transaction_Amount) REGEXP '^[0-9]+\\.?[0-9]*$'
        THEN 1 ELSE 0
    END) AS Plain_Numbers,

    SUM(CASE
        WHEN TRIM(Transaction_Amount) REGEXP '^\\$[0-9,]+\\.?[0-9]*$'
        THEN 1 ELSE 0
    END) AS Dollar_Symbol,

    SUM(CASE
        WHEN UPPER(TRIM(Transaction_Amount)) REGEXP '^[0-9,.]+ USD$'
        THEN 1 ELSE 0
    END) AS USD_Text

FROM transaction_cleaned;
SELECT Transaction_Amount
FROM transaction_cleaned
WHERE NOT (
    TRIM(Transaction_Amount) REGEXP '^[0-9]+\\.?[0-9]*$'
    OR TRIM(Transaction_Amount) REGEXP '^\\$[0-9,]+\\.?[0-9]*$'
    OR UPPER(TRIM(Transaction_Amount)) REGEXP '^[0-9,.]+ USD$'
);
ALTER TABLE transaction_cleaned
ADD COLUMN Transaction_Amount_Standardized DECIMAL(15,2);
UPDATE transaction_cleaned
SET Transaction_Amount_Standardized =
    CAST(
        REPLACE(
            REPLACE(
                REPLACE(
                    UPPER(TRIM(Transaction_Amount)),
                    '$', ''
                ),
                ' USD', ''
            ),
            ',', ''
        ) AS DECIMAL(15,2)
    );
    SELECT
    COUNT(*) AS Negative_Amount_Count,
    MIN(Transaction_Amount_Standardized) AS Minimum_Amount,
    MAX(Transaction_Amount_Standardized) AS Maximum_Amount
FROM transaction_cleaned
WHERE Transaction_Amount_Standardized < 0;
SELECT Customer_Age, COUNT(*) AS Total
FROM transaction_cleaned
WHERE CAST(Customer_Age AS UNSIGNED) < 18
   OR CAST(Customer_Age AS UNSIGNED) > 100
GROUP BY Customer_Age;
UPDATE transaction_cleaned
SET Customer_Age = NULL
WHERE TRIM(Customer_Age) <> ''
AND (
    CAST(Customer_Age AS SIGNED) < 18
    OR CAST(Customer_Age AS SIGNED) > 100
);
SELECT Customer_Income
FROM transaction_cleaned
WHERE CAST(Customer_Income AS DECIMAL(15,2)) < 0
GROUP BY Customer_Income;
UPDATE transaction_cleaned
SET Customer_Income = NULL
WHERE TRIM(Customer_Income) REGEXP '^-[0-9]+(\\.[0-9]+)?$';
SELECT Account_Balance
FROM transaction_cleaned
WHERE TRIM(Account_Balance) REGEXP '^-[0-9]+(\\.[0-9]+)?$'
GROUP BY Account_Balance;
SELECT City, COUNT(*) AS Total
FROM transaction_cleaned
WHERE City IS NOT NULL
  AND TRIM(City) <> ''
GROUP BY City
ORDER BY City;
SELECT Merchant_Name, COUNT(*) AS Total
FROM transaction_cleaned
WHERE Merchant_Name IS NOT NULL
  AND TRIM(Merchant_Name) <> ''
GROUP BY Merchant_Name
ORDER BY Merchant_Name;
UPDATE transaction_cleaned
SET City= TRIM(City);
SELECT Merchant_Name, COUNT(*) AS Total
FROM transaction_cleaned
WHERE Merchant_Name IS NOT NULL
  AND TRIM(Merchant_Name) <> ''
GROUP BY Merchant_Name
ORDER BY Merchant_Name;
UPDATE transaction_cleaned
SET
    Account_Balance = NULLIF(TRIM(Account_Balance), ''),
    Customer_Income = NULLIF(TRIM(Customer_Income), ''),
    Customer_Age = NULLIF(TRIM(Customer_Age), ''),
    City = NULLIF(TRIM(City), ''),
    Merchant_Name = NULLIF(TRIM(Merchant_Name), '');
    SELECT
    SUM(Account_Balance IS NULL) AS Missing_Account_Balance,
    SUM(Customer_Income IS NULL) AS Missing_Customer_Income,
    SUM(Customer_Age IS NULL) AS Missing_Customer_Age,
    SUM(City IS NULL) AS Missing_City,
    SUM(Merchant_Name IS NULL) AS Missing_Merchant_Name
FROM transaction_cleaned;
SELECT COUNT(*) AS Duplicate_Groups
FROM (
    SELECT COUNT(*) AS Total
    FROM transaction_cleaned
    GROUP BY
        Transaction_ID, Customer_ID, Customer_Name,
        Merchant_Name, Transaction_Date, Transaction_Amount,
        Currency, Card_Type, Merchant_Category, Country,
        City, Transaction_Type, Fraud_Flag, Customer_Age,
        Customer_Income, Account_Balance, Payment_Channel, Status
    HAVING COUNT(*) > 1
) AS duplicates;
SELECT SUM(Total - 1) AS Extra_Duplicate_Rows
FROM (
    SELECT COUNT(*) AS Total
    FROM transaction_cleaned
    GROUP BY
        Transaction_ID, Customer_ID, Customer_Name,
        Merchant_Name, Transaction_Date, Transaction_Amount,
        Currency, Card_Type, Merchant_Category, Country,
        City, Transaction_Type, Fraud_Flag, Customer_Age,
        Customer_Income, Account_Balance, Payment_Channel, Status
    HAVING COUNT(*) > 1
) AS duplicates;
CREATE TABLE transactions_cleaned_dedup AS
SELECT DISTINCT *
FROM transaction_cleaned;
SELECT COUNT(*) AS Total_Rows
FROM transactions_cleaned_dedup;
SELECT Transaction_ID, COUNT(*) AS Total
FROM transactions_cleaned_dedup
GROUP BY Transaction_ID
HAVING COUNT(*) > 1
ORDER BY Total DESC;
SELECT *
FROM transactions_cleaned_dedup
WHERE Transaction_ID = 'TXN121181';