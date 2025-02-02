CREATE TABLE [dbo].[Proveedor]
(
	IdProveedor         INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Fk_Persona          INT NOT NULL,
    CodigoProveedor     VARCHAR(255) NOT NULL,
    NombreEmpresa       VARCHAR(150),
    Activo              BIT DEFAULT 1,
    FechaCreacion       DATETIME DEFAULT CURRENT_TIMESTAMP,
    UsuarioCreacion     VARCHAR(255) NOT NULL,
    FechaModificacion   DATETIME
)
