# 🛒 Week 8 - E-Commerce Order Analytics System

## 📌 Overview

The **E-Commerce Order Analytics System** is an end-to-end data engineering project developed as part of the **Celebal Technologies (CEI) Internship - Week 8 Assignment**.

The project simulates a real-world e-commerce analytics pipeline where raw order data is generated, cleaned, validated, loaded into a SQLite database, analyzed using SQL, and finally presented through a command-line reporting tool.

---

## 🎯 Objectives

- Generate realistic e-commerce datasets using Python
- Introduce intentional data quality issues
- Clean and validate data using Pandas
- Store cleaned data in SQLite
- Perform business analytics using SQL
- Build a Python CLI reporting tool
- Handle edge cases through automated test cases

---

# 🛠 Technologies Used

- Python 3.x
- Pandas
- NumPy
- Faker
- SQLite3
- SQL
- Jupyter Notebook
- Git & GitHub

---

# 📂 Project Structure

```
Week_8/
│
├── data/
│   ├── raw/
│   │   ├── customers.csv
│   │   ├── products.csv
│   │   ├── orders.csv
│   │   └── order_items.csv
│   │
│   └── cleaned/
│       ├── customers_clean.csv
│       ├── products_clean.csv
│       ├── orders_clean.csv
│       └── order_items_clean.csv
│
├── database/
│   └── ecommerce.db
│
├── reports/
│   └── issues_report.txt
│
├── scripts/
│   ├── generate_data.py
│   ├── load_sqlite.py
│   ── report_cli.py
│   
│
├── sql/
│   ├── schema.sql
│   ├── aggregations.sql
│   ├── window_functions.sql
│   └── cohort_analysis.sql
│
├── clean_data.ipynb
├── requirements.txt
└── README.md
```

---

# 🚀 Project Workflow

```
Generate Fake Data
        │
        ▼
Raw CSV Files
        │
        ▼
Data Cleaning & Validation
        │
        ▼
Clean CSV Files
        │
        ▼
SQLite Database
        │
        ▼
SQL Analytics
        │
        ▼
Business Reports
        │
        ▼
Command Line Reporting Tool
```

---

# 📊 Dataset

The project generates four realistic datasets.

### Customers

- Customer ID
- Customer Name
- Email
- Registration Date
- Customer Type

### Products

- Product ID
- Product Name
- Category
- Subcategory
- Cost Price

### Orders

- Order ID
- Customer ID
- Order Date
- Status
- Region Code

### Order Items

- Item ID
- Order ID
- Product ID
- Quantity
- Unit Price
- Discount Percentage

---

# ⚠ Data Quality Issues Introduced

The generated datasets intentionally include common real-world data quality issues:

- 5% Missing Customer IDs
- 3% Negative Quantities
- Incorrect Date Formats
- Extra Spaces in Product Names
- Mixed Case Product Names
- Invalid Email Addresses
- Referential Integrity Validation

---

# 🧹 Data Cleaning

The cleaning notebook performs:

- Date format correction
- Missing value handling
- Product name normalization
- Email validation
- Referential integrity checks
- Issue reporting

Output files are saved inside:

```
data/cleaned/
```

---

# 🗄 Database

SQLite is used to store cleaned data.

Tables created:

- customers
- products
- orders
- order_items

The schema includes:

- Primary Keys
- Foreign Keys
- Constraints
- Indexes

---

# 📈 SQL Analytics

## Basic Queries

- Revenue by Category
- Top 10 Customers
- Monthly Order Count

## Intermediate Queries

- Customers Without Delivered Orders
- Products With More Returns Than Purchases
- Return Rate by Category

## Advanced Queries

- Running Total
- DENSE_RANK()
- LAG()
- Multi-Level CTE
- NTILE()
- Year-over-Year Comparison
- First & Last Purchase Analysis
- Cumulative Distribution
- Cohort Analysis
- Frequently Bought Together Products

---

# 💻 Command Line Report

The CLI allows users to generate reports by selecting:

- Daily
- Weekly
- Monthly

The report includes:

- Total Orders
- Total Revenue
- Unique Customers
- Top 3 Products
- Revenue Comparison with Previous Period

Example:

```
==================================================
REPORT SUMMARY
==================================================

Total Orders : 698

Revenue : ₹5,845,321.75

Unique Customers : 481

Top Products

Laptop Pro
Wireless Mouse
Bluetooth Speaker

Revenue Change : 11.84%
```

---

# 🧪 Edge Case Testing

The project validates several edge cases.

- Invalid Order IDs
- Discount Greater Than 100%
- Zero Quantity
- Future Order Dates

---

# ▶️ How to Run

## Clone Repository

```bash
git clone <repository-url>
```

---

## Install Dependencies

```bash
pip install -r requirements.txt
```

---

## Generate Data

```bash
cd scripts

python generate_data.py
```

---

## Clean Data

Open and execute:

```
clean_data.ipynb
```

---

## Load SQLite Database

```bash
python load_sqlite.py
```

---

## Execute SQL Queries

Run:

```
schema.sql
aggregations.sql
window_functions.sql
cohort_analysis.sql
```

using SQLiteStudio or the SQLite CLI.

---

## Run CLI Report

```bash
python report_cli.py
```

---



# 📸 Sample Outputs

Add screenshots of:

- Generated CSV files
- Cleaned datasets
- SQLite tables
- SQL query outputs
- CLI report
- Issues report

inside a `screenshots/` folder.

---

# 📚 Learning Outcomes

Through this project, I learned:

- Data Generation using Faker
- Data Cleaning with Pandas
- Data Validation Techniques
- SQLite Database Design
- SQL Analytics
- Window Functions
- Common Table Expressions (CTEs)
- Python & SQL Integration
- Business Reporting
- Git & GitHub Project Management

---

# 👨‍💻 Author

**Prince Badgoti**

CEI Data Engineering Internship

Celebal Technologies

---

## 📄 License

This project is created for educational purposes as part of the **Celebal Technologies CEI Internship Week 8 Assignment**.