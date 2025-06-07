-- handle nulls

# We have NULL and missing values
SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

# We found that there are companies that have name of industry but also with a blank ('') such as Airbnb.
# In this case, we use JOIN the two rows.
# Before doing that, update the table that has blank('') value to NULL

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;


UPDATE layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;

# After updating the table to get rid of NULL or '', we found that 'Bally's Interactive' has still a NULL value on industry since this doesn't have NOT NULL value (can't find the name of industry).




# There are some NULL values on 'total_laid_off' and 'percentage_laid_off'
# Can we add values on this NULL values? - No
# Why? - We don't know what total_laid_off / percentage_laid_off values would be


SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

# Do we really need the rows that both total_laid_off and percentage_laid_off = NULL? - No
# Should we delete them? - We can't trust the data, so - We can

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


# We don't need row_num column anymore, so we need to delete it
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT * 
FROM layoffs_staging2;