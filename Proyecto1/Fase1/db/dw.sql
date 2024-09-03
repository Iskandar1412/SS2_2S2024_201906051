CREATE DATABASE DWH_Seminario2_201906051;

CREATE TABLE Fecha(
	fecha_key INT IDENTITY(1,1) PRIMARY KEY,
	year INT,
    month INT,
    day INT
);

CREATE TABLE Proveedor(
	proveedor_key INT IDENTITY(1,1) PRIMARY KEY,
	CodProveedor NVARCHAR(100),
	NombreProveedor NVARCHAR(100),
	DireccionProveedor NVARCHAR(255),
	NumeroProveedor INT,
	WebProveedor NVARCHAR(100)
);

CREATE TABLE Cliente(
	cliente_key INT IDENTITY(1,1) PRIMARY KEY,
	CodigoCliente NVARCHAR(100),
	NombreCliente NVARCHAR(100),
	TipoCliente NVARCHAR(100),
	DireccionCliente NVARCHAR(255),
	NumeroCliente INT
);

CREATE TABLE Vendedor(
	vendedor_key INT IDENTITY(1,1) PRIMARY KEY,
	CodVendedor NVARCHAR(100),
	NombreVendedor NVARCHAR(100),
	Vacacionista BIT
);

CREATE TABLE Marca(
	marca_key INT IDENTITY(1,1) PRIMARY KEY,
	MarcaProducto NVARCHAR(100)
);

CREATE TABLE Categoria(
	categoria_key INT IDENTITY(1,1) PRIMARY KEY,
	Categoria NVARCHAR(100)
);

CREATE TABLE Producto(
	producto_key INT IDENTITY(1,1) PRIMARY KEY,
	CodProducto NVARCHAR(100),
	NombreProducto NVARCHAR(100),
	marca_key INT,
	categoria_key INT,
	FOREIGN KEY (marca_key) REFERENCES Marca(marca_key),
	FOREIGN KEY (categoria_key) REFERENCES Categoria(categoria_key)
);

CREATE TABLE Departamento(
	departamento_key INT IDENTITY(1,1) PRIMARY KEY,
	Departamento NVARCHAR(100)
);

CREATE TABLE Region(
	region_key INT IDENTITY(1,1) PRIMARY KEY,
	Region NVARCHAR(100),
	departamento_key INT,
	FOREIGN KEY (departamento_key) REFERENCES Departamento(departamento_key)
);

CREATE TABLE Sucursal(
	sucursal_key INT IDENTITY(1,1) PRIMARY KEY,
	SodSuSursal NVARCHAR(100),
	NombreSucursal NVARCHAR(100),
	DireccionSucursal NVARCHAR(255),
	region_key INT,
	FOREIGN KEY (region_key) REFERENCES Region(region_key)
);

CREATE TABLE Compras(
	fecha_key INT,
	proveedor_key INT, 
	producto_key INT,
	sucursal_key INT,
	Unidades INT, 
	CostoU DECIMAL,
	FOREIGN KEY (fecha_key) REFERENCES Fecha(fecha_key),
	FOREIGN KEY (proveedor_key) REFERENCES Proveedor(proveedor_key),
	FOREIGN KEY (producto_key) REFERENCES Producto(producto_key),
	FOREIGN KEY (sucursal_key) REFERENCES Sucursal(sucursal_key)
);

CREATE TABLE Ventas(
	fecha_key INT,
	cliente_key INT, 
	vendedor_key INT, 
	producto_key INT,
	sucursal_key INT,
	Unidades INT, 
	PrecioUnitario DECIMAL,
	FOREIGN KEY (fecha_key) REFERENCES Fecha(fecha_key),
	FOREIGN KEY (cliente_key) REFERENCES Cliente(cliente_key),
	FOREIGN KEY (vendedor_key) REFERENCES Vendedor(vendedor_key),
	FOREIGN KEY (producto_key) REFERENCES Producto(producto_key),
	FOREIGN KEY (sucursal_key) REFERENCES Sucursal(sucursal_key)
);