# Data Dictionary for Gold Layer
## Overview
The Gold Layer is business-level representation, structured to support analyticals and reporting use cases. Is consistens of **dimension** and **fact** tables for specific business metrics.
### 1. gold.dim_customers
* **Purpose**: Store details customer enriched with demograthic and geograthic data.
* **Columns**:

| Column Name     | Data Type    | Description                                                                            |
|-----------------|--------------|----------------------------------------------------------------------------------------|
| customer_key    | INT          | Surrogate key uniquely identifying each customer record in dimension table.            |
| customer_id     | INT          | Unique numerical identifier assigned to each customer.                                 |      
| customer_number | NVARCHAR(50) | Alphanumeric identifier representing the customer, used for tracking and referencing.  |
| first_name      | NVARCHAR(50) | The customer's first name, as recorded in the system.                                  |
| last_name       | NVARCHAR(50) | The customer's last name or familiy name.                                              |
| country         | NVARCHAR(50) | The country of residence of customer (e.g., 'Australia').                              |
| birthdate       | DATE         | The date of birth of customer, formatted YYYY-MM-DD (e.g., '1976-01-01').              |
| gender          | NVARCHAR(50) | The gender of customer (e.g., 'Male', 'Female').                                       |
| marital_status  | NVARCHAR(50) | The marital status of customer (e.g., 'Single', 'Married').                            |
| create_date     | DATE         | The data and time when the customer record was created in the system.                  | 

### 2. gold.dim_products
* **Purpose**: Provides information about prodicts and their attributes
* **Columns**:

| Column Name    | Data Type    | Description                                                                                          |
|----------------|--------------|------------------------------------------------------------------------------------------------------|
| product_key    | INT          | Surrogate key uniquely identifying each product record in dimension table.                           |
| product_id     | INT          | Unique numerical identifier assinged to each product for internal tracking and referencing.          |
| product_number | NVARCHAR(50) | A structured alphanumeric code representing the product, often used for categorization or inventory. |
| product_name   | NVARCHAR(50) | Descriptive name of the product, including key details such as type, color and size.                 |
| category_id    | NVARCHAR(50) | A unique identifier for product's category, linking to its high-level classification.                |
