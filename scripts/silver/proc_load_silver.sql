/*
=================================================================================================
Store Procedure: Load Silver Layer (Bronze -> Silver)
=================================================================================================
Script purpose:
		This stored procedure performs the ETL (Extraxt, Load, Transform) process to 
		populate the 'silver' schema tables from 'bronze' schema.
	Actions Performed:
		- Truncate Tables
		- Inserts transformed and cleansed data Bronze into Silver tables.

Parameters:
	None.
	This stored procedure doed not accept any parameters or return any values.

Usage Exmaple:
	EXEC silver.load_silver;
==================================================================================================
*/

CREATE OR ALTER PROCEDURE silver.load_silver
AS
DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
BEGIN
	BEGIN TRY
		SET @batch_start_time = GETDATE()
		PRINT('=====================================');
		PRINT('Loading Silver Layer');
		PRINT('=====================================');

		PRINT('-------------------------------------');
		PRINT('Loading CMR Table');
		PRINT('-------------------------------------');

		SET @start_time = GETDATE()
		PRINT('>> Truncate Table: silver.cmr_sales_details <<')
		TRUNCATE TABLE silver.cmr_sales_details

		PRINT('>> Inserting Data Into: silver.cmr_sales_details <<')
		INSERT INTO silver.cmr_sales_details(
			sls_ord_num,
			sls_prd_key,
			sls_cust_id,
			sls_order_dt,
			sls_ship_dt,
			sls_due_dt,
			sls_sales,
			sls_quantity,
			sls_price)
		SELECT
		sls_ord_num,
		sls_prd_key,
		sls_cust_id,
		CASE
			WHEN LEN(sls_order_dt) != 8 THEN NULL
			ELSE
				CAST(CAST(sls_order_dt AS NVARCHAR) AS DATE)
		END sls_order_dt,
		CASE
			WHEN LEN(sls_ship_dt) != 8 THEN NULL
			ELSE
				CAST(CAST(sls_ship_dt AS NVARCHAR) AS DATE)
		END sls_ship_dt,
		CASE
			WHEN LEN(sls_due_dt) != 8 THEN NULL
			ELSE
				CAST(CAST(sls_due_dt AS NVARCHAR) AS DATE)
		END sls_due_dt,
		CASE
			WHEN sls_sales <= 0 OR sls_sales IS NULL
			OR sls_sales != sls_price * sls_quantity
			THEN ABS(sls_price) * sls_quantity
			ELSE sls_sales -- Recalculate sales if orginal value is missing or incorrect
		END sls_sales,
		sls_quantity,
		CASE 
			WHEN sls_price <= 0 OR sls_price IS NULL
			THEN ABS(sls_sales) / sls_quantity
			ELSE sls_price
		END sls_price -- Derive price if orginal value is invalid
		FROM bronze.cmr_sales_details

		SET @end_time = GETDATE()
		PRINT('>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds <<')
		PRINT('-------------------------------------');
		
		SET @start_time = GETDATE()
		PRINT('>> Truncate Table: silver.cmr_prd_info <<')
		TRUNCATE TABLE silver.cmr_prd_info

		PRINT('>> Inserting Data Into: silver.cmr_prd_info <<')
		INSERT INTO silver.cmr_prd_info(prd_id, prd_key, cat_id, prd_nm, prd_cost, prd_line, prd_start_dt, prd_end_dt)
		SELECT
			prd_id,
			SUBSTRING(prd_key, 7, LEN(prd_key)) prd_key,
			SUBSTRING(REPLACE(prd_key, '-', '_'), 1, 5) cat_id,
			prd_nm,
			ISNULL(prd_cost, 0) prd_cost,
			CASE UPPER(TRIM(prd_line))
				WHEN 'R' THEN 'Road'
				WHEN 'M' THEN 'Mountain'
				WHEN 'T' THEN 'Touring'
				WHEN 'S' THEN 'Other Sales'
				ELSE 'n/a'
			END prd_line,
			CAST(prd_start_dt AS DATE) prd_start_dt,
			CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS DATE) prd_end_dt
		FROM bronze.cmr_prd_info
		ORDER BY prd_id

		SET @end_time = GETDATE()
		PRINT('>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds <<')
		PRINT('-------------------------------------');
		
		SET @start_time = GETDATE()
		PRINT('>> Truncate Table: silver.cmr_cust_info <<')
		TRUNCATE TABLE silver.cmr_cust_info

		PRINT('>> Insert Data Into: silver.cmr_cust_info <<')
		INSERT INTO silver.cmr_cust_info(
			cst_id,
			cst_key,
			cst_firstname,
			cst_marital_status,
			cst_gndr,
			cst_create_date)

		SELECT
			cst_id,
			cst_key,
			cst_firstname,
			cst_marital_status,
			cst_gndr,
			cst_create_date
		FROM(

			SELECT
				cst_id,
				cst_key,
				TRIM(cst_firstname) cst_firstname,
				TRIM(cst_lastname) cst_lastname,
			CASE UPPER(TRIM(cst_marital_status))
				WHEN 'M' THEN 'Married'
				WHEN 'S' THEN 'Single'
				ELSE 'n/a'
			END cst_marital_status,
			CASE UPPER(TRIM(cst_gndr))
				WHEN 'M' THEN 'Male'
				WHEN 'F' THEN 'Female'
				ELSE 'n/a'
			END cst_gndr,
			cst_create_date,
			ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) flag
			FROM bronze.cmr_cust_info
		)t
		WHERE flag = 1 AND cst_id IS NOT NULL
		ORDER BY cst_id

		SET @end_time = GETDATE()
		PRINT('>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds <<')
		PRINT('-------------------------------------');
		

		PRINT('-------------------------------------');
		PRINT('Loading CMR Table');
		PRINT('-------------------------------------');

		SET @start_time = GETDATE()
		PRINT('>> Truncate Table: silver.erp_px_cat_g1v2 <<')
		TRUNCATE TABLE silver.erp_px_cat_g1v2

		PRINT('>> Insert Data Into: silver.erp_px_cat_g1v2 <<')
		INSERT INTO silver.erp_px_cat_g1v2(
			id,
			cat,
			subcat,
			maintenace)
		SELECT
			*
		FROM bronze.erp_px_cat_g1v2
		SET @end_time = GETDATE()
		PRINT('>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds <<')
		PRINT('-------------------------------------');

		SET @start_time = GETDATE()
		PRINT('>> Truncate Table: silver.erp_cust_az12 <<')
		TRUNCATE TABLE silver.erp_cust_az12

		PRINT('>> Insert Data Into: silver.erp_cust_az12 <<')
		INSERT INTO silver.erp_cust_az12(cid, cdate, gen)
		SELECT
			CASE
				WHEN UPPER(TRIM(SUBSTRING(cid, 1, 3))) = 'NAS' -- Remove 'NAS' prefix if present
				THEN SUBSTRING(cid, 4, LEN(cid))
				ELSE TRIM(cid) 
			END cid,
			CASE	
				WHEN cdate > GETDATE() THEN NULL -- Set future birthday to NULL
				ELSE cdate
			END cdate,
			CASE
				WHEN UPPER(TRIM(gen)) IN ('MALE', 'M') THEN 'Male'
				WHEN UPPER(TRIM(gen)) IN ('FEMALE', 'F') THEN 'Female'
				ELSE 'n/a'
			END gen -- Nprmalize gender values and handle unknown cases
		FROM bronze.erp_cust_az12
		SET @end_time = GETDATE()
		PRINT('>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds <<')
		PRINT('-------------------------------------');

		SET @start_time = GETDATE()
		PRINT('>> Truncate Table: silver.erp_loc_a10 <<')
		TRUNCATE TABLE silver.erp_loc_a101

		PRINT('>> Insert Data Into: silver.erp_loc_a101')
		INSERT INTO silver.erp_loc_a101(cid, cntry)
		SELECT
			REPLACE(cid, '-', '') cid,
			CASE 
				WHEN UPPER(TRIM(cntry)) IN ('US', 'USA') THEN 'United States'
				WHEN UPPER(TRIM(cntry)) = 'DE' THEN 'Germany'
				WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
				ELSE TRIM(cntry)
			END cntry -- Normalize and Handle missing or blank country codes
		FROM bronze.erp_loc_a101
		SET @end_time = GETDATE()
		PRINT('>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds <<')
		PRINT('-------------------------------------');
		SET @batch_end_time = GETDATE()
		PRINT('=====================================');
		PRINT('Silver Layer Load is Completed')
		PRINT('	- Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds')
		PRINT('=====================================');
	END TRY

	BEGIN CATCH
		PRINT('An Error Occurred')
		PRINT('Error Message: ' + ERROR_MESSAGE())
		PRINT('Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR))
		PRINT('Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR))
		PRINT('Error Procedure: ' + ERROR_PROCEDURE())
	END CATCH

END

