USE [DET.Inventory.DB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        Douglas Hernandez
-- Create date:   02/02/2025
-- Description:   SP para listar los productos
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_Producto_Listar]
    @IdProducto INT = NULL
AS
BEGIN
 SET NOCOUNT ON;
    BEGIN TRY
        SELECT p.IdProducto, p.Nombre, p.Descripcion, p.Stock, p.PrecioCompra, p.PrecioVenta, p.MargenGanancia, p.Activo, 
           prov.NombreEmpresa AS Proveedor, c.Nombre AS Categoria, p.FechaCreacion, p.UsuarioCreacion, p.FechaModificacion
        FROM Producto p
        INNER JOIN Proveedor prov ON p.Fk_Proveedor = prov.IdProveedor
        INNER JOIN Categoria c ON p.Fk_Categoria = c.IdCategoria
        WHERE (@IdProducto IS NULL OR p.IdProducto = @IdProducto)
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