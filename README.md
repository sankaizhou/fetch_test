# fetch_test
/*-----------------------------------------------------Script for data modeling by creating new table to import cleaned data-----------------------------*/
# create a new table for brand to perform data modeling
DROP TABLE IF EXISTS new_brand;
CREATE TABLE new_brand(
	brand_id varchar(50),
    barcode varchar(50),
    brandCode varchar(50),
    category varchar(50),
    categoryCode varchar(50),
    cpg varchar(50),
    Topbrand Boolean,
    brand_name varchar(50),
    
    CONSTRAINT pk_brand PRIMARY KEY(brand_id)
    );
    
# create a new table for receipt to perform data modeling
DROP TABLE IF EXISTS new_receipt;
CREATE TABLE new_receipt(
	receipt_id varchar(50),
    bonusPointsEarned varchar(50),
    pointsEarned varchar(50),
    purchasedItemCount varchar(50),
    barcode varchar(50),
    finalPrice varchar(50),
    itemPrice varchar(50),
    needsFetchReview varchar(50),
    partnerItemId varchar(50),
    preventTargetGapPoints varchar(50),
    quantityPurchased varchar(50),
    userFlaggedBarcode varchar(50),
    userFlaggedNewItem varchar(50),
    userFlaggedPrice varchar(50),
    userFlaggedQuantity varchar(50),
    pointsPayerId varchar(50),
    ProductPartnerId varchar(50),
    ReceiptStatus varchar(50),
    totalSpent varchar(50),
    userId varchar(50),
    
    CONSTRAINT pk_receipt PRIMARY KEY(receipt_id)
);

# create a new table for user to perform data modeling
DROP TABLE IF EXISTS new_use;
CREATE TABLE new_user(
	user_id varchar(50),
    user_active varchar(50),
    user_createdDate varchar(50),
    user_lastLogin varchar(50),
    user_role varchar(50),
    user_signUpSource varchar(50),
    user_state varchar(50),
    
    CONSTRAINT pk_user PRIMARY KEY(user_id)
);
/*---------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*-------------------------------------------------------------------Script for cleaning brand table-------------------------------------------------------*/
# create a new table to save the cleaned brand table
DROP TABLE IF EXISTS cleaned_brands;
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
/*---------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*-------------------------------------------------------------------Script for cleaning receipt table-------------------------------------------------------*/
# create a new table to save the cleaned receipt table
DROP TABLE IF EXISTS cleaned_receipt;
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

/*---------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*-------------------------------------------------------------------Script for cleaning user table-------------------------------------------------------*/

# create a new table to save the cleaned user table
DROP TABLE IF EXISTS cleaned_user;
CREATE TABLE cleaned_user
SELECT *
FROM user;

# show the entir cleaned_user table
SELECT *
FROM cleaned_user;

# verify if there is any duplicate rows in cleaned_user table
SELECT id, COUNT(*)
FROM cleaned_user
GROUP BY id
HAVING COUNT(*)>1;

# create a new table to save deleted table without duplicated rows
CREATE TABLE cleaned_user2 LIKE cleaned_user;

# insert the distinct data into cleaned_user2
INSERT INTO cleaned_user2
SELECT *
FROM cleaned_user
GROUP BY id;

# drop cleaned_user table and rename cleaned_user2 to cleaned_user
DROP TABLE cleaned_user;
ALTER TABLE cleaned_user2 RENAME TO cleaned_user;

# data quality issue4-----Too many duplicated rows

/*---------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*-------------------------------------------------------------------Script for question-------------------------------------------------------------------*/
/*When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, 
which is greater? */

SELECT rewardsReceiptStatus, AVG(totalSpent)
FROM cleaned_receipt
WHERE rewardsReceiptStatus='finished' OR rewardsReceiptStatus='rejected'
GROUP BY rewardsReceiptStatus;
# 'accepted/finished' is greater
