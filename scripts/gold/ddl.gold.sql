/*
=================================================================================
DDL Scripts: Create Gold Views
=================================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse.
    The Gold Layer reperesents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
=================================================================================
*/
-- ==============================================================================
-- Create Dimension: gold.dim_customer
-- ==============================================================================
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
  DROP VIEW gold.dim_customers
GO
CREATE VIEW gold.dim_customers AS
SELECT
	ROW_NUMBER() OVER(ORDER BY ci.cst_id) customer_key,
	ci.cst_id customer_id,
	ci.cst_key customer_number,
	ci.cst_firstname first_name,
	ci.cst_lastname last_name,
	la.cntry country,
	ca.cdate birthdate,
	CASE 
		WHEN cst_gndr != 'n/a' THEN cst_gndr
		ELSE COALESCE(ca.gen, 'n/a')
	END gender,
	ci.cst_marital_status,
	ci.cst_create_date
	FROM silver.cmr_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la ON ci.cst_key = la.cid

-- ==============================================================================
-- Create Dimension: gold.dim_products
-- ==============================================================================
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
  DROP VIEW gold.dim_products
GO
CREATE VIEW gold.dim_products AS
SELECT
	ROW_NUMBER() OVER(ORDER BY cpi.prd_start_dt, cpi.prd_key) product_key,
	cpi.prd_id product_id,
	cpi.prd_key product_number,
	cpi.prd_nm name,
	cpi.cat_id category_id,
	cat.cat category,
	cat.subcat subcategory,
	cat.maintenance,
	cpi.prd_cost cost,
	cpi.prd_line product_line,
	cpi.prd_start_dt start_date
FROM silver.cmr_prd_info cpi
LEFT JOIN silver.erp_px_cat_g1v2 cat ON cpi.cat_id = cat.id
WHERE cpi.prd_end_dt IS NULL

-- ==============================================================================
-- Create Fact: gold.fact_sales
-- ==============================================================================
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
  DROP VIEW gold.fact_sales
GO
CREATE VIEW gpld.fact_sales AS
SELECT
	sls_ord_num order_number,
	p.product_key product_key,
	c.customer_key customer_key,
	sd.sls_order_dt order_date,
	sd.sls_ship_dt ship_date,
	sd.sls_due_dt due_date,
	sd.sls_sales sales_amount,
	sd.sls_quantity quantity,
	sd.sls_price price
FROM silver.cmr_sales_details sd
LEFT JOIN gold.dim_customers c ON sd.sls_cust_id = c.customer_id
LEFT JOIN gold.dim_products p ON sd.sls_prd_key = p.product_number
