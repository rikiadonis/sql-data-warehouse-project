/*
=============================================================================
Quality Checks 
=============================================================================
Script Purpose:
  This script perfroms quality checks to validate the integrity, consistency, 
  and accuracy of Gold Layer. Thsese checks ensure:
  - Uniqueness of surrogate keys in dimension tables.
  - Referential integrity between fact and dimension tables.
  - Validation of relationship in the data model for analytical purposes.

Usage Notes:
  - Run these checks after data loading Silver Layer
  - Investigate and resolve any discrepnacies found during the checks.
==============================================================================
*/

-- =====================================================
-- Checking 'gold.dim_customers'
-- =====================================================
-- Check for Uniqueness of Customer Key in gold.dim_customers
-- Expectation: No results
SELECT
  customer_key,
  COUNT(*)
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- =====================================================
-- Checking 'gold.dim_products'
-- =====================================================
-- Check for Uniqueness of Customer Key in gold.dim_products
-- Expecation: No results
SELECT
  product_key,
  COUNT(*)
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ======================================================
-- Checking 'gold.fact_sales'
-- ======================================================
-- Check the data connectivity between fact and dimension 
SELECT
  *
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c ON s.customer_key = c.customer_key
LEFT JOIN gold.dim_products p ON s.product_key = p.product_key
WHERE c.customer_key IS NULL
OR p.product_key IS NULL
