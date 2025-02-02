CREATE TABLE [dbo].[Producto]
(
	IdProducto          INT PRIMARY KEY IDENTITY(1,1),
    Nombre              VARCHAR(100) NOT NULL,
    Descripcion         VARCHAR(255),
    Stock               INT DEFAULT 0,
    PrecioCompra        DECIMAL(10,2) DEFAULT 0.00,
    PrecioVenta         DECIMAL(10,2) DEFAULT 0.00,
    MargenGanancia      DECIMAL,
    Activo              BIT DEFAULT 1,
    Fk_Proveedor        INT NOT NULL,
    Fk_Categoria        INT NOT NULL,
    FechaCreacion       DATETIME DEFAULT CURRENT_TIMESTAMP,
    UsuarioCreacion     VARCHAR(255) NOT NULL,
    FechaModificacion   DATETIME
)
