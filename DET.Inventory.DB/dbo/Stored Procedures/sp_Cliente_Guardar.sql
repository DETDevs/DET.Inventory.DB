USE [DET.Inventory.DB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        Douglas Hernandez
-- Create date:   02/02/2025
-- Description:   SP para insertar o actualizar un Cliente
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_Cliente_Guardar]
    @Nombre                VARCHAR(50),
    @Apellido              VARCHAR(50),
    @Identificacion        VARCHAR(50),
    @Telefono              VARCHAR(50),
    @Direccion             VARCHAR(50),
    @Email                 VARCHAR(50),
    @TipoCliente           VARCHAR(50),
    @CodigoCliente         VARCHAR(50),
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
    
        IF(EXISTS(SELECT TOP 1 1 FROM Cliente WHERE CodigoCliente = @CodigoCliente))
        BEGIN
            -----------------------------------------------------------------------
            -- Obtenemos el id de la persona
            -----------------------------------------------------------------------
            SELECT @IdPersona = (SELECT FK_Persona FROM Cliente WHERE CodigoCliente = @CodigoCliente)

            -----------------------------------------------------------------------
            -- Si existe, actualizar los datos del cliente en la tabla persona
            -----------------------------------------------------------------------
            UPDATE Persona
            SET Nombre = @Nombre,
                Apellidos = @Apellido,
                Identificacion = @Identificacion,
                Telefono = @Telefono,
                Direccion = @Direccion,
                Email = @Email,
                Activo = @Activo
            WHERE IdPersona = @IdPersona

            SELECT TOP 1 * FROM Cliente WHERE CodigoCliente = @CodigoCliente
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
            -- Insertamos en la tabla Usuario
            -----------------------------------------------------------------------
            INSERT INTO Cliente (CodigoCliente, Fk_Persona, TipoCliente, Activo, FechaCreacion, UsuarioCreacion, FechaModificacion)
            VALUES (@CodigoCliente, @IdPersona, @TipoCliente, 1, @FechaCreacion, @UsuarioCreacion, @FechaModificacion);

            SELECT TOP 1 * FROM Cliente WHERE CodigoCliente = @CodigoCliente
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
