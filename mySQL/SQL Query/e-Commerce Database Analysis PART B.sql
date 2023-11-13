-- ------------------- SECTION B Exploratory Data Analysis -----------------------------------

-- 1. Total number of products sold so far
SELECT count(ProductID) as "Total number of products"
from products;

-- 2. Total Revenue So far.
SELECT round(sum(price*Quantity),2) as "Total Revenue"
FROM order_details as od
inner join products as p on p. ProductID = od.ProductID;

-- 3. Total Unique Products sold based on category
select distinct count(ProductName) as "No of Products", CategoryName as Category
from categories as c
inner join products as p on p.CategoryID = c.CategoryID
inner join order_details as od on od.ProductID = p.ProductID
group by 2;


-- 4. Total Number of Purchase Transactions from customers
select count(OrderID) as "Total Number of Purchase"
from orders;

-- 5. Compare Orders made between 2021 – 2022
select Year(OrderDate), count(OrderID)
from Orders
group by(Year(OrderDate));

-- 6. What is total number of customers? Compare those that have made transaction and those that haven’t at all.
select count(C.CustomerID) as "No of Customers",
       case
         when o.CustomerID IS NULL THEN 'Yet to make an Order'
         else 'Made an Order'
       end as Transaction_Status
from Customers as c
left join orders as o on c.customerID = o.CustomerId
group by Transaction_Status;

-- 7. Who are the Top 5 customers with the highest purchase value
select CustomerName, round(sum(Price*Quantity),2) as "Total Revenue"
from customers as c
inner join orders as o on o.CustomerID = c.CustomerID
inner join order_details as od on od.OrderID = o.OrderID
inner join products as p on p.ProductID = od.ProductID
group by c.CustomerID
order by 2 desc
limit 5;

-- 8. Top 5 best-selling products
select p.productID, productName, sum(quantity) as "Qty Sold"
from Order_details as od
join products as p on od.productID = p.ProductID
group by 1
order by 2 desc
limit 5;

-- 9. What is the Transaction value per month
select concat(month(OrderDate), " - ", year(OrderDate)) as "Month-Year" ,count(o.OrderID) as "No of Orders", sum(price) as "Total Amount"
from Orders as o
inner join order_details as od on o.OrderID = od.OrderID
inner join products as p on p.ProductID = od.ProductID
group by YEAR(OrderDate), MONTH(OrderDate), 1
ORDER BY YEAR(OrderDate), MONTH(OrderDate);

-- 10. Best Selling Product Category?
select CategoryName, count(OrderID) as "Number of Orders", round(sum(Quantity*Price),2) as "Revenue"
from categories as c
inner join products as p on p.CategoryID = c. categoryID
inner join order_details as od on od.ProductID = p.ProductID
group by 1
order by 3 DESC
limit 1;

-- 11. Buyers who have Transacted more than two times
select CustomerID, count(OrderID)
from orders
group by 1
having count(OrderID) > 2;


-- 12. Most Successful Employee.
select count(OrderID) as "No of Orders", e.EmployeeID, concat(LastName, FirstName) as "Employee Name"
from employees as e
inner join orders as o on o.EmployeeID = e.EmployeeID
group by 2
order by 1 desc
limit 1;

-- 13. . Most used Shipper
Select s.ShipperId, ShipperName, count(OrderID) as "No of Orders"
from shippers as s
inner join orders as o on o.ShipperID = s.ShipperID
group by ShipperID 
order by count(OrderID) desc
limit 1;

-- 14. Most used Supplier.
Select s.supplierID, SupplierName, count(o.OrderID) as "No Of Orders"
from Suppliers as s
inner join Products as p on p.SupplierID = s.SupplierID
inner join order_details as od on od.ProductID = p.productID
inner join orders as o on o.OrderID = od.OrderID
group by s.supplierID
order by count(o.OrderID) desc
limit 1;



