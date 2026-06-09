/*
==============================================================================
Quality Checks
==============================================================================
Script Purpose:
  This script performes various quality checks for data consistency, accuracy, 
  and standarization across the 'silver' schemas. It includes checks for:
  - Null or duplicate primary keys.
  - Unwanted spaces in string fields.
  - Data standarization & consistency
  - Invalid date ranges and orders
  - Data consistency between related fields.

Usage Notes:
  - Run these checks after data loading Silver Layer.
  - Investiage and resolve any discrepancies found during the checks.
===============================================================================
*/

-- ============================================================
-- Checking 'silver.cmr_cust_info'
-- ============================================================
-- Check for NULLs or duplicates in Primary Key
-- Expectation: No Results
SELECT
  cst_id,
  COUNT(*)
FROM silver.cmr_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

-- Check for unwanted spaces
-- Expectation: No Result
SELECT 
	cst_firstname,
	cst_lastname,
  cst_marital_status,
  cst_gndr
FROM silver.cmr_cust_info
WHERE cst_firstname != TRIM(cst_firstname)
OR cst_lastname != TRIM(cst_lastname)
OR cst_marital_status != TRIM(cst_marital_status)
OR cst_gndr != TRIM(cst_gndr)

-- Data Standarization & Consistency
SELECT DISTINCT 
  cst_marital_status
FROM silver.cmr_cust_info

SELECT DISTINCT 
  cst_gndr
FROM silver.cmr_cust_info

-- ============================================================
-- Checking 'silver.cmr_prd_info'
-- ============================================================
-- Check for NULLs or duplicates in Primary Key
-- Expectation: No Results
SELECT
	prd_id,
	COUNT(*)
FROM silver.cmr_prd_info
GROUP BY prd_id 
HAVING COUNT(*) > 1 OR prd_id IS NULL

-- Check for unwanted spaces
-- Expectation: No Results
SELECT
	prd_key,
	cat_id,
	prd_nm,
	prd_line
FROM silver.cmr_prd_info
WHERE prd_key != TRIM(prd_key)
OR cat_id != TRIM(cat_id)
OR prd_line != TRIM(prd_line)

-- Check for NULLs or Negative Numbers
-- Expectation: No Result
SELECT
	prd_cost
FROM silver.cmr_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

-- Data Standarization & Consistency
SELECT DISTINCT
	prd_line
FROM silver.cmr_prd_info

-- Check for Invalid Date Orders
-- Expectation: No Results
SELECT
	*
FROM bronze.cmr_prd_info
WHERE prd_start_dt > prd_end_dt






