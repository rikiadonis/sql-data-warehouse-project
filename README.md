# Data Warehouse and Analytics Project
Welcome to **Data Warehouse and Analytics Project** repository! 

This projects demonstrates a comprehensive data warehousing and analytics solution, from building a data warehouse to generating actionable insights. Designed as portfolio project highlights industry best practices in data engineering and analytics.

---
## Project Overview 
This project involves:
 1. **Data Architecture**: Designing a Modern Data Warehouse Using Medalion Architecture **Bronze**, **Silver**, and **Gold** layers.
 2. **ETL Pipelines**: Extracting, transforming, and loading data from source into the warehouse.
 3. **Data Modeling**: Developing fact and dimension tables optimized for analytical queries.
 4. **Analytics & Reporting**: Creating SQL-based reports and dashboards for actionable insights.

This repository is an excellent resource for professionals and students looking to showcase expertise in:

* SQL Development
* Data Architect
* Data Engineering
* ETL Pipeline Developer
* Data Modeling
* Data Analytics

---

## Important Links & Tools:

Everything is for Free!

* Datasets: Access to project dataset (csv files.)
* SQL Server Express: Lightweight server for hosting your SQL database.
* SQL Server Management Studio (SSMS): GUI for managing and interacting with databases.
* GIT Repository: Set up a GitHub account and repository to manage, version and collaborate on your code efficiently.
* DrawiIO: Design data architecture, models, flows, and diagrams.
* Notion: All-in-one tool for project management and organization.
* Notion Project Steps: Access to All Projects Phases and Tasks.
 
## Project Requirements

### Building the Data Warehouse (Data Engineering)

#### Objective 
Develop a modern data warehouse using SQL Server to consolidate data sales, enabling analytical reporting and informed decision-making.

#### Specifications
- **Data Sources**: Import data from two sources system (ERP and CRM) provided as CSV files.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope**: Focus on the latest dataset only; historization of data is not required.
- **Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics teams.

---

### BI: Analytics & Reporting (Data Analytics)

#### Objective
Develop SQL-based analytics to deliver detailed insights into:
- **Customer Behavior**
- **Product Performance**
- **Sales Trends**

These insights empower stakeholders with key business metrics, enabling strategic decision-making.

---

## Data Architecture
The data architecture for this project follows Medallion Architecture **Bronze**, **Silver**, and **Gold** layers:
<img width="1071" height="651" alt="data_architecture drawio" src="https://github.com/user-attachments/assets/e8ab5eed-f342-4492-9231-0401d5b40254" />
1. **Bronze Layer**: stores raw data as-is from source systems. Data is ingested from CSV Files into SQL Server.
2. **Silver Layer**: This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.
3. **Gold Layer**: Houses business-ready data modeled into a star schema required for reporting and analytics. 
---

## License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and share this project with proper attribution.
