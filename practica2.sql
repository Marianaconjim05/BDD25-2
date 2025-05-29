--copia de la tabla con datos generales de los productos de cada orden 

select * into order_header 
from AdventureWorks.sales.SalesOrderHeader 

-- copia de la tabla con datos de los productos de cada orden 
-- que producto esta asociado a cada orden 

select * into order_detail
from AdventureWorks.sales.SalesOrderDetail 

--copia de la tabla de datos con los datos de los clientes que se relacionan con las oridenes 

select * into customer 
from AdventureWorks.sales.Customer 

--copia de la tabla sales territory

select * into SalesTerritory
from AdventureWorks.sales.SalesTerritory
  
-- copia de la tabla productos 

select * into products 
from AdventureWorks.Production.Product 

--copia tabla products category

select * into ProductCategory 
from AdventureWorks.Production.ProductCategory

--copia tabla products subcategory

select * into ProductSubCategory 
from AdventureWorks.Production.ProductSubCategory

--copia tabla products person, lo hacemos de este modo ya que existen datos XML

CREATE TABLE person (
    BusinessEntityID int NOT NULL,
    PersonType nchar(2) NOT NULL,
    NameStyle bit NOT NULL,
    Title nvarchar(8),
    FirstName nvarchar(50) NOT NULL,
    MiddleName nvarchar(50),
    LastName nvarchar(50) NOT NULL,
    Suffix nvarchar(10),
    EmailPromotion int NOT NULL,
    AdditionalContactInfo xml,
    Demographics xml,
    rowguid uniqueidentifier NOT NULL,
    ModifiedDate datetime NOT NULL
);


INSERT INTO person
SELECT * FROM AdventureWorks.Person.Person;

----------------------- Punto 3: Incisos a), b) & c)----------------------------------------------
-- a) Listar el producto más vendido de cada una de las categorías registradas en la base 
de datos. 
SELECT 
    pc.Name AS Categoria,
    p.Name AS Producto,
    suma.TotalVendido
FROM (
    SELECT 
        sod.ProductID,
        SUM(sod.OrderQty) AS TotalVendido
    FROM SalesOrderDetail sod
    GROUP BY sod.ProductID
) AS suma
JOIN Product p ON p.ProductID = suma.ProductID
JOIN ProductSubcategory ps ON ps.ProductSubcategoryID = p.ProductSubcategoryID
JOIN ProductCategory pc ON pc.ProductCategoryID = ps.ProductCategoryID
WHERE NOT EXISTS (
    SELECT 1
    FROM (
        SELECT 
            sod.ProductID,
            SUM(sod.OrderQty) AS TotalVendido
        FROM SalesOrderDetail sod
        GROUP BY sod.ProductID
    ) AS otros
    JOIN Product po ON po.ProductID = otros.ProductID
    JOIN ProductSubcategory pso ON pso.ProductSubcategoryID = po.ProductSubcategoryID
    JOIN ProductCategory pco ON pco.ProductCategoryID = pso.ProductCategoryID
    WHERE 
        pco.ProductCategoryID = pc.ProductCategoryID AND
        otros.TotalVendido > suma.TotalVendido
);

-- b) Listar el nombre de los clientes con más ordenes por cada uno de los territorios 
registrados en la base de datos. 
SELECT 
    st.Name AS Territorio,
    per.FirstName + ' ' + per.LastName AS Cliente,
    cu.CustomerID,
    conteo.Ordenes
FROM (
    SELECT 
        soh.CustomerID,
        cu.TerritoryID,
        COUNT(*) AS Ordenes
    FROM SalesOrderHeader soh
    JOIN Customer cu ON cu.CustomerID = soh.CustomerID
    GROUP BY soh.CustomerID, cu.TerritoryID
) AS conteo
JOIN Customer cu ON cu.CustomerID = conteo.CustomerID
JOIN Person per ON per.BusinessEntityID = cu.PersonID
JOIN SalesTerritory st ON st.TerritoryID = cu.TerritoryID
WHERE NOT EXISTS (
    SELECT 1
    FROM (
        SELECT 
            soh.CustomerID,
            cu.TerritoryID,
            COUNT(*) AS Ordenes
        FROM SalesOrderHeader soh
        JOIN Customer cu ON cu.CustomerID = soh.CustomerID
        GROUP BY soh.CustomerID, cu.TerritoryID
    ) AS otros
    WHERE 
        otros.TerritoryID = conteo.TerritoryID AND
        otros.Ordenes > conteo.Ordenes
);

