-- DATA CLEANING


SELECT * FROM layoffs;

-- Create a staging table for cleaning
CREATE TABLE layoffs_staging LIKE layoffs;

-- Copy data into the staging table
INSERT INTO layoffs_staging
SELECT * FROM layoffs;


SELECT * FROM layoffs_staging;
-- Remove Duplicates


-- Identify duplicate records
WITH duplicate_cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY company, 
                            location, 
                            industry, 
                            total_laid_off, 
                            percentage_laid_off, 
                            'date', 
                            stage, 
                            country, 
                            funds_raised_millions
           ) AS row_num
    FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Check data for a specific company
SELECT * 
FROM layoffs_staging
WHERE company = 'Casper';

-- Create a second staging table for further cleaning
CREATE TABLE `layoffs_staging2` (
  `company` TEXT DEFAULT NULL,
  `location` TEXT DEFAULT NULL,
  `industry` TEXT DEFAULT NULL,
  `total_laid_off` INT(11) DEFAULT NULL,
  `percentage_laid_off` TEXT DEFAULT NULL,
  `date` TEXT DEFAULT NULL,
  `stage` TEXT DEFAULT NULL,
  `country` TEXT DEFAULT NULL,
  `funds_raised_millions` INT(11) DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



-- View the second staging table
SELECT * FROM layoffs_staging2;

-- Copy data into layoffs_staging2 with row number for duplicates
INSERT INTO layoffs_staging2
SELECT *,
       ROW_NUMBER() OVER (
           PARTITION BY company, 
                        location, 
                        industry, 
                        total_laid_off, 
                        percentage_laid_off, 
                        'date', 
                        stage, 
                        country, 
                        funds_raised_millions
       ) AS row_num
FROM layoffs_staging;

DELETE  FROM layoffs_staging2 WHERE row_num > 1;

-- View the cleaned data in layoffs_staging2
SELECT * FROM layoffs_staging2;


-- Standardize the Data
UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT COMPANY FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';


UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT DISTINCT(country)
FROM layoffs_staging2;

SELECT `date`,
str_to_date(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = str_to_date(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- Handle Null or Blank Values
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

delete
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


SELECT DISTINCT(country)
FROM layoffs_staging2
WHERE country IS NULL;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

update layoffs_staging2
set industry = NULL
where industry = '';

SELECT *
FROM layoffs_staging2 st1
JOIN layoffs_staging2 st2
	ON st1.company = st2.company
where (st1.industry is null or st1.industry = '')
and st2.industry is not null;



update layoffs_staging2 st1
JOIN layoffs_staging2 st2
	ON st1.company = st2.company
set st1.industry = st2.industry
where (st1.industry is null )
and st2.industry is not null;

select company, industry 
from 
layoffs_staging2 
where company = 'Airbnb';


-- Remove Any Unnecessary Columns
SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;




