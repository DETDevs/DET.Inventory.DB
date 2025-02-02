CREATE TABLE [dbo].[Cliente]
(
	IdCliente           INT PRIMARY KEY IDENTITY(1,1),
    CodigoCliente       varchar (50) NOT NULL UNIQUE,
    Fk_Persona          INT NOT NULL,
    TipoCliente         VARCHAR(100),
    Activo              BIT DEFAULT 1,
    FechaCreacion       DATETIME DEFAULT CURRENT_TIMESTAMP,
    UsuarioCreacion     VARCHAR(255) NOT NULL,
    FechaModificacion   DATETIME
)
