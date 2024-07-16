USE [Eventos_Scanid]
GO

/****** Object:  StoredProcedure [dbo].[USUARIOS_Valida_usuario]    Script Date: 03-07-2024 16:12:22 ******/
DROP PROCEDURE [dbo].[USUARIOS_Valida_usuario]
GO

/****** Object:  StoredProcedure [dbo].[USUARIOS_Lista_usuarios]    Script Date: 03-07-2024 16:12:22 ******/
DROP PROCEDURE [dbo].[USUARIOS_Lista_usuarios]
GO

/****** Object:  StoredProcedure [dbo].[USUARIOS_Graba_usuarios]    Script Date: 03-07-2024 16:12:22 ******/
DROP PROCEDURE [dbo].[USUARIOS_Graba_usuarios]
GO

/****** Object:  StoredProcedure [dbo].[USUARIOS_Elimina_usuarios]    Script Date: 03-07-2024 16:12:22 ******/
DROP PROCEDURE [dbo].[USUARIOS_Elimina_usuarios]
GO

/****** Object:  StoredProcedure [dbo].[USUARIOS_Actualiza_usuarios]    Script Date: 03-07-2024 16:12:22 ******/
DROP PROCEDURE [dbo].[USUARIOS_Actualiza_usuarios]
GO

/****** Object:  StoredProcedure [dbo].[PAISES_Lista_paises]    Script Date: 03-07-2024 16:12:22 ******/
DROP PROCEDURE [dbo].[PAISES_Lista_paises]
GO

/****** Object:  StoredProcedure [dbo].[FXP_Lista_opciones_asignadas_a_usuario]    Script Date: 03-07-2024 16:12:22 ******/
DROP PROCEDURE [dbo].[FXP_Lista_opciones_asignadas_a_usuario]
GO

/****** Object:  StoredProcedure [dbo].[EVENTOS_Lista_eventos]    Script Date: 03-07-2024 16:12:22 ******/
DROP PROCEDURE [dbo].[EVENTOS_Lista_eventos]
GO

/****** Object:  StoredProcedure [dbo].[ESTADISTICAS_Lista_datos_estadisticas]    Script Date: 03-07-2024 16:12:22 ******/
DROP PROCEDURE [dbo].[ESTADISTICAS_Lista_datos_estadisticas]
GO

/****** Object:  StoredProcedure [dbo].[CLIENTES_Lista_clientes]    Script Date: 03-07-2024 16:12:22 ******/
DROP PROCEDURE [dbo].[CLIENTES_Lista_clientes]
GO

/****** Object:  StoredProcedure [dbo].[CLIENTES_actualiza_codigo_qr]    Script Date: 03-07-2024 16:12:22 ******/
DROP PROCEDURE [dbo].[CLIENTES_actualiza_codigo_qr]
GO

