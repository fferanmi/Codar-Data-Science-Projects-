
-- Project Title: E-Commerce Database Design and Analysis for a Grocery Store

-- Creating a DB

CREATE SCHEMA eCommerce;

-- Now, creating tables.

CREATE TABLE customers(
CustomerID int(11) primary key auto_increment,
CustomerName varchar(255) not null,
ContactName	varchar(255) not null,
Address varchar(255) not null,
City varchar(255) not null,
PostalCode varchar(255) not null,
Country varchar(255) not null);
-- THE DATASET WAS IMPORTED

select *
from customers;

CREATE TABLE employees(
EmployeeID	int(11) primary key auto_increment,
LastName varchar(255) not null,
FirstName varchar(255) not null,
BirthDate Date, 
Photo varchar(255) not null,
Notes text);
-- DATASET WAS IMPORTED


CREATE TABLE categories(
Category_ID	int(11) primary key auto_increment,
Category_Name varchar(255) not null,
Description text);
-- DATASET WAS IMPORTED


CREATE TABLE Orders(
OrderID int(11) primary key auto_increment,
CustomerID	int(11),
EmployeeID	int(11),
OrderDate Date,
ShipperID int(11),

constraint foreign key (CustomerID) references customers (CustomerID),
constraint foreign key (EmployeeID) references employees (EmployeeID),
constraint foreign key (ShipperID) references shippers (ShipperID)
);
-- DATASET WAS IMPORTED

CREATE TABLE Order_details(
OrderDetailsID int(11) primary key auto_increment,
OrderID	int(11),
ProductID int(11),
Quantity int(11),

constraint foreign key (OrderID) references Orders (OrderID),
constraint foreign key (ProductID) references Products (ProductID)
);
-- DATASET WAS IMPORTED

CREATE TABLE Products(
ProductID int(11) primary key auto_increment,
ProductName	varchar(255),
SupplierID	int(11),
Category_ID int(11),
Unit varchar (255),
Price double,

constraint foreign key (SupplierID) references Suppliers (SupplierID),
constraint foreign key (Category_ID) references Categories (Category_ID)
);
-- DATASET WAS IMPORTED

CREATE TABLE Shippers(
ShipperID int(11) primary key auto_increment,
ShipperName	varchar(255),
Phone varchar(255)
);
-- DATASET WAS IMPORTED

CREATE TABLE Suppliers(
SupplierID int(11) primary key auto_increment,
SupplierName varchar(255),
ContactName	varchar(255),
Address	varchar(255),
City varchar(255),
PostalCode varchar(255),
Country	varchar(255),
Phone varchar(255)
);
-- DATASET WAS IMPORTED




 