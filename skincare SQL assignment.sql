-- CREATIVE SCENARIO
-- I have created a skincare brand called ‘NaiSkincare’. I want to optimize my product offerings and marketing strategies by gaining insight into which products are selling the most and in which countries. 
-- In addition, I want to understand my customer demographic and purchasing patterns so I can effectively tailor my marketing advertisement to the appropriate audience. 

-- Creating a database 
-- CREATE DATABASE skincare;

USE skincare;

-- Creating the table for products 
CREATE TABLE Products (
Product_ID VARCHAR (50) NOT NULL PRIMARY KEY,
Product_Name VARCHAR(50) NOT NULL,
Category VARCHAR(50),
Price FLOAT(2)
);

-- Creating the table for Sales
CREATE TABLE Sales(
Sales_ID INT NOT NULL PRIMARY KEY,
Product_ID VARCHAR (50) NOT NULL,
FOREIGN KEY(Product_ID) REFERENCES Products(Product_ID),
Customer_ID VARCHAR(50) NOT NULL,
FOREIGN KEY(Customer_ID) REFERENCES Customers(Customer_ID),
Quantity INT,
Sale_Date DATE,
Sale_Amount DECIMAL (5, 2)
);

-- Creating the table for Customers
CREATE TABLE Customers(
Customer_ID VARCHAR(50) NOT NULL PRIMARY KEY,
First_Name VARCHAR(50),
Last_Name VARCHAR (50),
Age INT,
Gender VARCHAR (20) NOT NULL,
Country VARCHAR(50)
);

-- Creating the table for Countries
CREATE TABLE Countries (
Country_ID VARCHAR(50) NOT NULL PRIMARY KEY,
Country_Name VARCHAR(50)
);

-- Inserting data into the products table
INSERT INTO Products (Product_ID, Product_Name, Category, Price) 
VALUES
('P1000','PapayaPure Foaming Cleanser','Cleanser' ,7.99),
('P1001','MangoMist Exfoliant Face Scrub','Exfoliant', 8.99),
('P1011','PomegranateBlossom Pink Clay Mask','Mask',12.99),
('P1021','BerryBreeze with Glycolic Acid Toner','Toner',10.99),
('P1031','GuavaGlow Water-based Serum','Serum',9.99),
('P1041','VanillaDream Hydrating Moisturizer','Moisturizer',11.99),
('P1051','CranberryCrush Brightening Eye cream ','Eye cream',6.99),
('P1061','PeachPerfect SPF 50+','SPF',7.99);

-- Inserting data into the customers table
INSERT INTO Customers (Customer_ID, First_Name, Last_Name, Age, Gender,Country)
VALUES
('CUST1001', 'Nala', 'Smith', 20,'Female', 'United States'),
('CUST2002', 'Shanice', 'Malani', 19, 'Female', 'Germany'),
('CUST3003', 'Anne','Peters',30, 'Female', 'United Kingdom'),
('CUST4004', 'James','Kabana',25,'Male','United Kingdom'),
('CUST5005', 'Kim','Li',21, 'Female','China'),
('CUST6006', 'Christina','Mendez',42,'Female','Brazil'),
('CUST7007', 'Joe','Taylor',22,'Male','Australia'),
('CUST8008', 'Sephora','Caboye',28,'Female','United States'),
('CUST9009', 'Mai','Saito',24,'Female','Japan'),
('CUST100010', 'Adrienne','Lupin',23,'Female','France');

-- Inserting data into the Countries table
INSERT INTO Countries (Country_ID , Country_Name)
VALUES
('101UK','United Kingdom'),
('201US','United States'),
('301FR','France'),
('401CN','China'),
('501GR','Germany'),
('601AUS','Australia'),
('701BR', 'Brazil'),
('801UEA','United Arab Emirates'),
('901JP', 'Japan'),
('1001IR','Ireland');

-- Inserting data into the Sales table
INSERT INTO Sales (Sales_ID, Product_ID, Customer_ID, Quantity, Sale_Date, Sale_Amount)
VALUES
(1230, 'P1000', 'CUST5005', 2, '2024-02-24', 15.98),
(2340, 'P1001', 'CUST8008', 4, '2024-03-12', 35.96),
(3460, 'P1031', 'CUST9009', 1, '2024-02-02', 9.99),
(4580, 'P1051', 'CUST2002', 5, '2024-01-13', 34.95),
(5670, 'P1021', 'CUST1001', 3, '2024-01-27', 32.97),
(6720, 'P1061', 'CUST6006', 6, '2024-03-28', 47.94),
(7810, 'P1041', 'CUST4004', 2, '2024-02-15', 23.98),
(8950, 'P1011', 'CUST3003', 4, '2024-01-03', 51.96),
(9020, 'P1041', 'CUST7007', 1, '2024-02-10', 11.99),
(10160,'P1031', 'CUST100010',5, '2024-03-06', 59.94);

-- QUERIES TO RETRIEVE DATA

