FINAL PROJECT

Q1
SELECT ProductName,
SUM(DATEDIFF(DAY,OrderDate,ShippedDate)) AS Date_diff,
COUNT(O.OrderID) as Orders
FROM Orders O
LEFT JOIN [Order Details] OD ON O.OrderID=OD.OrderID
LEFT JOIN Products P ON OD.ProductID=P.ProductID
WHERE YEAR(OrderDate)=1997
GROUP BY ProductName
HAVING SUM(DATEDIFF(DAY,OrderDate,ShippedDate))>200
ORDER BY SUM(DATEDIFF(DAY,OrderDate,ShippedDate)) DESC

Q2
SELECT ShipCountry,SUM(UnitPrice*Quantity) AS gross_revanue,
SUM(Discount*UnitPrice*Quantity) as Discount,
SUM(unitPrice*Quantity)-SUM(Discount*UnitPrice*Quantity) as netRevanue,
COUNT( DISTINCT O.OrderID) AS Orders,
SUM(Quantity) as Quantity,
COUNT( DISTINCT ProductID) AS products 
FROM Orders O
LEFT JOIN [Order Details] OD
ON O.OrderID=OD.OrderID
GROUP BY ShipCountry
HAVING ShipCountry IN('Austria', 'Germany', 'USA','Brazil')

Q3
SELECT MONTH(OrderDate) AS MonthNum,
DATENAME(MONTH, OrderDate) AS MonthName,
SUM(UnitPrice*Quantity) AS gross_revanue,
COUNT( DISTINCT O.OrderID) AS Orders
FROM Orders O
LEFT JOIN [Order Details] OD
ON O.OrderID=OD.OrderID	
WHERE YEAR(OrderDate)=1997
GROUP BY MONTH(OrderDate),DATENAME(MONTH, OrderDate) 
ORDER BY MONTH(OrderDate)

Q4
SELECT S.CompanyName,
SUM(DATEDIFF(DAY,OrderDate,ShippedDate)) AS days_to_ship,
COUNT(O.OrderID) AS Orders
FROM ORDERS O
LEFT JOIN Shippers S  ON S.ShipperID=O.ShipVia
WHERE YEAR(OrderDate)=1997
GROUP BY S.CompanyName

Q5
SELECT TOP 12 ProductName,Products FROM (
SELECT ProductName,Products,
	DENSE_RANK() OVER(ORDER BY Products) AS rankasc,
	DENSE_RANK() OVER(ORDER BY Products DESC) AS rankdesc
FROM (
SELECT ProductName, COUNT(P.ProductID) AS Products
FROM [Order Details] OD
LEFT JOIN Products P ON OD.ProductID=P.ProductID
LEFT JOIN Orders O ON O.OrderID=OD.OrderID
WHERE YEAR(OrderDate)=1997
GROUP BY ProductName
) A 
)B
WHERE rankasc<=5 or rankdesc<=5

Q6
SELECT TOP 10 PERCENT C.CategoryName,ProductName,SUM(OD.UnitPrice*Quantity) AS gross_revanue,
SUM(OD.UnitPrice*Quantity)-SUM(OD.UnitPrice*Quantity*OD.Discount) AS netRevanue,
SUM(OD.Discount*OD.UnitPrice*Quantity) AS Discount,
COUNT(OD.ORDERID) AS Orders,
SUM(OD.Quantity) as Ouantity,
COUNT( OD.ProductID) AS products
FROM [Order Details] OD
INNER JOIN Products P ON OD.ProductID=P.ProductID
INNER JOIN Orders O ON OD.OrderID=O.OrderID
INNER JOIN Categories C ON C.CategoryID=P.CategoryID
WHERE YEAR(OrderDate)=1997
GROUP BY C.CategoryName,ProductName
ORDER BY COUNT(CategoryName) DESC

Q7
SELECT CategoryName, ProductName, 
SUM(UnitsInStock) AS UnitsInStock,
SUM(UnitsOnOrder) as UnitsOnOrder
FROM PRODUCTS P
INNER JOIN Categories C ON C.CategoryID=P.CategoryID
GROUP BY CategoryName, ProductName
HAVING SUM(UnitsInStock)<10


