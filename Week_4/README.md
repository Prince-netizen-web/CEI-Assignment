# Week 4 Assignment - Azure Cloud Fundamentals and Data Pipeline using Azure Data Factory

## Objective

The objective of this assignment is to understand Azure Cloud fundamentals and build a complete data pipeline using Azure Storage Account and Azure Data Factory (ADF).

## Technologies Used

- Microsoft Azure
- Azure Resource Group
- Azure Storage Account
- Azure Blob Storage
- Azure Data Factory (ADF)
- CSV File

## Tasks Performed

### Task 1: Resource Group
- Created a new Azure Resource Group.
- Verified successful deployment.

### Task 2: Storage Setup
- Created an Azure Storage Account.
- Created Blob Containers (`input` and `output`).
- Uploaded a sample CSV file (`sales.csv`) to the `input` container.

### Task 3: Azure Data Factory Basics
- Created an Azure Data Factory instance.
- Explored the Author, Monitor, and Manage sections.
- Configured an Azure Blob Storage Linked Service.
- Created source and destination datasets.
- Configured a Get Metadata activity to validate the source file.

### Task 4: Pipeline Development
- Created a pipeline using the Copy Data activity.
- Configured source and destination datasets.
- Connected activities to build a complete data pipeline.

### Task 5: Pipeline Execution
- Executed the pipeline using Debug/Trigger.
- Verified successful execution.
- Confirmed that the CSV file was copied to the destination container.

### Task 6: IAM Roles
- Reviewed and configured Azure IAM role assignments.
- Ensured proper access between Azure Data Factory and Azure Storage.

## Mini Project

Implemented an end-to-end Azure Data Factory pipeline that:

- Reads a CSV file from Azure Blob Storage.
- Performs metadata validation using Get Metadata.
- Copies the file to a destination Blob container.
- Executes successfully without errors.

## Folder Structure

```
Week_4/
│── README.md
│── sample_data/
│   └── sales.csv
│── screenshots/
│   ├── resource_group.png
│   ├── storage_container.png
│   ├── linked_service.png
│   ├── dataset.png
│   ├── get_metadata.png
│   ├── pipeline_design.png
│   ├── pipeline_success.png
│   └── iam_roles.png
```

## Outcome

Successfully created and executed an Azure Data Factory pipeline that reads data from Azure Blob Storage, validates metadata, and copies the data to a new destination location.

## Author

**Prince Badgoti**