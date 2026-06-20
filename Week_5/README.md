# Week 5 – Apache Spark Basics Assignment

## Overview

This assignment demonstrates the fundamentals of Apache Spark using PySpark DataFrames. It covers loading data, cleaning and transforming datasets, filtering records, performing aggregations, grouping data, and building a simple data processing pipeline.

## Objective

* Understand the basics of Apache Spark.
* Learn why Spark is faster than MapReduce.
* Work with Spark DataFrames for data analysis.
* Perform data cleaning and transformation tasks.
* Apply filtering, aggregation, and grouping operations.
* Build an end-to-end Spark pipeline.

## Project Structure

```text
Week_5/
│── data/
│   └── dataset.csv
│
│── notebook/
│   └── spark_basics.ipynb
│
│── output/
│   └── results.csv
│
├── README.md
├── requirements.txt
└── insights.md
```

## Technologies Used

* Python 3
* PySpark
* Jupyter Notebook

## Steps Performed

1. Created a Spark Session using PySpark.
2. Loaded the CSV dataset into a Spark DataFrame.
3. Displayed the first few rows, column names, and schema.
4. Removed duplicate records.
5. Handled missing values using `dropna()` or `fillna()`.
6. Filtered data based on age, category, and region.
7. Renamed columns and converted data types where required.
8. Calculated summary statistics such as:

   * Total row count
   * Average salary
   * Minimum salary
   * Maximum salary
9. Grouped data using `groupBy()` and computed:

   * Count
   * Sum
   * Average
10. Saved the processed results to the `output` folder.

## Key Concepts Learned

### Apache Spark

Apache Spark is a distributed data processing framework designed for fast and scalable analytics. It performs computations primarily in memory, making it significantly faster than traditional disk-based processing frameworks.

### Spark vs. MapReduce

| MapReduce                  | Apache Spark              |
| -------------------------- | ------------------------- |
| Disk-based processing      | In-memory processing      |
| Slower for iterative tasks | Faster execution          |
| Complex programming model  | Easy-to-use DataFrame API |
| Higher latency             | Lower latency             |

### Wide Transformations

Operations such as `groupBy()` and `join()` require data movement across partitions and are known as wide transformations.

### Shuffle

A shuffle is the redistribution of data between partitions during wide transformations. Excessive shuffling can reduce performance.

## Output

The notebook generates:

* Cleaned and transformed DataFrames.
* Filtered datasets.
* Aggregated statistics.
* Grouped analysis results.
* A processed output file stored in the `output` directory.

## Conclusion

This assignment provides hands-on experience with Apache Spark DataFrames and demonstrates how to build a basic data processing pipeline involving loading, cleaning, transforming, filtering, aggregating, and saving data efficiently.