Q8
SELECT * FROM (
SELECT TOP 5 FirstName as EmployeeName,
'top 5' as Performance,
COUNT(DISTINCT O.OrderID) as Orders
FROM Employees E
INNER JOIN Orders O 
ON E.EmployeeID=O.EmployeeID
WHERE YEAR(OrderDate)=1997
GROUP BY FirstName
ORDER BY COUNT(DISTINCT O.OrderID) DESC) A
UNION all
SELECT * FROM (
SELECT TOP 5 FirstName as EmployeeName,
'bottom 5' as Performance,
COUNT(DISTINCT O.OrderID) as Orders
FROM Employees E
INNER JOIN Orders O 
ON E.EmployeeID=O.EmployeeID
WHERE YEAR(OrderDate)=1997
GROUP BY FirstName
ORDER BY COUNT(DISTINCT O.OrderID)) B


Q9
select title, firstname,
orders,Ouantity, gross_revanue,Discount,netRevanue,
sum(orders) over(partition by title) as order_total
from (
select title, firstname,
COUNT(DISTINCT OD.ORDERID) AS Orders,
SUM(OD.Quantity) as Ouantity,
SUM(OD.UnitPrice*Quantity) AS gross_revanue,
SUM(OD.Discount*OD.UnitPrice*Quantity) AS Discount,
SUM(OD.UnitPrice*Quantity)-SUM(OD.UnitPrice*Quantity*OD.Discount) AS netRevanue
from orders O
join [order details] OD On O.orderid=OD.orderid
join employees E ON O.employeeid=E.employeeid
WHERE YEAR(OrderDate)=1997
GROUP BY title,FirstName) a


Q10
SELECT A.RegionDescription,
COUNT(DISTINCT B.ORDERID) AS Orders,
SUM(B.UnitPrice*Quantity)AS Revanue,
SUM(B.UnitPrice*Quantity)/COUNT(DISTINCT B.ORDERID) AS revanue_per_order
FROM 
	(
	SELECT EmployeeID,RegionDescription, COUNT(*) AS cnt 
	FROM EmployeeTerritories E 
	LEFT JOIN Territories T ON T.TerritoryID=E.TerritoryID
	LEFT JOIN Region R ON T.REGIONID=R.REGIONID
	GROUP BY EmployeeID,RegionDescription
	)A
	LEFT JOIN(
	SELECT O.OrderID, EmployeeID, Quantity,UnitPrice,
	Discount, Quantity*UnitPrice as revanue
	FROM Orders O
	LEFT JOIN [Order Details] OD ON O.ORDERID= OD.ORDERID
	)B
ON A.EmployeeID=B.EmployeeID
GROUP BY A.RegionDescription
ORDER BY revanue_per_order

Q11
SELECT ORDERDATE,DATENAME(MONTH, OrderDate) AS Month,
CASE WHEN MONTH(ORDERDATE)>=1 AND MONTH(ORDERDATE)<	4 THEN '1'
	 WHEN MONTH(ORDERDATE)>=4 AND MONTH(ORDERDATE)<	7 THEN '2'
	WHEN MONTH(ORDERDATE)>=7 AND MONTH(ORDERDATE)<	10 THEN '3'
	ELSE '4'
	END AS Quarter,
CustomerID,
O.EmployeeID,Title,FirstName,
ShipCity AS City, ShipCountry AS Country,
ProductName, CategoryName,
SUM(OD.UnitPrice*Quantity) AS gross_revanue
FROM ORDERS O
INNER JOIN Employees E ON O.EmployeeID=E.EmployeeID
INNER JOIN [Order Details] OD ON OD.OrderID=O.OrderID
INNER JOIN PRODUCTS P ON P.ProductID=OD.ProductID
INNER JOIN Categories C ON C.CategoryID=P.CategoryID
GROUP BY ORDERDATE,DATENAME(MONTH, OrderDate),
CASE WHEN MONTH(ORDERDATE)>=1 AND MONTH(ORDERDATE)<	4 THEN '1'
	 WHEN MONTH(ORDERDATE)>=4 AND MONTH(ORDERDATE)<	7 THEN '2'
	WHEN MONTH(ORDERDATE)>=7 AND MONTH(ORDERDATE)<	10 THEN '3'
	ELSE '4'
	END,
CustomerID,
O.EmployeeID,Title,FirstName,
ShipCity, ShipCountry,
ProductName, CategoryName
ORDER BY ORDERDATE  

