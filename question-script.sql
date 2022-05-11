/*When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, 
which is greater? */

SELECT rewardsReceiptStatus, AVG(totalSpent)
FROM cleaned_receipt
WHERE rewardsReceiptStatus='finished' OR rewardsReceiptStatus='rejected'
GROUP BY rewardsReceiptStatus;
# 'accepted/finished' is greater