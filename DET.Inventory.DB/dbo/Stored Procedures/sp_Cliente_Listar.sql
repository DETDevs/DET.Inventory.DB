USE [DET.Inventory.DB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        Douglas Hernandez
-- Create date:   02/02/2025
-- Description:   SP para listar los clientes
-- =============================================

CREATE OR ALTER PROCEDURE [dbo].[sp_Cliente_Listar]
    @CodigoCliente  VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON; 
    BEGIN TRY
        IF(@CodigoCliente = '')
            SET @CodigoCliente = NULL

        SELECT 
            c.IdCliente, c.CodigoCliente, 
            p.IdPersona, p.Nombre, p.Apellidos, p.Identificacion, p.Telefono, p.Direccion, p.Email, 
            c.TipoCliente, c.Activo, c.FechaCreacion, c.UsuarioCreacion, c.FechaModificacion
        FROM Cliente c
        INNER JOIN Persona p ON c.Fk_Persona = p.IdPersona
        WHERE (@CodigoCliente IS NULL OR c.CodigoCliente = @CodigoCliente)

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
