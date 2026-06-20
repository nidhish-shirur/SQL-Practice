# --- Data Cleaning ---

SELECT *
FROM layoffs;

-- 1. Remove Duplicates
-- 2. Standardize Data
-- 3. Null Values
-- 4. Remove Any Columns


# we make a staging table so that the raw data is kept as it is
CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT layoffs_staging
SELECT *
FROM layoffs;

SELECT *
FROM layoffs_staging;


# adding row numbers to make it easier
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) 
AS row_num
FROM layoffs_staging;


# we make a layoffs_staging2 table to delete the duplicates
# right click on layoffs_staging -> copy to clipboard -> create statement -> paste below
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int		# we add a new columns here
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

# empty columns created
SELECT *
FROM layoffs_staging2;

# insert values into those columns
INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) 
AS row_num
FROM layoffs_staging;

# check for duplicates
SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

# delete duplicates
DELETE
FROM layoffs_staging2
WHERE row_num > 1;

# check
SELECT *
FROM layoffs_staging2
WHERE row_num > 1;



# --- Standardizing Data ---

-- 1. update TRIM
SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT company
FROM layoffs_staging2;



-- 2. update industry column
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

# we can see that: Crypto, Crypto Currency, CryptoCurrency - all refer to the same thing so we must combine those
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

# almost 90% are crypto, so we will update the other two to become crypto
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

# check 1
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

# check 2
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;



-- 3. check country column
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

# as you can see, United States is repeated 2 times
SELECT *
FROM layoffs_staging2
WHERE country = 'United States.';

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';

SELECT *
FROM layoffs_staging2
WHERE country = 'United States.';

# another way to do it is:
-- SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
-- FROM layoffs_staging2
-- ORDER BY 1;

-- UPDATE layoffs_staging2
-- SET country = TRIM(TRAILING '.' FROM country)
-- WHERE country LIKE 'United States%';



-- 4. now date is currently a text datatype, we need to change it to datetime datatype
SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')		# two parameters, 1. which column, 2. what date format is currently used
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoffs_staging2;


# if we notice, it is in date format, but the datatype is still text. 
# it is imp to convert it into date format before converting into datetime datatype

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;



-- 5. Handling NULL and blank values

# -- 1. industry column have some blank values which we can populate --
# e.g. lets take airbnb
SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

# there are two air bnb laid offs and one is travel industry, so the blank one will also be travel industry
# we can do this with JOIN

# first lets update the blanks with NULL
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2		# t1 and t2 are the same
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



# -- 2. lets handle total_laid_off column --
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

# now there is no use of these rows so we'll delete them
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;



-- 6. REMOVING COLUMNS
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;