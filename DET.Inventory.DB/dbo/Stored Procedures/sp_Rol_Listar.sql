USE [DET.Inventory.DB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        Douglas Hernández
-- Create date:   01/02/2025
-- Description:   SP para listar los roles
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_Rol_Listar]
    @IdRol INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
       SELECT IdRol, Nombre, Descripcion, Activo, FechaCreacion, UsuarioCreacion, FechaModificacion
        FROM Rol
        WHERE (@IdRol IS NULL OR IdRol = @IdRol)
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
