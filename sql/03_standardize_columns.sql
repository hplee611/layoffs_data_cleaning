-- Standardizing data

# First, retrieve distinct data of each column by using SELECT DISTINCT

# Trimming company names (white spaces)
SELECT company, Trim(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);


# Check if there is any duplicates under industry
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY industry;

# We found there are 'Crypto', 'Crypto Currency', 'CryptoCurrency' which all needs to be same name
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';


# We found that there are two 'United States' under country column, so we need to remove the one that has '.'. 
SELECT DISTINCT country
FROM layoffs_staging2
WHERE country LIKE 'United States%';

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT DISTINCT country
from layoffs_staging2
ORDER BY 1;


# We want to change the `date` format from string to date
SELECT `date`,
str_to_date(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = str_to_date(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoffs_staging2;

# Still, the `date` format is text
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;