USE bank_finance_db;
SELECT 
COUNT(*) AS Total_transactions,
COUNT(DISTINCT Customer_ID) AS unique_customer,
COUNT(DISTINCT Merchant_Name) AS unique_merchant
FROM transactions_cleaned_dedup;
SELECT
    AVG(Transaction_Amount_Standardized) AS Avg_Transaction,
    MIN(Transaction_Amount_Standardized) AS Min_Transaction,
    MAX(Transaction_Amount_Standardized) AS Max_Transaction,
    STDDEV(Transaction_Amount_Standardized) AS Std_Transaction
FROM transactions_cleaned_dedup;
SELECT
    AVG(CAST(Customer_Age AS DECIMAL(10,2))) AS Avg_Age,
    MIN(CAST(Customer_Age AS DECIMAL(10,2))) AS Min_Age,
    MAX(CAST(Customer_Age AS DECIMAL(10,2))) AS Max_Age,
    STDDEV(CAST(Customer_Age AS DECIMAL(10,2))) AS Std_Age
FROM transactions_cleaned_dedup;
SELECT
    AVG(CAST(Customer_Income AS DECIMAL(15,2))) AS Avg_Income,
    MIN(CAST(Customer_Income AS DECIMAL(15,2))) AS Min_Income,
    MAX(CAST(Customer_Income AS DECIMAL(15,2))) AS Max_Income,
    STDDEV(CAST(Customer_Income AS DECIMAL(15,2))) AS Std_Income
FROM transactions_cleaned_dedup;
SELECT
    AVG(CAST(Account_Balance AS DECIMAL(15,2))) AS Avg_Balance,
    MIN(CAST(Account_Balance AS DECIMAL(15,2))) AS Min_Balance,
    MAX(CAST(Account_Balance AS DECIMAL(15,2))) AS Max_Balance,
    STDDEV(CAST(Account_Balance AS DECIMAL(15,2))) AS Std_Balance
FROM transactions_cleaned_dedup;
SELECT
    CASE
        WHEN Transaction_Amount_Standardized < 100 THEN '0-100'
        WHEN Transaction_Amount_Standardized < 500 THEN '100-500'
        WHEN Transaction_Amount_Standardized < 1000 THEN '500-1000'
        WHEN Transaction_Amount_Standardized < 5000 THEN '1000-5000'
        ELSE '5000+'
    END AS Amount_Range,
    COUNT(*) AS Total_Transactions
FROM transactions_cleaned_dedup
GROUP BY Amount_Range
ORDER BY MIN(Transaction_Amount_Standardized);
SELECT
    CASE
        WHEN CAST(Customer_Age AS UNSIGNED) BETWEEN 18 AND 25 THEN '18-25'
        WHEN CAST(Customer_Age AS UNSIGNED) BETWEEN 26 AND 40 THEN '26-40'
        WHEN CAST(Customer_Age AS UNSIGNED) BETWEEN 41 AND 60 THEN '41-60'
        ELSE '60+'
    END AS Age_Group,
    COUNT(*) AS Total_Transactions
FROM transactions_cleaned_dedup
WHERE Customer_Age IS NOT NULL
GROUP BY Age_Group
ORDER BY MIN(CAST(Customer_Age AS UNSIGNED));
SELECT Merchant_Category, COUNT(*) AS total_transactions,
SUM(Transaction_Amount_Standardized) AS total_amount,
AVG(Transaction_Amount_Standardized) AS Avg_amount
FROM transactions_cleaned_dedup
GROUP BY Merchant_Category 
ORDER BY Merchant_Category;
SELECT
    Country,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Transaction_Amount_Standardized), 2) AS Total_Amount,
    ROUND(AVG(Transaction_Amount_Standardized), 2) AS Average_Amount
FROM transactions_cleaned_dedup
GROUP BY Country
ORDER BY Total_Transactions DESC;
SELECT
    Payment_Channel,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Transaction_Amount_Standardized), 2) AS Total_Amount,
    ROUND(AVG(Transaction_Amount_Standardized), 2) AS Average_Amount
FROM transactions_cleaned_dedup
GROUP BY Payment_Channel
ORDER BY Total_Transactions DESC;
SELECT
    Fraud_Flag,
    COUNT(*) AS Total_Transactions
FROM transactions_cleaned_dedup
GROUP BY Fraud_Flag;
SELECT
    Status,
    COUNT(*) AS Total_Transactions
