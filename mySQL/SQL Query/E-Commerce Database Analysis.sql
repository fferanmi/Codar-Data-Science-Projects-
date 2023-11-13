

-- SECTION A
-- 1. Select customer name together with each order the customer made.
SELECT CustomerName, OrderID
from customers as c
inner join orders as o on c.CustomerID = o.CustomerID;

-- 2. Select order id together with name of employee who handled the order
SELECT orderID, concat(FirstName, LastName) as "Employee Name"
from orders as o
inner join employees as e on o.employeeID = e.EmployeeID;

-- 3. Select customers who did not placed any order yet.
select c.CustomerID, c.CustomerName
from customers as c
left join orders as o on c.CustomerID = o.CustomerID
where o.CustomerID is null;

-- 4. Select order id together with the name of product
SELECT OrderID, ProductName
from order_details as od
inner join products as p on od.ProductID = p.ProductID;

-- 5. Select products that no one bought
select *
from products
where ProductID not IN (select productid from order_details);

-- 6. Select customer together with the products that he bought.
select c.customerID, c.ContactName, p.productID, p.productName
from customers as c
inner join orders as o on c.CustomerID = o.CustomerID
inner join order_details as od on o.orderid = od.orderid
inner join products as p on od.productid = p.productid;

-- 7.  Select product names together with the name of corresponding category.
SELECT ProductID, ProductName, Category_Name
from products as P
inner join Categories as c on c.Category_ID = P.Category_ID;

-- 8. Select orders together with the name of the shipping company.
SELECT OrderID, o.ShipperID, ShipperName
from orders as o
inner join Shippers as s on s.ShipperID = o.ShipperID;

-- 9. Select customers with id greater than 50 together with each order they made.
select c.CustomerID, CustomerName, OrderID
from Customers as c
inner join Orders as o on c.CustomerID = o.CustomerID
where c.customerID > 50;

-- 10. Select employees together with orders with order id greater than 10400
SELECT e.EmployeeID, concat(FirstName, LastName) as "EmployeeName", OrderID
from employees as e
inner join orders as o on e.EmployeeID = o.EmployeeID
where OrderID > 10400;

-- 11. Select the most expensive product
select ProductID, ProductName, Units, price 
from products
where price = (select max(price) from products);

-- 12. Select the second most expensive product
select ProductID, ProductName, Units, price 
from products 
where price < (select max(price) from products)
order by price desc
limit 1;

-- 13. Select name and price of each product, sort the result by price in decreasing order
select ProductName, Price
from products
order by price desc;

-- 14. Select 5 most expensive products
select ProductID, ProductName, Units, price 
from Products
order by price desc
limit 5;

-- 15. Select 5 most expensive products without the most expensive (in final 4 products)
select ProductID, ProductName, Units, price 
from products
where price < (select max(price) from products)
order by price desc
limit 4; 

-- OR 
select ProductID, ProductName, Units, price 
from products
order by price desc
limit 1,4; 

-- 16. Select name of the cheapest product (only name) without using LIMIT and OFFSET
SELECT *
FROM products as p1
LEFT JOIN products as p2 ON p1.price > p2.price
WHERE p2.price IS NULL;

-- OR 
CREATE TEMPORARY TABLE temp_min_price AS
SELECT MIN(price) AS min_price
FROM products;

-- SELECT productName FROM products AS p GROUP BY ProductName ORDER BY MIN(price);

SELECT p.ProductName
FROM products as p
JOIN temp_min_price as tmp ON p.price = tmp.min_price;

-- 17. Select name of the cheapest product (only name) using subquery
Select ProductName
from products
where price = (select(min(price)) from products);

-- 18. Select number of employees with LastName that starts with 'D'
Select EmployeeID, trim(LastName) as "Last_Name"
from employees
where trim(LastName) like "D%";

-- 19. Select customer name together with the number of orders made by the corresponding 
-- customer, sort the result by number of orders in decreasing order.
select c.CustomerID, CustomerName, count(OrderID) as "number of orders"
from Customers as c
inner join orders as o on o.CustomerID = c.CustomerID
group by CustomerID
order by count(OrderID) desc;

-- 20. Add up the price of all products.
select sum(price) as "sum of products price"
from products;

-- 21. Select orderID together with the total price of that Order, order the result by total 
-- price of order in increasing order.
Select orderID, sum(price) as "Total Amount"
from order_details as od
inner join products as p on p.productID = od.ProductID
group by orderID
order by sum(price);

-- 22. Select customer who spend the most money
select count(c.CustomerID), CustomerName, sum(Price) as "total amount"
from customers as c
inner join orders as o on o.CustomerID = c.CustomerID
inner join order_details as od on od.OrderID= o.OrderID
inner join products as p on p.ProductID = od.ProductID
group by c.CustomerID
order by sum(price) desc
limit 1;

-- 23. Select customer who spend the most money and lives in Canada.
select count(c.CustomerID), CustomerName, sum(Price) as "total amount", trim(country) as "country"
from customers as c
inner join orders as o on o.CustomerID = c.CustomerID
inner join order_details as od on od.OrderID= o.OrderID
inner join products as p on p.ProductID = od.ProductID
where trim(country) = "Canada"
group by c.CustomerID
order by sum(price) desc
limit 1;

-- 24. Select customer who spend the second most money.
select count(c.CustomerID), CustomerName, sum(Price) as "total amount"
from customers as c
inner join orders as o on o.CustomerID = c.CustomerID
inner join order_details as od on od.OrderID= o.OrderID
inner join products as p on p.ProductID = od.ProductID
group by c.CustomerID
order by sum(price) desc
limit 1,1;

-- 25. Select shipper together with the total price of proceed orders.
select ShipperName, sum(Price)
from Shippers as s
inner join orders as o on o.ShipperID = s.ShipperID
inner join order_details as od on od.OrderID = o.OrderID
inner join products as p on p.ProductID = od.ProductID
group by ShipperName;


