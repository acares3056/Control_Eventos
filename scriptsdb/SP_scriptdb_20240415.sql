USE [Eventos_Scanid]
GO

/****** Object:  StoredProcedure [dbo].[USUARIOS_Lista_usuarios]    Script Date: 2024-04-16 8:03:54 ******/
DROP PROCEDURE [dbo].[USUARIOS_Lista_usuarios]
GO

/****** Object:  StoredProcedure [dbo].[USUARIOS_Graba_usuarios]    Script Date: 2024-04-16 8:03:54 ******/
DROP PROCEDURE [dbo].[USUARIOS_Graba_usuarios]
GO

/****** Object:  StoredProcedure [dbo].[USUARIOS_Actualiza_usuarios]    Script Date: 2024-04-16 8:03:54 ******/
DROP PROCEDURE [dbo].[USUARIOS_Actualiza_usuarios]
GO

/****** Object:  StoredProcedure [dbo].[USUARIOS_Elimina_usuarios]    Script Date: 2024-04-16 8:03:54 ******/
DROP PROCEDURE [dbo].[USUARIOS_Elimina_usuarios]
GO

/****** Object:  StoredProcedure [dbo].[USUARIOS_Valida_usuario]    Script Date: 2024-04-16 8:03:54 ******/
DROP PROCEDURE [dbo].[USUARIOS_Valida_usuario]
GO

/****** Object:  StoredProcedure [dbo].[FXP_Lista_opciones_asignadas_a_usuario]    Script Date: 2024-04-16 8:03:54 ******/
DROP PROCEDURE [dbo].[FXP_Lista_opciones_asignadas_a_usuario]
GO

/****** Object:  StoredProcedure [dbo].[FXP_Lista_opciones_asignadas_a_usuario]    Script Date: 2024-04-16 8:03:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FXP_Lista_opciones_asignadas_a_usuario]
	@Usuario	varchar(12)
AS
BEGIN
	SET NOCOUNT ON;

    SELECT	Opcion,
			Nombre_opcion,
			Modulo = Menu,
			Grupo = Submenu,
			Estado
	From	Opciones_sistema with (nolock)
	Where	Estado = 'V'
END
GO

/****** Object:  StoredProcedure [dbo].[USUARIOS_Valida_usuario]    Script Date: 2024-04-16 8:03:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USUARIOS_Valida_usuario]
	@Usuario		varchar(20),
	@Seguridad		varchar(30)

AS
BEGIN
	SET NOCOUNT ON;

	Select	Evento,
			Usuario,
			Clave,
			Nombre,
			Apellidos,
			Direccion,
			Telefono,
			Email,
			Ubicacion_latitud,
			Ubicacion_longitud,
			Estado
	From	Usuarios with (nolock)
	Where	Usuario = @Usuario
		And Clave = @Seguridad
		And Estado = 'V'

END
GO

/****** Object:  StoredProcedure [dbo].[USUARIOS_Elimina_usuarios]    Script Date: 2024-04-16 8:03:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[USUARIOS_Elimina_usuarios]
		@ID			int

as

DELETE FROM [dbo].[Usuarios]
WHERE ID = @ID
GO

/****** Object:  StoredProcedure [dbo].[USUARIOS_Actualiza_usuarios]    Script Date: 2024-04-16 8:03:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[USUARIOS_Actualiza_usuarios]
	@ID			int,
	@Nombre		varchar(50),
	@Apellidos	varchar(50),
	@Direccion	varchar(100),
	@Telefono	varchar(20),
	@Email		varchar(50),
	@Ubicacion_latitud	numeric(13,7),
	@Ubicacion_longitud	numeric(13,7),
	@Estado	char(1)
as

UPDATE [dbo].[Usuarios]
   SET [Nombre] = @Nombre
      ,[Apellidos] = @Apellidos
      ,[Direccion] = @Direccion
      ,[Telefono] = @Telefono
      ,[Email] = @Email
      ,[Ubicacion_latitud] = @Ubicacion_latitud
      ,[Ubicacion_longitud] = @Ubicacion_longitud
      ,[Estado] = @Estado
WHERE ID = @ID
GO

/****** Object:  StoredProcedure [dbo].[USUARIOS_Graba_usuarios]    Script Date: 2024-04-16 8:03:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[USUARIOS_Graba_usuarios]
			@ID			int
		   ,@Evento		varchar(12)
           ,@Usuario	varchar(12)
           ,@Clave		varchar(20)
           ,@Nombre		varchar(50)
           ,@Apellidos	varchar(50)
           ,@Direccion	varchar(100)
           ,@Telefono	varchar(20)
           ,@Email		varchar(100)
           ,@Ubicacion_latitud		numeric(13,7)
           ,@Ubicacion_longitud		numeric(13,7)
           ,@Estado					char(1)

As

if Exists(Select * From Usuarios U with (nolock) Where U.Evento = @Evento)
Begin
	UPDATE [dbo].[Usuarios]
	   SET EVENTO = @Evento
	      ,[Nombre] = @Nombre
		  ,[Apellidos] = @Apellidos
		  ,[Direccion] = @Direccion
		  ,[Telefono] = @Telefono
		  ,[Email] = @Email
		  ,[Ubicacion_latitud] = @Ubicacion_latitud
		  ,[Ubicacion_longitud] = @Ubicacion_longitud
		  ,[Estado] = @Estado
	WHERE ID = @ID
End
Else
Begin
	INSERT INTO [dbo].[Usuarios]
			   ([Usuario]
			   ,[Clave]
			   ,[Nombre]
			   ,[Apellidos]
			   ,[Direccion]
			   ,[Telefono]
			   ,[Email]
			   ,[Ubicacion_latitud]
			   ,[Ubicacion_longitud]
			   ,[Estado])
		 VALUES
			   (
			    @Usuario	
			   ,@Clave		
			   ,@Nombre		
			   ,@Apellidos	
			   ,@Direccion	
			   ,@Telefono	
			   ,@Email		
			   ,@Ubicacion_latitud
			   ,@Ubicacion_longitud
			   ,@Estado		
			   )
End
GO

/****** Object:  StoredProcedure [dbo].[USUARIOS_Lista_usuarios]    Script Date: 2024-04-16 8:03:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


Create Procedure [dbo].[USUARIOS_Lista_usuarios]
	@ID			int,
	@Nombre		varchar(100),
	@Apellido	varchar(100)

as

SELECT [Id]
      ,[Evento]
      ,[Usuario]
      ,[Clave]
      ,[Nombre]
      ,[Apellidos]
      ,[Direccion]
      ,[Telefono]
      ,[Email]
      ,[Ubicacion_latitud]
      ,[Ubicacion_longitud]
      ,[Estado]
FROM	Usuarios U with (nolock)
Where	id = @ID
	And Nombre like '%' + IsNull(@Nombre, '') + '%'
	And Apellidos like '%' + IsNull(@Apellido, '') + '%'
GO


