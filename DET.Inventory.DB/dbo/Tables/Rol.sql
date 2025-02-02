CREATE TABLE [dbo].[Rol]
(
	IdRol               INT PRIMARY KEY IDENTITY(1,1),
    Nombre              VARCHAR (255) UNIQUE,
    Descripcion         VARCHAR(255),
    Activo              BIT DEFAULT 1,
    FechaCreacion       DATETIME DEFAULT CURRENT_TIMESTAMP,
    UsuarioCreacion     VARCHAR(255) NOT NULL,
    FechaModificacion   DATETIME
)
