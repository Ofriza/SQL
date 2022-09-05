MID-PROJECT

Q1
SELECT SUM(UnitPrice*Quantity) AS gross_revanue,
	   SUM(Discount*UnitPrice*Quantity) AS Discount,
	   SUM((UnitPrice*Quantity)- (Discount*unitPrice*Quantity)) as net_revanue,
       COUNT( DISTINCT OrderID) AS Orders, 
	   SUM(Quantity) as Quantity,
	   COUNT( DISTINCT ProductID) AS products 
FROM [Order Details]

Q2
SELECT MONTH(OrderDate) AS Month_Num,
DATENAME(MONTH, OrderDate) AS Month_Name,
COUNT(OrderID) AS Orders,
SUM(Freight) AS Total_Freights
FROM Orders
GROUP BY DATENAME(MONTH, OrderDate),MONTH(OrderDate)
ORDER BY  MONTH(OrderDate) 

Q3
SELECT DISTINCT ShipVia,
SUM(DATEDIFF(DAY,OrderDate , ShippedDate)) AS DateDiff,
COUNT(ORDERID) AS Orders
FROM Orders
GROUP BY ShipVia
ORDER BY ShipVia

Q4
SELECT DISTINCT shipCountry, SUM(Freight) AS Freight
FROM Orders
WHERE shipCountry IN ('Brazil','France','USA')
GROUP BY shipCountry
ORDER BY shipCountry DESC

Q5
SELECT TOP 10 PERCENT ProductID, 
COUNT(DISTINCT OrderID) AS orders
FROM [Order Details]
GROUP BY ProductID
ORDER BY COUNT(DISTINCT OrderID) DESC

Q6
SELECT DISTINCT CategoryID, 
SUM(UnitsInStock) AS units_in_stock,
SUM(UnitsOnOrder) AS units_on_order
FROM Products
GROUP BY CategoryID
Order by units_in_stock

Q7
SELECT ProductID,
	COUNT(DISTINCT OrderId) as Orders,
	SUM(Quantity) AS Quantity,
	SUM(UnitPrice*Quantity) AS Gross_revanue,
Discount,
	SUM((UnitPrice*Quantity)-(UnitPrice*Discount)) AS Net_revanue
FROM [Order Details]
WHERE Discount=0
GROUP BY ProductID,Discount
HAVING COUNT(DISTINCT OrderId)<8

Q8
SELECT SupplierID,COUNT(ProductId) as Products
FROM Products
WHERE UnitPrice>30 
GROUP BY SupplierID
Order by COUNT(ProductId)

Q9
SELECT EmployeeID, 
	COUNT(OrderId) as Orders,
	SUM(DATEDIFF(DAY,OrderDate , ShippedDate)) AS Date_diff,
	SUM(DATEDIFF(DAY,OrderDate , ShippedDate))/COUNT(OrderId) AS daysToShipPerOrder
FROM Orders
WHERE YEAR(OrderDate)='1997'
GROUP BY EmployeeID

Q10
SELECT Title, COUNT(EmployeeId) as Employees
FROM Employees
GROUP BY Title
ORDER BY COUNT(EmployeeId) DESC

Q11
SELECT country,city, COUNT(EmployeeId) as Employees
FROM Employees
GROUP BY  city,country
ORDER BY COUNT(EmployeeId) DESC

Q12
SELECT EmployeeID, COUNT(TerritoryID) AS FF
FROM EmployeeTerritories
GROUP BY EmployeeID
