-- Exploratory Data Analysis

SELECT *
FROM layoffs_staging2
;

# date range verification
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2	
;

# which companies had 100 percent of they company laid off
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
;

# companies with the biggest layoff in the single day
SELECT company, total_laid_off, `date`
FROM layoffs_staging2
ORDER BY 2 DESC LIMIT 5
;

# companies with the most total layoff
SELECT company, SUM(total_laid_off) AS sum_of_total_layoff
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC LIMIT 5
;

# by country
SELECT country, SUM(total_laid_off) AS sum_of_total_layoff
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC
;

# by year
SELECT YEAR(`date`) AS year, SUM(total_laid_off) AS sum_of_total_layoff
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY YEAR(`date`)
ORDER BY 1 DESC
;

# by industry
SELECT industry, SUM(total_laid_off) AS sum_of_total_layoff
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC
;

# by stage
SELECT stage, SUM(total_laid_off) AS sum_of_total_layoff
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC
;

# rolling total of layoffs per month
WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) AS dates, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY dates
ORDER BY 1 DESC
)
SELECT dates, total_off
, SUM(total_off) OVER(ORDER BY dates) AS rolling_total
FROM Rolling_Total
;