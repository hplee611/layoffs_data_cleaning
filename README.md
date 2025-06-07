# Layoffs Data Cleaning with MySQL

## Project Overview
This project demonstrates a complete data cleaning workflow using SQL on a real-world dataset of company layoffs. The dataset contains inconsistencies, duplicates, null values, and formatting issues that are commonly found in raw business data. The goal is to prepare this dataset for further analysis by transforming it into a clean and reliable structure using only MySQL.

## Tools & Technologies
- MySQL 8.0+
- SQL Window Functions (`ROW_NUMBER()`)
- CTEs, Subqueries, Self Joins
- String manipulation (`TRIM()`)
- Date formatting (`STR_TO_DATE()`)

## Steps Performed

### 1. Create a staging table
- Cloned the structure of the original dataset (`layoffs`) into a staging table to preserve raw data integrity.
- Inserted all data into `layoffs_staging`.

### 2. Remove Duplicates
- Used `ROW_NUMBER()` with `PARTITION BY` across key identifying columns to detect duplicates.
- Created a second staging table (`layoffs_staging2`) and removed all rows where `row_num > 1`.

### 3. Standardize Text Columns
- Trimmed leading/trailing whitespace from `company`, `country`, etc.
- Standardized naming inconsistencies (e.g., "Crypto Currency" → "Crypto").

### 4. Convert Data Types
- Converted the `date` column from string to `DATE` format using `STR_TO_DATE()`.
- Dropped temporary helper columns (e.g., `row_num`) after cleaning.

### 5. Handle Null or Blank Values
- Replaced empty strings with NULLs.
- Used `self JOIN` to fill missing `industry` values from other matching records.
- Deleted records where both `total_laid_off` and `percentage_laid_off` were NULL (unusable data).

## Sample SQL Highlights
```sql
-- Removing duplicates using ROW_NUMBER()
WITH duplicate_cte AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) AS row_num
  FROM layoffs_staging
)
DELETE FROM layoffs_staging2
WHERE id IN (
  SELECT id FROM duplicate_cte WHERE row_num > 1
);

-- Fixing inconsistent industry names
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Converting date format
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;
```

## Dataset Source
This dataset was obtained from a public layoffs dataset shared in a YouTube SQL learning project (Alex The Analyst).

## What I Learned
- SQL can be powerful for full-scale data cleaning without the need for Python or Excel.
- Learned how to apply `ROW_NUMBER()` and `PARTITION BY` to detect duplicates.
- Improved my confidence with `JOIN`, `TRIM`, `UPDATE`, and date functions.
- Practiced writing clean, modular SQL for each stage of the cleaning process.

---

## Next Steps
- Use the cleaned dataset for exploratory data analysis (EDA)
- Create visualizations or reports (Power BI, Tableau, or Python/pandas)
- Upload final outputs and insights as part of a larger portfolio

---

>This project is part of my journey transitioning from a culinary background into data analytics, after completing a degree in software engineering. Feedback is always welcome!
