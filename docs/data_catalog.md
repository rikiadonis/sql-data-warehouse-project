# Data Dictionary for Gold Layer
## Overview
The Gold Layer is the business-level data representation, structured to support analytical and reporting use cases. It consists of **dimension tables** and **fact tables** for specific business metrics. 

#### 1. gold.dim_customers

* **Purpose**: Stores customer details enriched with demographic and geograthic data.
* **Columns**:


| Column Name    | Data Type    | Description                                                                           |
|----------------|--------------|---------------------------------------------------------------------------------------|
| customer_key   | INT          | Surrogate key uniquely identifying each customer record in dimension table.           |
| customer_id    | INT          | Unique numerical identifier assigned to each customer.                                |
| customer_number | NVARCHAR(50) | Alphanumeric identifier representing the customer, used for tracking and referencing. |
| first_name     | NVARCHAR(50) | The customer's first name, as recorded in the system.                                 |
| last_name      | NVARCHAR(50) | The customer's last name or family name.                                              |
| country        | NVARCHAR(50) | The country of residence for customer (e.g., 'Asutralia').                            |
| marital_status | NVARCHAR(50) | The marital status of customer (e.g., 'Married', 'Single').                           |
| gender         | NVARCHAR(50) | The gender of customer (e.g., 'Male', 'Female').                                      |
| birthdate      | DATE         | The date of birth of customer, formatted as YYYY-MM-DD (e.g., '1971-10-06').          |
| create_date    | DATE         | The date and time when the customer record was created in the system.                 |


#### 2. gold.dim_products

* **Purpose**: Provides information about the products and their attributes.
* **Columns**:

| Column Name    | Data Type    | Description                                                                           |
|----------------|--------------|---------------------------------------------------------------------------------------|
| product_key    | INT          | Surrogate key uniquely identifying each product record in dimension table.           |
| product_id     | INT          | Unique numerical identifier assigned to the product for internal tracking and referencing.                                |
| product_number | NVARCHAR(50) | A structured alphanumeric code representing the product, often used for categorization or inventory. |
| product_name   | NVARCHAR(50) | Descriptive name of the product, including key details such as type, color, and size.                                 |
| category_id    | NVARCHAR(50) | Alphanumeric indentifier represeting each product's category.                                              |
| category       | NVARCHAR(50) | The category of product (e.g., 'Bikes').                            |
| subcategory    | NVARCHAR(50) | The subcategory of product (e.g., 'Mountain Bikes').                           |
| maintenace     | NVARCHAR(50) | The maintenace of product (e.g., 'Yes', 'No').                                      |
| cost           | INT          | The cost of product.           |
| line           | NVARCHAR(50) | The line of product (e.g., 'Mountain').                 |
| start_date     | DATE         | The data when product started YYYY-MM-DD (e.g., '2011-07-01').                 |
| create_date    | DATE         | The date and time when the customer record was created in the system.                 |




