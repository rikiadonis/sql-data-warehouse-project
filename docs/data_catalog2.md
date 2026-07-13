# Data Dictionary for Gold Layer
## Overview
The gold Layer is the business-level representation, structured to support analytics and reporting case. It consistens of **dimension** and **fact** tables for specific business metrics.
### 1. gold.dim_customers
* **Purpose**: Store data customer enriched demograthic and geograthic data.
* **Columns**:

| Column Name  | Data Type | Description                                                           |
|--------------|-----------|-----------------------------------------------------------------------|
| customer_key | INT       | Numeric uniquely indentifyer each reacord customer in demension table | 
