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
| custome_number | NVARCHAR(50) | Alphanumeric identifier representing the customer, used for tracking and referencing. |
| first_name     | NVARCHAR(50) | The customer's first name, as recorded in the system.                                 |
| last_name      | NVARCHAR(50) | The customer's last name or family name.                                              |
| country        | NVARCHAR(50) | The country of residence for customer (e.g., 'Asutralia').                            |
| marital_status | NVARCHAR(50) | The marital status of customer (e.g., 'Married', 'Single').                           |
| gender         | NVARCHAR(50) | The gender of customer (e.g., 'Male', 'Female').                                      |
| birthdate      | DATE         | The date of birth of customer, formatted as YYYY-MM-DD (e.g., '1971-10-06').          |
| create_date    | DATE         | The date and time when the customer record was created in the system.                 |


#### 2. gold.dim_products

* **Purpose**: Stores products details enriched with category, subcategory and maintenace.


