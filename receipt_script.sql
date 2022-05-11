# create a new table to save the cleaned receipt table
CREATE TABLE cleaned_receipt
SELECT *
FROM receipt;

# show the entire cleaned_brand table
SELECT *
FROM cleaned_receipt;

# verify if there is any duplicate rows---no duplicate rows
SELECT `_id.$oid`, COUNT(*)
FROM `sqltest`.`cleaned_receipt`
GROUP BY `_id.$oid`
HAVING COUNT(`_id.$oid`)>1;

# create a new table to save deleted table without duplicated rows
CREATE TABLE cleaned_receipt2 LIKE cleaned_receipt;

# insert the new data into the new receipt table
INSERT INTO cleaned_receipt2
SELECT *
FROM cleaned_receipt
GROUP BY `_id.$oid`;

# drop previous receipt table and rename the lastest version of cleaned_receipt2 to cleaned_receipt
DROP TABLE cleaned_receipt;
ALTER TABLE cleaned_receipt2 RENAME TO cleaned_receipt;

# data quality issue2-----some data in column 'totalspent' are supposed to be int type, but some are float type

# data quality issue3-----data lengths in column ' rewardsreceiptItemList.barcode' are not consistent, and there are 169 rows of barcode named '4011'.
SELECT COUNT(`rewardsReceiptItemList.barcode`)
FROM cleaned_receipt
WHERE `rewardsReceiptItemList.barcode`='4011';