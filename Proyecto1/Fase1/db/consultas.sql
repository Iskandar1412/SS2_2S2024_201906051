SELECT COUNT(*) AS Total_Compras FROM FactCompras;
SELECT COUNT(*) AS Total_Ventas FROM FactVentas;

DELETE FROM Compras;
DELETE FROM Ventas;
DELETE FROM Sucursal;
DELETE FROM Producto;
DELETE FROM Region;
DELETE FROM Departamento;
DELETE FROM Marca;
DELETE FROM Categoria;
DELETE FROM Fecha;
DELETE FROM Proveedor;
DELETE FROM Cliente;
DELETE FROM Vendedor;
DBCC CHECKIDENT('Sucursal', RESEED, 0);
DBCC CHECKIDENT('Producto', RESEED, 0);
DBCC CHECKIDENT('Region', RESEED, 0);
DBCC CHECKIDENT('Departamento', RESEED, 0);
DBCC CHECKIDENT('Marca', RESEED, 0);
DBCC CHECKIDENT('Categoria', RESEED, 0);
DBCC CHECKIDENT('Fecha', RESEED, 0);
DBCC CHECKIDENT('Proveedor', RESEED, 0);
DBCC CHECKIDENT('Cliente', RESEED, 0);
DBCC CHECKIDENT('Vendedor', RESEED, 0);

SELECT ?= COUNT(*) FROM dbo.Proveedor
SELECT ?= COUNT(*) FROM dbo.Cliente
SELECT ?= COUNT(*) FROM dbo.Vendedor
SELECT ?= COUNT(*) FROM dbo.Producto
SELECT ?= COUNT(*) FROM dbo.Sucursal
SELECT ?= COUNT(*) FROM dbo.Compras
SELECT ?= COUNT(*) FROM dbo.Ventas

SELECT 
    (SELECT COUNT(*) FROM Compras) AS Totales_Compras,
    (SELECT COUNT(*) FROM Ventas) AS Totales_Ventas,
    (SELECT COUNT(*) FROM Sucursal) AS Totales_Sucursal,
    (SELECT COUNT(*) FROM Producto) AS Totales_Producto,
    (SELECT COUNT(*) FROM Region) AS Totales_Region,
    (SELECT COUNT(*) FROM Departamento) AS Totales_Departamento,
    (SELECT COUNT(*) FROM Marca) AS Totales_Marca,
    (SELECT COUNT(*) FROM Categoria) AS Totales_Categoria,
    (SELECT COUNT(*) FROM Fecha) AS Totales_Fecha,
    (SELECT COUNT(*) FROM Proveedor) AS Totales_Proveedor,
    (SELECT COUNT(*) FROM Cliente) AS Totales_Cliente,
    (SELECT COUNT(*) FROM Vendedor) AS Totales_Vendedor;

SELECT COUNT(*) FROM Compras AS Totales_Compras;
SELECT COUNT(*) FROM Ventas AS Totales_Ventas;
SELECT COUNT(*) FROM Sucursal AS Totales_Sucursal;
SELECT COUNT(*) FROM Producto AS Totales_Producto;
SELECT COUNT(*) FROM Region AS Totales_Region;
SELECT COUNT(*) FROM Departamento AS Totales_Departamento;
SELECT COUNT(*) FROM Marca AS Totales_Marca;
SELECT COUNT(*) FROM Categoria AS Totales_Categoria;
SELECT COUNT(*) FROM Fecha AS Totales_Fecha;
SELECT COUNT(*) FROM Proveedor AS Totales_Proveedor;
SELECT COUNT(*) FROM Cliente AS Totales_Cliente;
SELECT COUNT(*) FROM Vendedor AS Totales_Vendedor;

SELECT * FROM Compras;
SELECT * FROM Ventas;
SELECT * FROM Sucursal;
SELECT * FROM Producto;
SELECT * FROM Region;
SELECT * FROM Departamento;
SELECT * FROM Marca;
SELECT * FROM Categoria;
SELECT * FROM Fecha;
SELECT * FROM Proveedor;
SELECT * FROM Cliente;
SELECT * FROM Vendedor;
