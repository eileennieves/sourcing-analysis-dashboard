CREATE DATABASE it_sourcing_analysis;
USE it_sourcing_analysis;

-- Vendors table
CREATE TABLE vendors (
    vendor_id INT PRIMARY KEY,
    vendor_name VARCHAR(100),
    contact_email VARCHAR(100),
    preferred_vendor BOOLEAN
);

-- Software Contracts table
CREATE TABLE software_contracts (
    contract_id INT PRIMARY KEY,
    vendor_id INT,
    software_name VARCHAR(100),
    license_type VARCHAR(50),
    start_date DATE,
    end_date DATE,
    total_cost DECIMAL(12, 2),
    FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id)
);

-- Spend Records table
CREATE TABLE spend_records (
    spend_id INT PRIMARY KEY,
    contract_id INT,
    spend_month DATE,
    amount_spent DECIMAL(10, 2),
    FOREIGN KEY (contract_id) REFERENCES software_contracts(contract_id)
);

-- Renewals table
CREATE TABLE renewals (
    renewal_id INT PRIMARY KEY,
    contract_id INT,
    renewal_date DATE,
    renewal_cost DECIMAL(10,2),
    FOREIGN KEY (contract_id) REFERENCES software_contracts(contract_id)
);

INSERT INTO vendors (vendor_id, vendor_name, contact_email, preferred_vendor)
VALUES
(1, 'TechNova Inc.', 'contact@technova.com', TRUE),
(2, 'CloudWare Solutions', 'sales@cloudware.com', FALSE),
(3, 'DataSecure LLC', 'support@datasecure.com', TRUE);

INSERT INTO software_contracts (contract_id, vendor_id, software_name, license_type, start_date, end_date, total_cost)
VALUES
(101, 1, 'NovaCRM', 'SaaS', '2024-01-01', '2025-01-01', 25000.00),
(102, 2, 'CloudOffice', 'Subscription', '2023-06-15', '2024-06-14', 18000.00),
(103, 3, 'SecureVault', 'Perpetual', '2022-11-01', '2030-11-01', 50000.00);

INSERT INTO spend_records (spend_id, contract_id, spend_month, amount_spent)
VALUES
(1, 101, '2024-01-01', 2083.33),
(2, 101, '2024-02-01', 2083.33),
(3, 102, '2024-01-01', 1500.00),
(4, 103, '2024-01-01', 0.00);  -- Perpetual license, no monthly spend

INSERT INTO renewals (renewal_id, contract_id, renewal_date, renewal_cost)
VALUES
(1, 101, '2025-01-01', 26000.00),
(2, 102, '2024-06-14', 18500.00);

SELECT 
    v.vendor_name,
    SUM(sr.amount_spent) AS total_spent
FROM 
    vendors v
JOIN 
    software_contracts sc ON v.vendor_id = sc.vendor_id
JOIN 
    spend_records sr ON sc.contract_id = sr.contract_id
GROUP BY 
    v.vendor_name
ORDER BY 
    total_spent DESC;
SELECT 
    sc.software_name,
    sr.spend_month,
    SUM(sr.amount_spent) AS monthly_spend
FROM 
    software_contracts sc
JOIN 
    spend_records sr ON sc.contract_id = sr.contract_id
GROUP BY 
    sc.software_name, sr.spend_month
ORDER BY 
    sr.spend_month;
SELECT 
    sc.software_name,
    r.renewal_date,
    r.renewal_cost
FROM 
    renewals r
JOIN 
    software_contracts sc ON r.contract_id = sc.contract_id
WHERE 
    r.renewal_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 6 MONTH)
ORDER BY 
    r.renewal_date;
SELECT 
    v.vendor_name,
    SUM(sr.amount_spent) AS total_spend
FROM 
    vendors v
JOIN 
    software_contracts sc ON v.vendor_id = sc.vendor_id
JOIN 
    spend_records sr ON sc.contract_id = sr.contract_id
WHERE 
    v.preferred_vendor = TRUE
GROUP BY 
    v.vendor_name;

