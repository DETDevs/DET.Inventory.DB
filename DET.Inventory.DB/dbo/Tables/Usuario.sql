CREATE TABLE [dbo].[Usuario]
(
	IdUsuario           INT PRIMARY KEY IDENTITY(1,1),
    Fk_Persona          INT NOT NULL,
    Fk_Rol              INT NOT NULL,
    UserName            VARCHAR (255) UNIQUE,
    PasswordHash        VARCHAR(255),
    Activo              BIT DEFAULT 1,
    FechaCreacion       DATETIME DEFAULT CURRENT_TIMESTAMP,
    UsuarioCreacion     VARCHAR(255) NOT NULL,
    FechaModificacion   DATETIME
)