/****** Object:  StoredProcedure [dbo].[CLIENTES_actualiza_codigo_qr]    Script Date: 03-07-2024 16:12:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CLIENTES_actualiza_codigo_qr]
	@nId		bigint,
	@QrCode		varchar(100)

AS
BEGIN
	
	if Exists(Select QR_Code_Entrega_Vestimenta From Clientes with (nolock)
				Where QR_Code_Entrega_Vestimenta = @QrCode )
		begin
			RAISERROR ('El codigo QR escaneado ya fue entregado.', 16, 1 );
		end
	Else
		Begin
			Update	Clientes
			Set		QR_Code_Entrega_Vestimenta = @QrCode
			Where	ID = @nId
		End
END
GO

/****** Object:  StoredProcedure [dbo].[CLIENTES_Lista_clientes]    Script Date: 03-07-2024 16:12:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[CLIENTES_Lista_clientes]
	@ID			BigInt,
	@Nombres	varchar(50),
	@Apellidos	varchar(50),
	@Direccion	varchar(100)

as

if @Nombres = ''
   Set @Nombres = Null
if @Apellidos = ''
   Set @Apellidos = Null

if @ID Is Not Null
	Select	ID,
			[Rut/Dni/Pasaporte] = Case 
									When Upper(Tipo) = 'PASAPORTE' Then STR( [Rut/Dni/Pasaporte], len([Rut/Dni/Pasaporte]) )
									When Upper(Tipo) = 'RUT'       Then Left( STR( [Rut/Dni/Pasaporte], len([Rut/Dni/Pasaporte]) ), 
																		      Len(STR( [Rut/Dni/Pasaporte], len([Rut/Dni/Pasaporte]) )) -1 ) + '-' + Right( STR( [Rut/Dni/Pasaporte], len([Rut/Dni/Pasaporte]) ),1)
									Else
									    STR( [Rut/Dni/Pasaporte], len([Rut/Dni/Pasaporte]) )
								  End,
			Nombres,
			Apellidos,
			Direccion    = C.Direccion,
			Ciudad       = C.Ciudad,
			Nacionalidad = C.Nacionalidad,
			Sexo = Case 
						When C.Sexo = 'F' Then 'Femenino'
						When C.Sexo = 'M' Then 'Masculino'
						Else
							'No indicado'
					End,
			Nombre_De_Club = C.Nombre_De_Club,
			QR_Code_Entrega_Vestimenta,
			QR_Code_Entrega_Bicicleta
	from	Clientes C with (nolock)
	Where	ID = @ID
Else
	Select	ID,
			[Rut/Dni/Pasaporte] = Case 
									When Upper(Tipo) = 'PASAPORTE' Then STR( [Rut/Dni/Pasaporte], len([Rut/Dni/Pasaporte]) )
									When Upper(Tipo) = 'RUT'       Then Left( STR( [Rut/Dni/Pasaporte], len([Rut/Dni/Pasaporte]) ), 
																		      Len(STR( [Rut/Dni/Pasaporte], len([Rut/Dni/Pasaporte]) )) -1 ) + '-' + Right( STR( [Rut/Dni/Pasaporte], len([Rut/Dni/Pasaporte]) ),1)
									Else
									    STR( [Rut/Dni/Pasaporte], len([Rut/Dni/Pasaporte]) )
								  End,
			Nombres,
			Apellidos,
			Direccion    = C.Direccion,
			Ciudad       = C.Ciudad,
			Nacionalidad = C.Nacionalidad,
			Sexo = Case 
						When C.Sexo = 'F' Then 'Femenino'
						When C.Sexo = 'M' Then 'Masculino'
						Else
							'No indicado'
					End,
			Nombre_De_Club = C.Nombre_De_Club,
			QR_Code_Entrega_Vestimenta,
			QR_Code_Entrega_Bicicleta
	from	Clientes C with (nolock)
	Where	( @Nombres Is Null Or Nombres like '%' + @Nombres + '%' )
		And ( @Apellidos Is Null Or Apellidos like '%' + @Apellidos + '%' )
		And ( @Direccion Is Null Or Direccion like '%' + @Direccion + '%' )
	Order by Nombres, Apellidos
GO

/****** Object:  StoredProcedure [dbo].[ESTADISTICAS_Lista_datos_estadisticas]    Script Date: 03-07-2024 16:12:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ESTADISTICAS_Lista_datos_estadisticas]
	@Evento	int
AS
BEGIN
	Declare @TotalAsistentes int,
			@TotalAsistentes_autorizados int

	SELECT	@TotalAsistentes = Count(*)
	From	Clientes C with (nolock)
	Where	C.ID_Evento = @Evento

	SELECT	@TotalAsistentes_autorizados = Count(*)
	From	Clientes C with (nolock)
	Where	C.ID_Evento = @Evento
		And C.QR_Code_Entrega_Vestimenta Is Not Null

	Select TotalAsistentes = @TotalAsistentes, TotalAsistentes_autorizados = @TotalAsistentes_autorizados

END
GO

/****** Object:  StoredProcedure [dbo].[EVENTOS_Lista_eventos]    Script Date: 03-07-2024 16:12:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EVENTOS_Lista_eventos]
	@Id		bigint
AS
BEGIN
	SET NOCOUNT ON;

	SELECT	[Id_Evento]
			,[Codigo]
			,[Descripcion]
	FROM	[Eventos] with (nolock)
	Where	(@Id Is Null OR [Id_Evento] = @Id )

END
GO

/****** Object:  StoredProcedure [dbo].[FXP_Lista_opciones_asignadas_a_usuario]    Script Date: 03-07-2024 16:12:23 ******/
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

/****** Object:  StoredProcedure [dbo].[PAISES_Lista_paises]    Script Date: 03-07-2024 16:12:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[PAISES_Lista_paises]
		@codigo	varchar(3),
		@nombre varchar(50)
AS
BEGIN
	 
	SET NOCOUNT ON;

	if @codigo = ''
		Select @codigo = Null
	if @nombre = ''
		Select @nombre = Null

	SELECT PaisCodigo,
			PaisNombre,
			PaisContinente,
			PaisRegion
	From	Pais with (nolock)
	Where	(@codigo is Null Or PaisCodigo = @codigo)
		And PaisNombre like '%' + IsNull(@nombre,'') + '%'
	Order by PaisNombre
END
GO

/****** Object:  StoredProcedure [dbo].[USUARIOS_Actualiza_usuarios]    Script Date: 03-07-2024 16:12:23 ******/
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

/****** Object:  StoredProcedure [dbo].[USUARIOS_Elimina_usuarios]    Script Date: 03-07-2024 16:12:23 ******/
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

/****** Object:  StoredProcedure [dbo].[USUARIOS_Graba_usuarios]    Script Date: 03-07-2024 16:12:23 ******/
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

/****** Object:  StoredProcedure [dbo].[USUARIOS_Lista_usuarios]    Script Date: 03-07-2024 16:12:23 ******/
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

/****** Object:  StoredProcedure [dbo].[USUARIOS_Valida_usuario]    Script Date: 03-07-2024 16:12:23 ******/
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


