CREATE DATABASE DB1Seminario2_201906051;
USE DB1Seminario2_201906051;
CREATE DATABASE DB2Seminario2_201906051;
USE DB2Seminario2_201906051;

CREATE TABLE TEMPORAL_COMP(
	Fecha NVARCHAR(255),
	CodProveedor NVARCHAR(100),
	NombreProveedor NVARCHAR(100),
	DireccionProveedor NVARCHAR(255),
	NumeroProveedor NVARCHAR(100),
	WebProveedor NVARCHAR(100),
	CodProducto NVARCHAR(100),
	NombreProducto NVARCHAR(100),
	MarcaProducto NVARCHAR(100),
	Categoria NVARCHAR(100),
	SodSuSursal NVARCHAR(100),
	NombreSucursal NVARCHAR(100),
	DireccionSucursal NVARCHAR(255),
	Region NVARCHAR(100),
	Departamento NVARCHAR(100),
	Unidades NVARCHAR(100),
	CostoU NVARCHAR(100)
);

CREATE TABLE TEMPORAL_VENT(
	Fecha NVARCHAR(100),
	CodigoCliente NVARCHAR(100),
	NombreCliente NVARCHAR(100),
	TipoCliente NVARCHAR(100),
	DireccionCliente NVARCHAR(255),
	NumeroCliente NVARCHAR(100),
	CodVendedor NVARCHAR(100),
	NombreVendedor NVARCHAR(100),
	Vacacionista NVARCHAR(100),
	CodProducto NVARCHAR(100),
	NombreProducto NVARCHAR(100),
	MarcaProducto NVARCHAR(100),
	Categoria NVARCHAR(100),
	SodSuSursal NVARCHAR(100),
	NombreSucursal NVARCHAR(100),
	DireccionSucursal NVARCHAR(255),
	Region NVARCHAR(100),
	Departamento NVARCHAR(100),
	Unidades NVARCHAR(100),
	PrecioUnitario NVARCHAR(100)
);