-- c) Listar los datos generales de las ordenes que tengan al menos los mismos productos 
de la orden con salesorderid =  43676. 
select productid
from AdventureWorks2019.sales.SalesOrderDetail
where salesorderid = 43676
 
-- tabla R de la formula
select salesorderid, SalesOrderDetailID, productid, OrderQty
from AdventureWorks2019.sales.SalesOrderDetail
 
-- T1
go
create view T1 as 
select salesorderid, SalesOrderDetailID, OrderQty
from AdventureWorks2019.sales.SalesOrderDetail
 
-- T2
go
create view T1XS as
select *
from T1 cross join (select productid
                    from AdventureWorks2019.sales.SalesOrderDetail
                    where salesorderid = 43676) as S
 
go
create view T2 as 
select salesorderid, SalesOrderDetailID, OrderQty
from (select *
	  from T1XS
	  except
	  select salesorderid, SalesOrderDetailID, OrderQty, productid
	  from AdventureWorks2019.sales.SalesOrderDetail) resta
 
-- T1 - T2
select *
from T1
except
select *
from T2
 
select salesorderid, count(*)
from AdventureWorks2019.sales.SalesOrderDetail
where ProductID in (
	select productid
	from AdventureWorks2019.Sales.SalesOrderDetail
	where SalesOrderID = 43676)
group by salesorderid
having count(*) = 5
 
select salesorderid,productid
from AdventureWorks2019.Sales.SalesOrderDetail
where SalesOrderID in (43676, 46052, 43891)
order by SalesOrderID, ProductID


----------------------- Punto 5: Incisos a), b) & c)----------------------------------------------
-- a) Listar el producto más vendido de cada una de las categorías registradas en la base 
de datos. 

-- b) Listar el nombre de los clientes con más ordenes por cada uno de los territorios 
registrados en la base de datos. 

-- c) Listar los datos generales de las ordenes que tengan al menos los mismos productos 
de la orden con salesorderid =  43676.


	

----------------------- EJERCICIOS DADOS EN CLASE -----------------------------------------------------

-- Listar los datos generales de las ordenes 
-- que tengan al menos los mismos productos de la 
-- orden con salesorderid =  43676.
 
-- Formula división
-- T1 <- Proyección(A)(R)
-- T2 <- Proyección(A)((T1 X S) - R)
-- T1 - T2
 
-- lista productos de la orden 43676
-- tabla S de la formula de la división
select productid
from AdventureWorks.sales.SalesOrderDetail
where salesorderid = 43676
 
-- tabla R de la formula
select salesorderid, SalesOrderDetailID, productid, OrderQty
from AdventureWorks.sales.SalesOrderDetail
 
-- T1
go
create view T1 as 
select salesorderid, SalesOrderDetailID, OrderQty
from AdventureWorks.sales.SalesOrderDetail
 
-- T2
go
create view T1XS as
select *
from T1 cross join (select productid
                    from AdventureWorks.sales.SalesOrderDetail
                    where salesorderid = 43676) as S
 
go
create view T2 as 
select salesorderid, SalesOrderDetailID, OrderQty
from (select *
	  from T1XS
	  except
	  select salesorderid, SalesOrderDetailID, OrderQty, productid
	  from AdventureWorks.sales.SalesOrderDetail) resta
 
-- T1 - T2
select *
from T1
except
select *
from T2
 
select salesorderid, count(*)
from AdventureWorks.sales.SalesOrderDetail
where ProductID in (
	select productid
	from AdventureWorks.Sales.SalesOrderDetail
	where SalesOrderID = 43676)
group by salesorderid
having count(*) = 5
 
select salesorderid,productid
from AdventureWorks.Sales.SalesOrderDetail
where SalesOrderID in (43676, 46052, 43891)
order by SalesOrderID, ProductID
