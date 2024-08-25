CREATE TABLE PivotCompras (
    Fecha DATE,
    CodProveedor VARCHAR(50),
    NombreProveedor VARCHAR(255),
    DireccionProveedor VARCHAR(255),
    NumeroProveedor VARCHAR(20),
    WebProveedor VARCHAR(100),
    CodProducto VARCHAR(50),
    NombreProducto VARCHAR(255),
    MarcaProducto VARCHAR(100),
    Categoria VARCHAR(100),
    SodSucursal VARCHAR(50),
    NombreSucursal VARCHAR(255),
    DireccionSucursal VARCHAR(255),
    Region VARCHAR(100),
    Departamento VARCHAR(100),
    Unidades INT,
    CostoU DECIMAL(10,2)
);

CREATE TABLE PivotVentas (
    Fecha DATE,
    CodigoCliente VARCHAR(50),
    NombreCliente VARCHAR(255),
    TipoCliente VARCHAR(50),
    DireccionCliente VARCHAR(255),
    NumeroCliente VARCHAR(20),
    CodVendedor VARCHAR(50),
    NombreVendedor VARCHAR(255),
    Vacacionista INT,
    CodProducto VARCHAR(50),
    NombreProducto VARCHAR(255),
    MarcaProducto VARCHAR(100),
    Categoria VARCHAR(100),
    SodSucursal VARCHAR(50),
    NombreSucursal VARCHAR(255),
    DireccionSucursal VARCHAR(255),
    Region VARCHAR(100),
    Departamento VARCHAR(100),
    Unidades INT,
    PrecioUnitario DECIMAL(10,2)
);