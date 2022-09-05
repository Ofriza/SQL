
Q1
SELECT Discount,unitPrice,
SUM(unitPrice) OVER() as TOTAL_PRICE
FROM [Order Details]
ORDER BY unitPrice,Discount


Q2
SELECT OrderID, P.ProductName, Discount, O.UnitPrice,
SUM (O.UnitPrice) OVER(PARTITION BY P.ProductName ORDER BY OrderID) AS sumRuning,
SUM (O.UnitPrice) OVER(PARTITION BY P.ProductName) AS totalUnitPrice
FROM [Order Details] O
JOIN Products P
ON P.ProductID=O.ProductID
ORDER BY P.ProductName, OrderID

Q3
SELECT Discount, UnitPrice,
SUM (UnitPrice) OVER(PARTITION BY Discount ORDER BY UnitPrice) AS sumRuning
FROM [Order Details]
ORDER BY Discount, UnitPrice

Q4
SELECT Discount, UnitPrice,
SUM (UnitPrice) OVER(PARTITION BY UnitPrice) AS totalSum
FROM [Order Details]

Q5
SELECT Discount, UnitPrice,
SUM (UnitPrice) OVER(PARTITION BY  Discount, UnitPrice) AS sumRunningTotal
FROM [Order Details]

Q6
SELECT Discount, UnitPrice,
SUM (UnitPrice) OVER(ORDER BY  Discount,UnitPrice) AS sumRunningTotal,
SUM (UnitPrice) OVER(PARTITION BY  Discount) AS sumTotal
FROM [Order Details]

Q7
SELECT Discount, UnitPrice,
RANK() OVER(PARTITION BY Discount ORDER BY  UnitPrice) AS RANK,
DENSE_RANK() OVER(PARTITION BY Discount ORDER BY  UnitPrice) AS DENSE,
ROW_NUMBER() OVER(PARTITION BY Discount ORDER BY  UnitPrice) AS ROW
FROM [Order Details]

select discount, UnitPrice,
RANK() OVER(PARTITION BY Discount ORDER BY UnitPrice) AS RANK,
DENSE_RANK() OVER(PARTITION BY Discount ORDER BY UnitPrice) AS DENSE,
ROW_NUMBER() OVER(PARTITION BY Discount ORDER BY  UnitPrice) AS ROW
from [Order Details]


Q8
SELECT Discount, UnitPrice,
NTILE(2) OVER(PARTITION BY Discount ORDER BY  UnitPrice) AS ntile2,
NTILE(4) OVER(PARTITION BY Discount ORDER BY  UnitPrice) AS ntile4,
NTILE(10) OVER(PARTITION BY Discount ORDER BY  UnitPrice) AS ntile10
FROM [Order Details]

Q9
SELECT Discount,ntile4,COUNT(*) AS Orders,
	   MIN(UnitPrice) AS min_UnitPrice,
	   AVG(UnitPrice) AS sum_UnitPrice,
	   MAX(UnitPrice) AS max_UnitPrice
	   FROM (SELECT UnitPrice, DISCOUNT,
			NTILE(4) OVER(PARTITION BY DISCOUNT ORDER BY UnitPrice) AS ntile4
	  FROM [Order Details]
	  ) as a
GROUP BY Discount,ntile4

Q10
SELECT productID,
		CASE WHEN Precentages=1 THEN 'A. 0%-25%'
			 WHEN Precentages=2 THEN 'B. 25%-50%'
			 WHEN Precentages=3 THEN 'C. 50%-75%'
			 WHEN Precentages=4 THEN 'D. 75%-100%'
		END AS Precentages,
	   MIN(UNITPRICE*QUANTITY) AS min_Revanue,
	   MAX(UNITPRICE*QUANTITY) AS max_Revanue,
	   AVG(UNITPRICE*QUANTITY) AS avg_Revanue,
	   COUNT(*) AS cnt
FROM (SELECT productID,UNITPRICE, QUANTITY,
			NTILE(4) OVER(PARTITION BY productID ORDER BY UNITPRICE) AS Precentages
	  FROM [Order Details]
	  ) as a
WHERE productID=3
GROUP BY productID,Precentages
ORDER BY productID,CASE WHEN Precentages=1 THEN 'A. 0%-25%'
			 WHEN Precentages=2 THEN 'B. 25%-50%'
			 WHEN Precentages=3 THEN 'C. 50%-75%'
			 WHEN Precentages=4 THEN 'D. 75%-100%'
			 END
			

Q11
SELECT SupplierID,UnitPrice,
ISNULL(LEAD(UnitPrice) OVER(PARTITION BY SupplierID ORDER BY  UnitPrice),0) AS LEAD,
ISNULL(LAG(UnitPrice) OVER(PARTITION BY SupplierID ORDER BY  UnitPrice),0) AS LAG
FROM Products
SELECT *
FROM [Order Details]

Q12
SELECT SupplierID,UnitPrice,
MIN(UnitPrice) OVER(PARTITION BY SupplierID) AS first_UnitPrice,
MAX(UnitPrice) OVER(PARTITION BY SupplierID) AS last_UnitPrice
FROM Products
GROUP BY SupplierID,UnitPrice
ORDER BY SupplierID

Q13
SELECT employeeId,orderId, orderDate,
COUNT(orderId) OVER(PARTITION BY employeeId) AS RunningTotal
FROM Orders

Q14
SELECT ProductName,
COUNT(DISTINCT OrderId) AS Orders,
MAX(O.UnitPrice) AS median_UnitPrice
FROM [Order Details] O
JOIN Products P
ON P.ProductID=O.ProductID
GROUP BY ProductName


