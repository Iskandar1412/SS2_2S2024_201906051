CREATE DATABASE DB1Seminario2_201906051;
CREATE DATABASE DB2Seminario2_201906051;

CREATE TABLE TemporalCompras (
    Fecha VARCHAR(100),
    CodProveedor VARCHAR(100),
    NombreProveedor VARCHAR(100),
    DireccionProveedor VARCHAR(255),
    NumeroProveedor VARCHAR(100),
    WebProveedor VARCHAR(100),
    CodProducto VARCHAR(100),
    NombreProducto VARCHAR(100),
    MarcaProducto VARCHAR(100),
    Categoria VARCHAR(100),
    SodSucursal VARCHAR(100),
    NombreSucursal VARCHAR(100),
    DireccionSucursal VARCHAR(255),
    Region VARCHAR(100),
    Departamento VARCHAR(100),
    Unidades VARCHAR(100),
    CostoU VARCHAR(100)
);

CREATE TABLE TemporalVentas (
    Fecha VARCHAR(100),
    CodigoCliente VARCHAR(100),
    NombreCliente VARCHAR(100),
    TipoCliente VARCHAR(100),
    DireccionCliente VARCHAR(255),
    NumeroCliente VARCHAR(100),
    CodVendedor VARCHAR(100),
    NombreVendedor VARCHAR(100),
    Vacacionista VARCHAR(100),
    CodProducto VARCHAR(100),
    NombreProducto VARCHAR(100),
    MarcaProducto VARCHAR(100),
    Categoria VARCHAR(100),
    SodSucursal VARCHAR(100),
    NombreSucursal VARCHAR(100),
    DireccionSucursal VARCHAR(255),
    Region VARCHAR(100),
    Departamento VARCHAR(100),
    Unidades VARCHAR(100),
    PrecioUnitario VARCHAR(100)
);

CREATE TABLE Pivote (
    Fecha DATE,
    CodProveedor VARCHAR(50),
    NombreProveedor VARCHAR(255),
    DireccionProveedor VARCHAR(255),
    NumeroProveedor VARCHAR(20),
    WebProveedor VARCHAR(100),
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
    CostoU DECIMAL(10,2),
    PrecioUnitario DECIMAL(10,2)
);