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
| customer_number| NVARCHAR(50) | Alphanumeric identifier representing the customer, used for tracking and referencing. |
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

| Column Name    | Data Type    | Description                                                                                                                     |
|----------------|--------------|---------------------------------------------------------------------------------------------------------------------------------|
| product_key    | INT          | Surrogate key uniquely identifying each product record in dimension table.                                                      |
| product_id     | INT          | Unique numerical identifier assigned to the product for internal tracking and referencing.                                      |
| product_number | NVARCHAR(50) | A structured alphanumeric code representing the product, often used for categorization or inventory.                            |
| product_name   | NVARCHAR(50) | Descriptive name of the product, including key details such as type, color, and size.                                           |
| category_id    | NVARCHAR(50) | A unique identifier for product's category, linking to its high-level classification.                                           |
| category       | NVARCHAR(50) | The broader classification of the product (e.g., 'Bikes', 'Components') to group related items.                                 |
| subcategory    | NVARCHAR(50) | A more detailed classification of the product within the category, such as product type (e.g., 'Mountain Bikes', 'Road Frames').|
| maintenace     | NVARCHAR(50) | Indicates whether the product requires maintenace (e.g., 'Yes', 'No').                                                          |
| cost           | INT          | The cost or base price of the product, measured in monetary units                                                               |
| line           | NVARCHAR(50) | The specific product line or series to wich the product belongs (e.g., 'Mountain', 'Road').                                     |
| start_date     | DATE         | The data when product became available for sale or use, sorted in                                                               |

#### 3. gold.fact_sales

* **Purpose**: Stores transactional sales data for analytical purposes
* **Columns**:

| Column Name    | Data Type    | Description                                                                                                                     |
|----------------|--------------|---------------------------------------------------------------------------------------------------------------------------------|
| order_number   | NVARCHAR(50) | Surrogate key uniquely identifying each product record in dimension table.                                                      |
| product_key    | INT          | Surrogete key linking the order to the product dimension table                                      |
| customer_key   | NVARCHAR(50) | A structured alphanumeric code representing the product, often used for categorization or inventory.                            |
| order_date     | DETE         | Descriptive name of the product, including key details such as type, color, and size.                                           |
| ship_date      | DATE         | A unique identifier for product's category, linking to its high-level classification.                                           |
| due_date       | NVARCHAR(50) | The broader clasification of the product (e.g., 'Bikes', 'Components') to group related items.                                  |
| sales_amount   | INT          | A more detailed classification of the product within the category, such as product type (e.g., 'Mountain Bikes', 'Road Frames').|
| quantity       | INT          | Indicates whether the product requires maintenace (e.g., 'Yes', 'No').                                                          |
| price          | INT          | The cost or base price of the product, measured in monetary units                                                               |
                  
