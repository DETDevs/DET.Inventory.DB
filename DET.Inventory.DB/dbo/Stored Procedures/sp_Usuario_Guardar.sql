USE [DET.Inventory.DB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        Douglas Hernández
-- Create date:   27/01/2025
-- Description:   SP para insertar o actualizar un usuario
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_Usuario_Guardar]
    @Nombre                VARCHAR(50),
    @Apellido              VARCHAR(50),
    @Identificacion        VARCHAR(50),
    @Telefono              VARCHAR(50),
    @Direccion             VARCHAR(50),
    @Email                 VARCHAR(50),
    @UserName              VARCHAR(50),
    @PasswordHash           VARCHAR(50),
    @UsuarioCreacion       VARCHAR(50),
    @Activo                BIT,
    @IdRol                INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DECLARE 
            @FechaCreacion      DATETIME = GETDATE(),
            @FechaModificacion  DATETIME = NULL,
            @IdPersona          INT = NULL
    
        IF(EXISTS(SELECT TOP 1 1 FROM Usuario WHERE UserName = @UserName))
        BEGIN
            -----------------------------------------------------------------------
            --Obtenemos el id de la persona
            -----------------------------------------------------------------------
            SELECT @IdPersona = (SELECT FK_Persona FROM Usuario WHERE UserName = @UserName)

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
        END
        ELSE
        BEGIN
            IF(EXISTS(SELECT TOP 1 1 FROM Rol WHERE IdRol = @IdRol))
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
                INSERT INTO Usuario (Fk_Persona, Fk_Rol, UserName, PasswordHash, Activo, FechaCreacion, UsuarioCreacion, FechaModificacion)
                VALUES (@IdPersona, @IdRol, @UserName, @PasswordHash, 1, @FechaCreacion, @UsuarioCreacion, @FechaModificacion);
            END
            ELSE
            BEGIN
                SELECT 'ROL NO EXISTE'
            END
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
