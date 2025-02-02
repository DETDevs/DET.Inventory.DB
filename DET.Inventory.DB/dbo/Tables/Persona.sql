CREATE TABLE [dbo].[Persona]
(
	IdPersona           INT PRIMARY KEY IDENTITY(1,1),
    Nombre              VARCHAR(100) NOT NULL,
    Apellidos           VARCHAR(100),
    Identificacion      VARCHAR(50) UNIQUE,
    Telefono            VARCHAR(20),
    Direccion           VARCHAR(255),
    Email               VARCHAR(100),
    Activo              BIT DEFAULT 1,
    FechaCreacion       DATETIME DEFAULT CURRENT_TIMESTAMP,
    UsuarioCreacion     VARCHAR(255) NOT NULL,
    FechaModificacion   DATETIME
)
