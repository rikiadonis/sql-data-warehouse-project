# Data Dictionary for Golden Layer
## Overview
The Golden Layer is the business-level representation, structured to support analytical and reporting use cases. Is consistens of **dimension** and **fact** tables for specific business metrics.
### 1. gold.dim_customer
* **Purpose**: Store customer details enriched with demograthic and geograthic data.
* **Columns**:

| Column Name     | Data Type    | Description                                                                           |
|-----------------|--------------|---------------------------------------------------------------------------------------|
| customer_key    | INT          | Surrogate key uniquely idenifying each customer record in dimension table.            |
| customer_id     | INT          | Unique numeric identifier assinged to each customer.                                  |        
| customer_number | NVARCHAR(50) | Alphanumeric identifier representing the customer, used for tracking and referencing. |
| first_name      | NVARCHAR(50) | The customer's first name as recorded in the system.                                  |
| last_name       | NVARCHAR(50) | The customer's last name or family name.                                              |
| country         | NVARCHAR(50) | The country of residence of customer (e.g., 'Australia').                             |
| birthdate       | DATE         | Date of birth of customer, formatted as YYYY-MM-DD (e.g., '1980-01-01').              |
| gender          | NVARCHAR(50) | The gender of customer (e.g., 'Male', 'Female').                                      |

