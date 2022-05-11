# create a new table to save the cleaned brand table
CREATE TABLE cleaned_brands
SELECT *
FROM brands;

# show the entir cleaned_brand table
SELECT *
FROM cleaned_brands;

# delete all the rows with lots of NULL values in columns, brandcode, category, categorycode
ALTER TABLE cleaned_brands DROP COLUMN barcode,DROP COLUMN category,DROP COLUMN categorycode, DROP COLUMN brandcode;

# verify if there is any duplicate rows---no duplicate rows
SELECT id, COUNT(*)
FROM cleaned_brands
GROUP BY id
HAVING COUNT(*)>1;

# quality issue 1 -----too many data with NULL values