FROM transactions_cleaned_dedup
GROUP BY Status
ORDER BY Total_Transactions DESC;
SELECT
    Payment_Channel,
    COUNT(*) AS Total_Transactions,
    SUM(CASE WHEN Fraud_Flag = 1 THEN 1 ELSE 0 END) AS Fraud_Transactions,
    ROUND(
        SUM(CASE WHEN Fraud_Flag = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS Fraud_Rate_Percent
FROM transactions_cleaned_dedup
GROUP BY Payment_Channel
ORDER BY Fraud_Rate_Percent DESC;
SELECT
    Payment_Channel,
    COUNT(*) AS Total_Transactions,
    SUM(CASE WHEN Status = 'Declined' THEN 1 ELSE 0 END) AS Declined_Transactions,
    ROUND(
        SUM(CASE WHEN Status = 'Declined' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS Decline_Rate_Percent
FROM transactions_cleaned_dedup
GROUP BY Payment_Channel
ORDER BY Decline_Rate_Percent DESC;
SELECT
    Merchant_Category,
    COUNT(*) AS Total_Transactions,
    SUM(CASE WHEN Fraud_Flag = 1 THEN 1 ELSE 0 END) AS Fraud_Transactions,
    ROUND(
        SUM(CASE WHEN Fraud_Flag = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS Fraud_Rate_Percent
FROM transactions_cleaned_dedup
GROUP BY Merchant_Category
ORDER BY Fraud_Rate_Percent DESC;
SELECT
    Country,
    COUNT(*) AS Total_Transactions,
    SUM(CASE WHEN Fraud_Flag = 1 THEN 1 ELSE 0 END) AS Fraud_Transactions,
    ROUND(
        SUM(CASE WHEN Fraud_Flag = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS Fraud_Rate_Percent
FROM transactions_cleaned_dedup
GROUP BY Country
ORDER BY Fraud_Rate_Percent DESC;
SELECT
    CASE
        WHEN CAST(Customer_Income AS DECIMAL(15,2)) < 25000 THEN 'Below 25K'
        WHEN CAST(Customer_Income AS DECIMAL(15,2)) < 50000 THEN '25K-50K'
        WHEN CAST(Customer_Income AS DECIMAL(15,2)) < 100000 THEN '50K-100K'
        ELSE '100K+'
    END AS Income_Group,
    COUNT(*) AS Total_Transactions
FROM transactions_cleaned_dedup
WHERE Customer_Income IS NOT NULL
GROUP BY Income_Group
ORDER BY MIN(CAST(Customer_Income AS DECIMAL(15,2)));
SELECT
    CASE
        WHEN CAST(Customer_Age AS UNSIGNED) BETWEEN 18 AND 25 THEN '18-25'
        WHEN CAST(Customer_Age AS UNSIGNED) BETWEEN 26 AND 40 THEN '26-40'
        WHEN CAST(Customer_Age AS UNSIGNED) BETWEEN 41 AND 60 THEN '41-60'
        ELSE '60+'
    END AS Age_Group,
    COUNT(*) AS Total_Transactions,
    ROUND(AVG(Transaction_Amount_Standardized), 2) AS Average_Transaction_Amount
FROM transactions_cleaned_dedup
WHERE Customer_Age IS NOT NULL
GROUP BY Age_Group
ORDER BY MIN(CAST(Customer_Age AS UNSIGNED));
SELECT
    CASE
        WHEN CAST(Customer_Income AS DECIMAL(15,2)) < 25000 THEN 'Below 25K'
        WHEN CAST(Customer_Income AS DECIMAL(15,2)) < 50000 THEN '25K-50K'
        WHEN CAST(Customer_Income AS DECIMAL(15,2)) < 100000 THEN '50K-100K'
        ELSE '100K+'
    END AS Income_Group,
    COUNT(*) AS Total_Transactions,
    ROUND(AVG(Transaction_Amount_Standardized), 2) AS Average_Transaction_Amount
FROM transactions_cleaned_dedup
WHERE Customer_Income IS NOT NULL
GROUP BY Income_Group
ORDER BY MIN(CAST(Customer_Income AS DECIMAL(15,2)));
SELECT
    DATE_FORMAT(Transaction_Date_Standarized, '%Y-%m') AS Transaction_Month,
    COUNT(*) AS Total_Transactions,
    SUM(CASE WHEN Fraud_Flag = 1 THEN 1 ELSE 0 END) AS Fraud_Transactions,
    ROUND(
        SUM(CASE WHEN Fraud_Flag = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS Fraud_Rate_Percent
FROM transactions_cleaned_dedup
GROUP BY Transaction_Month
ORDER BY Transaction_Month;
SELECT
    COUNT(*) AS Outlier_Transactions,
    ROUND(MIN(Transaction_Amount_Standardized), 2) AS Lowest_Outlier,
    ROUND(MAX(Transaction_Amount_Standardized), 2) AS Highest_Outlier
FROM transactions_cleaned_dedup
WHERE Transaction_Amount_Standardized >
(
    SELECT AVG(Transaction_Amount_Standardized)
           + 3 * STDDEV(Transaction_Amount_Standardized)
    FROM transactions_cleaned_dedup
);
SELECT
    Transaction_ID,
    Transaction_Amount_Standardized,
    Currency,
    Merchant_Category,
    Country,
    Payment_Channel,
    Fraud_Flag,
    Status
FROM transactions_cleaned_dedup
WHERE Transaction_Amount_Standardized >
(
    SELECT AVG(Transaction_Amount_Standardized)
           + 3 * STDDEV(Transaction_Amount_Standardized)
    FROM transactions_cleaned_dedup
)
ORDER BY Transaction_Amount_Standardized DESC
LIMIT 10;
SELECT
    Fraud_Flag,
    COUNT(*) AS Total_Transactions
FROM transactions_cleaned_dedup
WHERE Transaction_Amount_Standardized >
(
    SELECT AVG(Transaction_Amount_Standardized)
           + 3 * STDDEV(Transaction_Amount_Standardized)
    FROM transactions_cleaned_dedup
)
GROUP BY Fraud_Flag;
SELECT
    Merchant_Category,
    SUM(CASE WHEN Fraud_Flag = 0 THEN 1 ELSE 0 END) AS Non_Fraud,
    SUM(CASE WHEN Fraud_Flag = 1 THEN 1 ELSE 0 END) AS Fraud,
    COUNT(*) AS Total_Transactions,
    ROUND(
        SUM(CASE WHEN Fraud_Flag = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS Fraud_Rate_Percent
FROM transactions_cleaned_dedup
GROUP BY Merchant_Category
ORDER BY Fraud_Rate_Percent DESC;
SELECT
    Country,
    Currency,
    COUNT(*) AS Approved_Transactions,
    ROUND(SUM(Transaction_Amount_Standardized), 2) AS Approved_Transaction_Value
FROM transactions_cleaned_dedup
WHERE Status = 'Approved'
GROUP BY Country, Currency
ORDER BY Country, Currency;