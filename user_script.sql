# create a new table to save the cleaned user table
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