-- QUERY 1 - this query is retrieving data by selecting product ID ,category and price data from the products table.
--  I have used ORDER BY so the data can be displayed with the Price column in descending order.
SELECT Products.Product_ID , Products.Category , Products.Price
FROM Products
ORDER BY Price DESC;

-- QUERY 2 - this query is retrieving data by selecting customers table to retrieve data about 'Adrienne'
SELECT Customers.Customer_ID ,Customers.First_Name, Customers.Last_Name, Customers.Age, Customers.Gender,Customers.Country 
FROM Customers
WHERE First_Name = 'Adrienne';

-- QUERY 3 - this query is retrieving data by selecting all Sales table fields to display data about any sales amount under £25.00.
SELECT Sales.Sales_ID, Sales.Product_ID, Sales.Customer_ID, Sales.Quantity, Sales.Sale_Date, Sales.Sale_Amount
FROM Sales
WHERE Sale_Amount <= 25.00;

-- QUERY 4 - this query is retriveving data by selecting all Countries table fields to display data about any countries that do not equal to 'Japan' 
SELECT Country_ID, Country_Name
FROM Countries
WHERE Country_Name != 'Japan' ;

-- QUERY 5 - this query is retrieving data by selecting all Customer table fields to display data about all customers over the age of 22 and who live in United Kingdom
SELECT Customers.Customer_ID ,Customers.Last_Name, Customers.Age, Customers.Gender,Customers.Country 
FROM Customers
WHERE Age > 22
AND Country = 'United Kingdom';

-- JOINS EXAMPLES

-- INNER JOIN DEMO 1
-- This query is selecting all the columns from Customers table and the Sales table, and it's combining the rows from these tables where the Customer_ID matches in both tables. 
-- I have used ORDER BY First_Name so the data can be displayed based off the First_Name column in ascending order.
SELECT *
FROM Customers
INNER JOIN Sales
ON Customers.Customer_ID = Sales.Customer_ID
ORDER BY First_Name;

-- LEFT JOIN DEMO 2
-- This query is selecting all columns from the Products table and any matching columns from the Sales table based on their Product_ID. In the event that there is  no corresponding sale for a product, the columns from the Sales table will return with NULL values in the result set.
SELECT *
FROM Products
LEFT JOIN Sales
ON Products.Product_ID = Sales.Product_ID;


-- AGGREGRATE FUNCTIONS DEMOS

-- COUNT FUCNCTION
-- This query is to count how many sales(transactions)took place between the below dates:
SELECT COUNT(Sale_Amount)
FROM Sales
WHERE Sale_Date BETWEEN '2024-01-03' AND '2024-02-02';

-- AVERAGE FUNCTION
-- This query is to calucate the average sale amount
SELECT AVG(Sale_Amount) AS AverageSales_Amount
FROM Sales;

-- ADDITONAL IN-BUILT FUNCTION DEMOS

-- UPPER FUNCTION and CONCAT (concatenation)FUNCTION
-- This query is to convert the customer IDs full names to uppercase , it will retrieve both first name and last name from the customers table.
-- It will only retrieve customers who are female. I have used an ALIAS to rename it.
-- I have used ORDER BY Uppercase_Customer_Name so the data can be displayed based off the First_Name column in descending order.
SELECT Customer_ID, UPPER(CONCAT(First_Name, ' ', Last_Name)) AS Uppercase_Customer_Name 
FROM Customers
WHERE Gender = 'Female'
ORDER BY Uppercase_Customer_Name DESC;

-- SUM FUNCTION
-- This query is to calculate the total sales amount for the brand by selecting the sale_amount column from Sales. I have used an ALIAS to rename it.
SELECT SUM(Sale_Amount) AS Total_Sales_Amount
FROM Sales;

-- SUM FUNCTION USING GROUP BY 
-- This query is to aggregate all rows by the Sale_Amount and Sale_Date column.
-- This is to find the sum of all of the amounts on each date.
SELECT SUM(Sale_Amount), Sale_Date
FROM Sales
GROUP BY Sale_Date;

-- QUERIES USING ORDER BY DEMOS
-- 1. This query is retrieving data by selecting all products from the Products table and ordering them by Price in descending order
SELECT * 
FROM Products 
ORDER BY Product_Name DESC;

-- 2. This query is retrieving data by selecting all products from the Countries Table and ordering them to display in descending order based off the Country_Name column. 
SELECT * 
FROM Countries 
ORDER BY Country_Name DESC;

-- STORED PROCEDURE DEMO
-- My example was to use the store procedure to find a product by the product ID everytime I put a product_ID in the parentheses. 

DELIMITER $$
CREATE PROCEDURE find_products(IN id VARCHAR(50))
BEGIN
SELECT *
FROM Products
WHERE Product_ID = id;
END $$
DELIMITER ;

CALL find_products('P1051');

-- DELETE QUERY DEMO
-- This is to delete a row from the countries table.
DELETE FROM Countries
WHERE Country_Name = 'Ireland';
SELECT * FROM Countries;

