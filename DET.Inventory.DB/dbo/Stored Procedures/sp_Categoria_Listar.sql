USE [DET.Inventory.DB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        Douglas Hernández
-- Create date:   02/02/2025
-- Description:   SP para listar categorias
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_Categoria_Listar]
    @IdCategoria    INT = NULL,
    @Codigo         VARCHAR(255) = NULL
AS
BEGIN
 SET NOCOUNT ON;
    BEGIN TRY
        SELECT IdCategoria, Codigo, Nombre, Descripcion, Activo, FechaCreacion, UsuarioCreacion, FechaModificacion
        FROM Categoria
        WHERE (@IdCategoria IS NULL OR IdCategoria = @IdCategoria)
        AND (@Codigo IS NULL OR Codigo = @Codigo)
    END TRY
    BEGIN CATCH
        DECLARE @Numer INT, @Error VARCHAR(500);
        SET @Numer = ERROR_NUMBER();
        SET @Error = ERROR_MESSAGE();
        THROW 51051, @Error, 1;

		 SELECT 0 AS Estado, 'Ocurrio un error: '+@Error AS Mensaje;
    END CATCH
END
GO