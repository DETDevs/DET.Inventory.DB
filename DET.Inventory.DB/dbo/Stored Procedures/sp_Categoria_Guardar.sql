USE [DET.Inventory.DB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        Douglas Hernández
-- Create date:   02/02/2025
-- Description:   SP para insertar o actualizar una categoria
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_Categoria_Guardar]
    @Codigo             VARCHAR (50),
    @Nombre             VARCHAR (50),
    @Descripcion        VARCHAR (50),
    @UsuarioCreacion    VARCHAR (50)
AS 
BEGIN
 SET NOCOUNT ON;
    BEGIN TRY
        DECLARE
            @Activo             BIT     = 1,
            @FechaCreacion      DATETIME = GETDATE()
		
		-----------------------------------------------------------------------
        -- Se inserta la Categoria
        -----------------------------------------------------------------------

        INSERT INTO Categoria
				(
                    Codigo,
				    Nombre,
                    Descripcion,
                    Activo,
                    FechaCreacion,
                    UsuarioCreacion,
                    FechaModificacion
				)
				VALUES
				(
                    @Codigo,
				    @Nombre,
				    @Descripcion,
				    @Activo,
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