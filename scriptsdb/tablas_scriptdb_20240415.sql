USE [Eventos_Scanid]
GO

EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuarios', @level2type=N'COLUMN',@level2name=N'Estado'
GO

ALTER TABLE [dbo].[Usuarios] DROP CONSTRAINT [DF_Usuarios_Estado]
GO

ALTER TABLE [dbo].[Opciones_sistema] DROP CONSTRAINT [DF_Opciones_sistema_Estado]
GO

/****** Object:  Table [dbo].[Usuarios]    Script Date: 2024-04-16 8:03:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Usuarios]') AND type in (N'U'))
DROP TABLE [dbo].[Usuarios]
GO

/****** Object:  Table [dbo].[Opciones_sistema]    Script Date: 2024-04-16 8:03:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Opciones_sistema]') AND type in (N'U'))
DROP TABLE [dbo].[Opciones_sistema]
GO

/****** Object:  Table [dbo].[Eventos]    Script Date: 2024-04-16 8:03:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Eventos]') AND type in (N'U'))
DROP TABLE [dbo].[Eventos]
GO

/****** Object:  Table [dbo].[Clientes]    Script Date: 2024-04-16 8:03:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Clientes]') AND type in (N'U'))
DROP TABLE [dbo].[Clientes]
GO

/****** Object:  Table [dbo].[Clientes]    Script Date: 2024-04-16 8:03:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Clientes](
	[Rut] [varchar](20) NOT NULL,
	[Nombres] [varchar](50) NULL,
	[Apellidos] [varchar](50) NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Eventos]    Script Date: 2024-04-16 8:03:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Eventos](
	[Id_Evento] [bigint] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](20) NOT NULL,
	[Descripcion] [varchar](50) NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Opciones_sistema]    Script Date: 2024-04-16 8:03:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Opciones_sistema](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Opcion] [varchar](12) NOT NULL,
	[Nombre_opcion] [varchar](100) NOT NULL,
	[Estado] [char](1) NOT NULL,
	[Menu] [varchar](50) NULL,
	[SubMenu] [varchar](50) NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Usuarios]    Script Date: 2024-04-16 8:03:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Usuarios](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Evento] [varchar](12) NULL,
	[Usuario] [varchar](12) NOT NULL,
	[Clave] [varchar](30) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Apellidos] [varchar](50) NULL,
	[Direccion] [varchar](100) NULL,
	[Telefono] [varchar](20) NULL,
	[Email] [varchar](50) NULL,
	[Ubicacion_latitud] [numeric](13, 7) NULL,
	[Ubicacion_longitud] [numeric](13, 7) NULL,
	[Estado] [char](1) NOT NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Opciones_sistema] ADD  CONSTRAINT [DF_Opciones_sistema_Estado]  DEFAULT ('S') FOR [Estado]
GO

ALTER TABLE [dbo].[Usuarios] ADD  CONSTRAINT [DF_Usuarios_Estado]  DEFAULT ('A') FOR [Estado]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A=Activo I=Inactivo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Usuarios', @level2type=N'COLUMN',@level2name=N'Estado'
GO


