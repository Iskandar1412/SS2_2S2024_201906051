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