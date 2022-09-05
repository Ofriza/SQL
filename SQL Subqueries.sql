
Q1
select ProductName
from Products
where unitprice < (select UnitPrice
				   from Products
				   where ProductID=3)

Q2
select ProductName, UnitPrice
from Products
where unitprice>(select UnitPrice
				 from Products
				 where ProductName='Carnarvon Tigers')

Q3
select FirstName,LastName, HireDate
from Employees
where HireDate >(select HireDate
                 from Employees
                 where EmployeeID=4) 

Q4
select ProductID, ProductName,UnitPrice
from Products
where UnitPrice > (select avg(unitprice)
				from Products
				where CategoryID=6)

Q5
select EmployeeID, FirstName, Title,HomePhone
from Employees
where BirthDate < (select BirthDate
                 from Employees
                 where LastName='Fuller')

Q6
select ProductName,UnitsInStock
from Products
where UnitsInStock<(select min(UnitsInStock)
                    from Products
                    where CategoryID=3)

Q7
select ProductID,ProductName,UnitPrice
from Products
where CategoryID=(select CategoryID
                    from Products
                    where ProductName='Chai')

Q8
select ProductName,UnitPrice, CategoryID
from Products
where UnitPrice=some (select UnitPrice
                    from Products
                    where CategoryID=5)

Q9
select OrderID,OrderDate
from Orders
where customerid in (select customerid
					from customers
					where Country in ('France','Germany','Sweden'))
and OrderDate <'1996-09-01'

Q10
select ProductName,ProductID, UnitsInStock
from Products
where UnitPrice> (select max(UnitPrice)
                    from Products
                    where UnitsInStock=20)

Q11
select ProductName,CategoryID, UnitPrice
from Products
where UnitPrice> (select avg(UnitPrice)
                    from Products
                    where CategoryID=2 and UnitPrice>40)

Q12
select CategoryID, avg(UnitPrice) as avg_unitprice
from Products
group by CategoryID
having avg(UnitPrice) > (select avg(UnitPrice)
                    from Products
                    where CategoryID=3)

Q13
select ProductName,UnitPrice
from Products
where UnitPrice > (select UnitPrice
                    from Products
                    where ProductID=5)
					and CategoryID=(select CategoryID
                                    from Products
                                    where ProductName='Chai')
					and ProductName not in('Konbu')

Q14
select orderid, avg(UnitPrice) as avg_unitPrice
from [Order Details] 
where OrderID in (select OrderID
				from orders
				where ShipCity='Madrid')
group by orderid
having avg(UnitPrice)<30

Q15
select e.EmployeeID, FirstName, avg(freight) as avg_freight
from Employees e
join orders o
on e.EmployeeID=o.EmployeeID
where e.EmployeeID not in(select ReportsTo
                            from Employees
							where ReportsTo is not null)
group by e.EmployeeID, FirstName
having AVG(freight)>60
order by e.EmployeeID

Q16
SELECT O.OrderID,OrderDate, UnitPrice
FROM [Order Details] OD
JOIN Orders O
ON O.OrderID=OD.OrderID
WHERE O.OrderID IN ( SELECT OrderID
				FROM Orders
				WHERE OrderDate >='1998-05-01')

 
SELECT O.OrderID,OrderDate, OD.max_unit
FROM (
SELECT OrderID,MAX(unitPrice) as max_unit
FROM [Order Details] 
GROUP BY OrderID) AS OD
JOIN Orders O
ON O.OrderID=OD.OrderID
WHERE O.OrderDate >='1998-05-01'


Q17
SELECT CONCAT(FirstName,' ',LastName) AS 'Employee_Name',HireDate
FROM Employees
WHERE HireDate>(SELECT HireDate
				FROM Employees
				WHERE EmployeeID=4)

Q18
SELECT ProductName,CategoryID,UnitPrice
FROM Products
WHERE CategoryID=(SELECT CategoryID
				  FROM Products
				  WHERE ProductName='IKURA')

Q19
SELECT ShipCountry, Freight
FROM Orders
WHERE Freight>=(SELECT MAX(Freight)
					FROM Orders
					WHERE ShipVia=3)

Q20
SELECT ProductName,CategoryID,UnitPrice
FROM Products
WHERE UnitsInStock<(SELECT MIN(UnitPrice)
                    FROM Products
                    WHERE CategoryID=8)

Q21
SELECT ProductID, MAX(Quantity) AS MAX_QUANTITY
FROM [Order Details]
GROUP BY ProductID
HAVING MAX(Quantity)>(SELECT MAX(Quantity)
                    FROM [Order Details]
                    WHERE ProductID=59)

Q22
SELECT SupplierID, MIN(UNITPRICE) AS Min_Unit_Price
FROM Products
GROUP BY SupplierID
HAVING MIN(UNITPRICE) <(SELECT MIN(UnitPrice)
					    FROM Products
					    WHERE SupplierID=10)

Q23
SELECT SupplierID, ContactName
FROM Suppliers
WHERE SupplierID IN (SELECT SupplierID
					 FROM Products
					 WHERE Discontinued=1)

Q24
SELECT C.CustomerID,CompanyName
FROM Customers C
WHERE CustomerID IN (SELECT CustomerID
	                 FROM Orders
					 WHERE ShipCity='Madrid')

Q25
SELECT O.EmployeeID, FirstName, AVG(Freight) AS AVG_FREIGHT
FROM Orders O
JOIN Employees E
ON O.EmployeeID=E.EmployeeID
GROUP BY O.EmployeeID, FirstName
ORDER BY EmployeeID





