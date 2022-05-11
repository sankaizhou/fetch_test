# create a new table for brand to perform data modeling
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
