USE [DET.Inventory.DB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        Douglas Hernandez
-- Create date:   02/02/2025
-- Description:   SP para insertar o actualizar un proveedor
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_Proveedor_Guardar]
    @Nombre                VARCHAR(50),
    @Apellido              VARCHAR(50),
    @Identificacion        VARCHAR(50),
    @Telefono              VARCHAR(50),
    @Direccion             VARCHAR(50),
    @Email                 VARCHAR(50),
    @Codigo                VARCHAR(50),
    @NombreEmpresa         VARCHAR(50),
    @UsuarioCreacion       VARCHAR(50),
    @Activo                BIT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DECLARE 
            @FechaCreacion      DATETIME = GETDATE(),
            @FechaModificacion  DATETIME = NULL,
            @IdPersona          INT = NULL
    
        IF(EXISTS(SELECT TOP 1 1 FROM Proveedor WHERE CodigoProveedor = @Codigo))
        BEGIN
            -----------------------------------------------------------------------
            -- Si existe, actualizar los datos en Proveedor
            -----------------------------------------------------------------------
            UPDATE Proveedor
            SET CodigoProveedor = @Codigo,
                NombreEmpresa   = @NombreEmpresa,
                FechaModificacion = GETDATE(),
                Activo = @Activo
            WHERE CodigoProveedor = @Codigo;

            SELECT TOP 1 * FROM Proveedor WHERE CodigoProveedor = @Codigo
        END
        ELSE
        BEGIN
            -----------------------------------------------------------------------
            -- Insertamos en la tabla Persona
            -----------------------------------------------------------------------
            INSERT INTO Persona (Nombre, Apellidos, Identificacion, Telefono, Direccion, Email, Activo, FechaCreacion, UsuarioCreacion, FechaModificacion)
            VALUES (@Nombre, @Apellido, @Identificacion, @Telefono, @Direccion, @Email, 1, @FechaCreacion, @UsuarioCreacion, @FechaModificacion);
    
            SET @IdPersona = SCOPE_IDENTITY();
    
            -----------------------------------------------------------------------
            -- Insertamos en la tabla Proveedor
            -----------------------------------------------------------------------
            INSERT INTO Proveedor (FK_Persona, CodigoProveedor, NombreEmpresa, Activo, FechaCreacion, UsuarioCreacion, FechaModificacion)
            VALUES (@IdPersona, @Codigo, @NombreEmpresa, 1, @FechaCreacion, @UsuarioCreacion, @FechaModificacion);

            SELECT TOP 1 * FROM Proveedor WHERE CodigoProveedor = @Codigo
        END
        

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
