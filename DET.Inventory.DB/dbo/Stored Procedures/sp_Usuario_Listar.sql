USE [DET.Inventory.DB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        Douglas Hernández
-- Create date:   01/02/2025
-- Description:   SP para listar los usuarios
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_Usuario_Listar]
    @IdUsuario      INT = NULL,
    @UserName       VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
         SELECT u.IdUsuario, p.Nombre, p.Apellidos, p.Identificacion, p.Email, r.Nombre AS Rol, u.UserName, u.Activo, 
           u.FechaCreacion, u.UsuarioCreacion, u.FechaModificacion
        FROM Usuario u
        INNER JOIN Persona p ON u.Fk_Persona = p.IdPersona
        INNER JOIN Rol r ON u.Fk_Rol = r.IdRol
        WHERE (@IdUsuario IS NULL OR u.IdUsuario = @IdUsuario)
        AND (@UserName IS NULL OR u.UserName = @UserName)

    END TRY
    BEGIN CATCH
        DECLARE 
            @NumeroError INT = ERROR_NUMBER(),
            @DescripcionError NVARCHAR(500) = ERROR_MESSAGE();

        -----------------------------------------------------------------------
        -- Manejo de errores
        -----------------------------------------------------------------------
        THROW 51051, @DescripcionError, 1;
    END CATCH
END
GO
