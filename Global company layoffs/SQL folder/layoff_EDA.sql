-- View the cleaned dataset
SELECT * FROM layoffs_staging2;

-- Find the maximum number of layoffs and the maximum percentage of layoffs
SELECT MAX(total_laid_off) AS max_layoffs, MAX(percentage_laid_off) AS max_percentage_laid_off
FROM layoffs_staging2;

-- Find companies where 100% of employees were laid off, ordered by highest funds raised
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Total layoffs per company, ordered by highest layoffs
SELECT company, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY company
ORDER BY total_layoffs DESC;

-- Find the earliest and latest recorded layoffs dates
SELECT MIN(`date`) AS earliest_layoff, MAX(`date`) AS latest_layoff
FROM layoffs_staging2;

-- Total layoffs per industry, ordered by highest layoffs
SELECT industry, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY industry
ORDER BY total_layoffs DESC;

-- Total layoffs per country, ordered by highest layoffs
SELECT country, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY country
ORDER BY total_layoffs DESC;

-- Total layoffs per year, ordered by highest layoffs
SELECT YEAR(`date`) AS layoff_year, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY layoff_year
ORDER BY total_layoffs DESC;

-- Total layoffs per company stage.
SELECT stage, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY stage
ORDER BY total_layoffs DESC;

-- Find the top 3 companies with the highest layoffs per year
WITH Company_Year AS 
(
  SELECT company, YEAR(date) AS layoff_year, SUM(total_laid_off) AS total_layoffs
  FROM layoffs_staging2
  GROUP BY company, YEAR(date)
)
, Company_Year_Rank AS (
  SELECT company, layoff_year, total_layoffs, 
         DENSE_RANK() OVER (PARTITION BY layoff_year ORDER BY total_layoffs DESC) AS ranking
  FROM Company_Year
)
SELECT company, layoff_year, total_layoffs, ranking
FROM Company_Year_Rank
WHERE ranking <= 3 AND layoff_year IS NOT NULL
ORDER BY layoff_year ASC, total_layoffs DESC;

-- Monthly trend of total layoffs
SELECT SUBSTRING(date,1,7) AS layoff_month, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY layoff_month
ORDER BY layoff_month ASC;

-- Calculate rolling total layoffs over time (cumulative layoffs per month)
WITH DATE_CTE AS 
(
    SELECT SUBSTRING(date,1,7) AS layoff_month, SUM(total_laid_off) AS total_layoffs
    FROM layoffs_staging2
    GROUP BY layoff_month
    ORDER BY layoff_month ASC
)
SELECT layoff_month, SUM(total_layoffs) OVER (ORDER BY layoff_month ASC) AS rolling_total_layoffs
FROM DATE_CTE
ORDER BY layoff_month ASC;
