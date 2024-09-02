CREATE DATABASE DB3Seminario2_201906051;

CREATE TABLE Fecha(
	fecha_key int IDENTITY(1,1) PRIMARY KEY,
	year int,
    month int,
    day int
);

CREATE TABLE Proveedor(
	proveedor_key int IDENTITY(1,1) PRIMARY KEY,
	CodProveedor varchar(100),
	NombreProveedor varchar(100),
	DireccionProveedor varchar(255),
	NumeroProveedor int,
	WebProveedor varchar(100)
);

CREATE TABLE Cliente(
	cliente_key int IDENTITY(1,1) PRIMARY KEY,
	CodigoCliente varchar(100),
	NombreCliente varchar(100),
	TipoCliente varchar(100),
	DireccionCliente varchar(255),
	NumeroCliente int
);

CREATE TABLE Vendedor(
	vendedor_key int IDENTITY(1,1) PRIMARY KEY,
	CodVendedor varchar(100),
	NombreVendedor varchar(100),
	Vacacionista bit
);

CREATE TABLE Producto(
	producto_key int IDENTITY(1,1) PRIMARY KEY,
	CodProducto varchar(100),
	NombreProducto varchar(100),
	MarcaProducto varchar(100),
	Categoria varchar(100)
);

CREATE TABLE Sucursal(
    sucursal_key int IDENTITY(1,1) PRIMARY KEY,
	SodSucursal varchar(255),
	NombreSucursal varchar(100),
	DireccionSucursal varchar(255),
	Region varchar(100),
	Departamento varchar(100)
);

CREATE TABLE Compras(
	fecha_key int,
	proveedor_key int, 
	producto_key int,
	sucursal_key int,
	Unidades int, 
	CostoU decimal,
	FOREIGN KEY (fecha_key) REFERENCES Fecha(fecha_key),
	FOREIGN KEY (proveedor_key) REFERENCES Proveedor(proveedor_key),
	FOREIGN KEY (producto_key) REFERENCES Producto(producto_key),
	FOREIGN KEY (sucursal_key) REFERENCES Sucursal(sucursal_key)
);

CREATE TABLE Ventas(
	fecha_key int,
	cliente_key int, 
	vendedor_key int, 
	producto_key int,
	sucursal_key int,
	Unidades int, 
	PrecioUnitario decimal,
	FOREIGN KEY (fecha_key) REFERENCES Fecha(fecha_key),
	FOREIGN KEY (cliente_key) REFERENCES Cliente(cliente_key),
	FOREIGN KEY (vendedor_key) REFERENCES Vendedor(vendedor_key),
	FOREIGN KEY (producto_key) REFERENCES Producto(producto_key),
	FOREIGN KEY (sucursal_key) REFERENCES Sucursal(sucursal_key)
);