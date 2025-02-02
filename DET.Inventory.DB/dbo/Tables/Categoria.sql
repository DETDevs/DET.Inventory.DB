CREATE TABLE [dbo].[Categoria] (
    IdCategoria         INT PRIMARY KEY IDENTITY(1,1),
    Codigo              VARCHAR(255) NOT NULL,
    Nombre              VARCHAR(100) NOT NULL,
    Descripcion         VARCHAR(255),
    Activo              BIT DEFAULT 1,
    FechaCreacion       DATETIME DEFAULT CURRENT_TIMESTAMP,
    UsuarioCreacion     VARCHAR(255) NOT NULL,
    FechaModificacion   DATETIME
);