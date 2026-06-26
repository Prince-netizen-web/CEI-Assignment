# Week 6 – Apache Spark Architecture and Data Processing

## Objective

The objective of this assignment is to understand Apache Spark architecture and perform efficient data processing using PySpark. The assignment demonstrates how Spark handles data transformations, lazy evaluation, schema management, filtering, null value handling, and optimized storage formats such as Parquet.

---

## Technologies Used

* Python 3.x
* Apache Spark (PySpark)
* Jupyter Notebook
* Pandas (optional)
* Java (required for Spark)

---

## Project Structure

```text
Week_6/
│── data/
│   └── employees.csv
│
│── output/
│   ├── csv_output/
│   └── parquet_output/
│
│── notebook.ipynb
│── insights.md
│── requirements.txt
│── README.md

```

---

## Tasks Performed

* Created a Spark Session.
* Read data from a CSV file with automatic schema inference.
* Displayed the dataset and inspected its schema.
* Handled missing (null) values using `fillna()`.
* Renamed columns using `withColumnRenamed()`.
* Cast data types using `cast()`.
* Added a new derived column (`annual_salary`).
* Filtered records based on salary conditions.
* Selected only the required columns.
* Saved the processed data in both CSV and Parquet formats.
* Read the Parquet file back to verify the output.

---

## Spark Concepts Covered

### Spark Architecture

* Driver Program
* Cluster Manager
* Executors
* Tasks and Parallel Execution

### Lazy Evaluation

Spark delays execution of transformations until an action such as `show()`, `count()`, or `write()` is invoked. This allows Spark to optimize execution through a Directed Acyclic Graph (DAG).

### Transformations Used

* `filter()`
* `select()`
* `withColumn()`
* `withColumnRenamed()`

### Actions Used

* `show()`
* `printSchema()`
* `write()`

### Performance Concepts

* Lazy Evaluation
* DAG Optimization
* Wide vs. Narrow Transformations
* Shuffle Operations
* Predicate Pushdown
* Efficient Schema Handling

---

## CSV vs Parquet

| CSV                       | Parquet                   |
| ------------------------- | ------------------------- |
| Row-based storage         | Column-based storage      |
| Larger file size          | Compressed and efficient  |
| Slower analytical queries | Faster analytical queries |
| Does not store schema     | Stores schema metadata    |
| Human-readable            | Optimized binary format   |

Parquet generally provides better performance and storage efficiency for large-scale data processing.

---

## Output

The processed dataset is generated in:

* `output/csv_output/`
* `output/parquet_output/`

The final dataset contains:

* Name
* Category
* Department
* Monthly Salary
* Annual Salary

---

## Key Learnings

* Understood the architecture and execution model of Apache Spark.
* Learned how lazy evaluation improves execution efficiency.
* Performed DataFrame transformations and actions using PySpark.
* Handled missing values and managed data schemas effectively.
* Built a simple ETL-style pipeline: **Read → Transform → Filter → Write**.
* Compared CSV and Parquet formats and observed their impact on performance.
* Followed Spark best practices by avoiding unnecessary operations like `collect()` on large datasets.

---

## How to Run

1. Install the required dependencies:

```bash
pip install -r requirements.txt
```

2. Open and execute `notebook.ipynb` 


3. Check the generated files in the `output/` directory.

---

## Conclusion

This assignment demonstrates the fundamentals of Apache Spark for scalable data processing. By leveraging DataFrame transformations, lazy evaluation, schema management, and efficient storage formats like Parquet, Spark enables fast and optimized processing of large datasets while following modern data engineering best practices.
