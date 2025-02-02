USE [DET.Inventory.DB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        Douglas Hernández
-- Create date:   02/02/2025
-- Description:   SP para insertar o actualizar un producto
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_Producto_Guardar]
    @Nombre             VARCHAR (50),
    @Descripcion        VARCHAR (50),
    @Stock              VARCHAR (50),
    @PrecioCompra       DECIMAL,
    @MargenGanancia     DECIMAL,
    @CodigoProveedor    VARCHAR (50),
    @CodigoCategoria    VARCHAR (50),
    @UsuarioCreacion    VARCHAR (50)
AS
BEGIN
 SET NOCOUNT ON;
    BEGIN TRY
        DECLARE
            @PrecioVenta        DECIMAL,
            @Activo             BIT     = 1,
            @FechaCreacion      DATETIME = GETDATE(),
            @IdProveedor        INT = 0,
            @IdCategoria        INT = 0
        -----------------------------------------------------------------------
        -- Obtener IdProveedor
        -----------------------------------------------------------------------
        SELECT
            @IdProveedor = (SELECT TOP 1 IdProveedor 
                                FROM Proveedor WITH(NOLOCK)
                                WHERE CodigoProveedor = @CodigoProveedor);

        -----------------------------------------------------------------------
        -- Obtener IdCategoria
        -----------------------------------------------------------------------
        SELECT
            @IdCategoria = (SELECT TOP 1 IdCategoria 
                                FROM Categoria WITH(NOLOCK)
                                WHERE Codigo = @CodigoCategoria);

        -----------------------------------------------------------------------
        -- Obtener Precio de Venta
        -----------------------------------------------------------------------
        SELECT
            @PrecioVenta = @PrecioCompra + (@PrecioCompra * (@MargenGanancia/100))
		
		-----------------------------------------------------------------------
        --Se insertar el Producto
        -----------------------------------------------------------------------
        INSERT INTO Producto
				(
				    Nombre,
                    Descripcion,
                    Stock,
                    PrecioCompra,
                    PrecioVenta,
                    MargenGanancia,
                    Activo,
                    Fk_Proveedor,
                    Fk_Categoria,
                    FechaCreacion,
                    UsuarioCreacion,
                    FechaModificacion
				)
				VALUES
				(
				    @Nombre,
				    @Descripcion,
				    @Stock,
				    @PrecioCompra,
				    @PrecioVenta,
				    @MargenGanancia,
				    @Activo,
				    @IdProveedor,
				    @IdCategoria,
				    @FechaCreacion,
                    @UsuarioCreacion,
				    NULL
				);
	

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