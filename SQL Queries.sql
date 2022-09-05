
Q1
select ProductName, CategoryName
from Products p
join Categories c
on p.CategoryID=c.CategoryID

Q2
select ProductName, CompanyName
from Products p
join Suppliers s
on p.SupplierID=s.SupplierID

Q3
select CompanyName,o.OrderID
from Orders o
join Customers c
on o.CustomerID=c.CustomerID
where CompanyName like 'm%'

Q4
select RegionDescription, TerritoryDescription
from Region r
join Territories t
on r.RegionID=t.RegionID

Q5
select ProductName, CategoryName
from Products p
join Categories c
on p.CategoryID=c.CategoryID
where p.UnitPrice>30

Q6
select ProductName, CompanyName
from Products p
join Suppliers s
on p.SupplierID=s.SupplierID
where p.SupplierID=5

Q7
select ProductName, CategoryName, s.CompanyName
from Products p
join Categories c on p.CategoryID=c.CategoryID
join Suppliers s on p.SupplierID=s.SupplierID

Q8
select CompanyName, OrderID
from Customers c
left join Orders o
on c.CustomerID=o.CustomerID

Q9
select ProductName, CompanyName
from Products p
join Suppliers s
on p.SupplierID=s.SupplierID
where s.Country like 'a%'

Q10
select ProductName, Description, city
from Products p
join Categories c on p.CategoryID=c.CategoryID
join Suppliers s on p.SupplierID=s.SupplierID
where s.city in('Tokyo','London')

Q11
select OrderID,OrderDate,ShipAddress, c.CustomerID, ContactName, Phone
from Orders o
join Customers c
on o.CustomerID=c.CustomerID
where OrderDate>='1997-01-01' and (c.CustomerID like 'B%' or c.CustomerID like 'D%')

Q12
select OrderID,OrderDate,ShipAddress, c.CustomerID, ContactName, Phone,FirstName,LastName
from Orders o
join Customers c on o.CustomerID=c.CustomerID
join Employees e on o.EmployeeID=e.EmployeeID
where OrderDate>='1997-01-01' and (c.CustomerID like 'B%' or c.CustomerID like 'D%') and
firstname in('Janet','Margaret')
order by OrderDate desc

Q13
select e.EmployeeID, e.firstname,m.employeeid, m.firstname
from Employees e
join employees m
on e.reportsto=m.EmployeeID

Q14
select c.CustomerID,CompanyName, avg(freight) as AvgFreight
from Customers c
join orders o on c.CustomerID=o.CustomerID
group by c.CustomerID,CompanyName

Q15
select c.CustomerID, ContactName, CompanyName,ContactTitle,City,Country, sum(Freight) as sumFreight
from customers c
join orders o on c.CustomerID=o.CustomerID
group by c.CustomerID, ContactName, CompanyName,ContactTitle,City,Country
order by sum(Freight) desc

Q16
SELECT o.OrderID, count(productId) as products
FROM orders o
JOIN [Order Details] od 
ON o.OrderID=od.OrderID
group by o.OrderID
order by count(productId) desc

Q17
SELECT ProductName, UnitPrice, CategoryName, CompanyName
FROM Products P
JOIN Categories C ON P.CategoryID=C.CategoryID
JOIN Suppliers S ON P.SupplierID=S.SupplierID
WHERE S.SupplierID IN (1,4,8)

Q18
SELECT C.City, 'C' as category
FROM Customers C
UNION 
SELECT S.City, 'S' as category
FROM Suppliers S
ORDER BY City 


Q19
SELECT City, 'C' as category
FROM Customers
WHERE Country='Germany'
UNION 
SELECT City, 'S' as category
FROM Suppliers
WHERE Country='USA'
ORDER BY City 

Q20
SELECT ProductName, CompanyName
FROM Products P
JOIN Suppliers S
ON P.SupplierID=S.SupplierID

Q21
SELECT OrderID, CONCAT(FirstName, LastName) AS seller, E.Title, OrderDate
FROM Employees E
JOIN Orders O
ON E.EmployeeID=O.EmployeeID

Q22
SELECT CompanyName AS Customer,City, COUNT(OrderID) AS Orders
FROM Customers C
JOIN Orders O
ON C.CustomerID=O.CustomerID
group by CompanyName ,City
order by  COUNT(OrderID) desc

Q23
SELECT CompanyName, ContactName,Country
FROM Customers C
LEFT JOIN Orders O
ON C.CustomerID= O.CustomerID
group by CompanyName ,ContactName,Country
HAVING COUNT(ORDERID)=0

Q24
SELECT CASE WHEN  O.OrderID IS NULL THEN 'non-payers'
ELSE 'payers' END AS PayersTable,
COUNT(distinct C.CustomerID) AS customers
from Customers C
LEFT JOIN Orders O ON C.CustomerID= O.CustomerID
GROUP BY CASE WHEN  O.OrderID IS NULL THEN 'non-payers'
ELSE 'payers' END

Q25
SELECT TOP 20 PERCENT CategoryName, ProductName, CompanyName, UnitPrice
FROM Products P
JOIN Suppliers S ON P.SupplierID=S.SupplierID
JOIN Categories C ON P.CategoryID=C.CategoryID
ORDER BY UnitPrice

Q26
SELECT CompanyName AS shipName, COUNT(ORDERID) AS Orders
FROM Shippers S
JOIN ORDERS O ON S.ShipperID=O.ShipVia
WHERE ShipCountry IN ('Spain','France')
GROUP BY CompanyName

Q27
SELECT category, Country,COUNT(City) AS cities_amount
FROM(
SELECT City,Country, 'Customers' as Category
FROM Customers
WHERE Country='Germany'
UNION
SELECT City,Country,'Suppliers' as Category
FROM Suppliers
WHERE Country='USA'
) AS NEWTABLE
GROUP BY category, Country 