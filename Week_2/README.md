# Sales Data Analysis using SQL | CEI Internship Week-2

## Project Overview

This project is part of the CEI Internship Week-2 assignment.
The objective of this project is to analyze sales data using SQL queries integrated with Python and SQLite in a Jupyter Notebook environment.

The project demonstrates:

* Data loading into SQL database
* Data exploration
* Filtering using SQL WHERE clause
* Aggregation using GROUP BY
* Sorting and limiting results
* Business problem solving using SQL
* Data validation and quality checks
* Generating business insights from sales data

---

## Technologies Used

* Python
* Pandas
* SQLite
* Jupyter Notebook
* SQL

---

## Project Structure

```bash
Week_2/
│
├── data/
│     └── Sample - Superstore.csv
│
├── notebook/
│     └── sales_analysis.ipynb
│
├── sql/
│     └── queries.sql
│
├── README.md
│
└── requirements.txt
```

---

## Dataset Information

Dataset Used: Sample Superstore Dataset

The dataset contains:

* Order details
* Customer information
* Product categories
* Sales and profit data
* Regional sales information

---

## Tasks Performed

### 1. Data Loading

* Imported CSV dataset using Pandas
* Loaded data into SQLite database

### 2. Data Exploration

* Checked schema and column details
* Viewed sample records
* Analyzed data types and dimensions

### 3. SQL Filtering

Used SQL WHERE clause for:

* Region-wise filtering
* Category-wise filtering
* Sales-based filtering
* Date-based filtering

### 4. Aggregation using GROUP BY

Performed:

* Total sales analysis
* Average profit calculation
* Quantity aggregation
* Category-wise analysis

### 5. Sorting and Limiting

Implemented:

* Top-selling products
* Top customers
* Highest profit categories

### 6. Business Use Cases

Solved real-world analytical queries:

* Monthly sales trends
* Loss-making products
* Best-performing regions
* Duplicate record detection

### 7. Data Validation

Performed:

* Row count validation
* NULL value checks
* Duplicate checks
* Unique category verification

---

## Key Insights

* Technology category generated high revenue.
* West region contributed significantly to total sales.
* Certain products generated losses despite good sales.
* Monthly sales showed seasonal trends.
* A small group of customers contributed major profits.

---

## How to Run the Project

### Step 1: Clone Repository

```bash
git clone <repository-link>
```

### Step 2: Install Dependencies

```bash
pip install -r requirements.txt
```

### Step 3: Launch Jupyter Notebook

```bash
jupyter notebook
```

### Step 4: Open Notebook

Open:

```bash
notebook/sales_analysis.ipynb
```

Run all cells sequentially.

---

## SQL Concepts Used

* SELECT
* WHERE
* GROUP BY
* ORDER BY
* HAVING
* LIMIT
* Aggregate Functions
* DISTINCT
* COUNT
* SUM
* AVG

---

## Learning Outcomes

Through this project, I learned:

* SQL query writing
* Database handling with SQLite
* Data analysis using SQL
* Business analytics concepts
* Data validation techniques
* Integrating SQL with Python

---

## Author

Prince Badgoti
CEI Internship – Week 2 Assignment
