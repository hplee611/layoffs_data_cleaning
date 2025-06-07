SELECT *
FROM layoffs;

# Create a new table that has same column names as layoffs - do not modify the raw data
CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

# Paste all the data from layoffs
INSERT INTO layoffs_staging
SELECT * 
FROM layoffs;