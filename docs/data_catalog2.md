# Data Dictionary for Gold Layer

## Overview
The Gold Layer is the business-level representation, structured to support analytical and reporting use cases. Is consists of **dimension** and **fact** tables for specific business metrics.

### 1. gold.dim_customers
* **Purpose**: Stores customer details enriched with demograthic and geograthic data.
* **Columns**:

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| customer_key | INT       | Surrogate key uniquely indntifying each cistomer record in dimension table. |
