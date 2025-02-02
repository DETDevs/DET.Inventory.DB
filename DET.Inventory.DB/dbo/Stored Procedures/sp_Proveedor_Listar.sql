USE [DET.Inventory.DB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        Douglas Hernández
-- Create date:   02/02/2025
-- Description:   SP para listar los proveedores
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_Proveedor_Listar]
    @CodigoProveedor    VARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF(@CodigoProveedor = '')
            SET @CodigoProveedor = NULL

        SELECT 
            prov.IdProveedor, prov.CodigoProveedor, prov.NombreEmpresa, prov.Activo, prov.FechaCreacion, prov.UsuarioCreacion, prov.FechaModificacion,
            p.IdPersona, p.Nombre, p.Apellidos, p.Identificacion, p.Telefono, p.Direccion, p.Email
        FROM Proveedor prov
        INNER JOIN Persona p ON prov.Fk_Persona = p.IdPersona
        WHERE (@CodigoProveedor IS NULL OR prov.CodigoProveedor = @CodigoProveedor)
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
