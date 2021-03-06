USE [master]
GO
/****** Object:  Database [Laboratorios]    Script Date: 19/08/2020 13:46:24 ******/
CREATE DATABASE [Laboratorios]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Laboratorios', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\Laboratorios.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Laboratorios_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER01\MSSQL\DATA\Laboratorios_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Laboratorios].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Laboratorios] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Laboratorios] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Laboratorios] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Laboratorios] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Laboratorios] SET ARITHABORT OFF 
GO
ALTER DATABASE [Laboratorios] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Laboratorios] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Laboratorios] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Laboratorios] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Laboratorios] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Laboratorios] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Laboratorios] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Laboratorios] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Laboratorios] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Laboratorios] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Laboratorios] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Laboratorios] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Laboratorios] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Laboratorios] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Laboratorios] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Laboratorios] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Laboratorios] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Laboratorios] SET RECOVERY FULL 
GO
ALTER DATABASE [Laboratorios] SET  MULTI_USER 
GO
ALTER DATABASE [Laboratorios] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Laboratorios] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Laboratorios] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Laboratorios] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Laboratorios] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Laboratorios', N'ON'
GO
ALTER DATABASE [Laboratorios] SET QUERY_STORE = OFF
GO
USE [Laboratorios]
GO
/****** Object:  Table [dbo].[Estudiantes]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estudiantes](
	[cedulaEstudiante] [nvarchar](10) NOT NULL,
	[nombreEstudiante] [nvarchar](45) NULL,
	[apellidoEstudiante] [nvarchar](45) NULL,
	[telefonoEstudiante] [nvarchar](10) NULL,
 CONSTRAINT [PK_Estudiantes] PRIMARY KEY CLUSTERED 
(
	[cedulaEstudiante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Laboratoristas]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Laboratoristas](
	[cedulaLaboratorista] [nvarchar](10) NOT NULL,
	[nombreLaboratorista] [nvarchar](45) NULL,
	[apellidoLaboratorista] [nvarchar](45) NULL,
	[telefonoLaboratorista] [nvarchar](10) NULL,
 CONSTRAINT [PK_Laboratoristas] PRIMARY KEY CLUSTERED 
(
	[cedulaLaboratorista] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prestamos_Estudiantes]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prestamos_Estudiantes](
	[idPrestamo] [int] IDENTITY(1,1) NOT NULL,
	[cedulaEstudiante] [nvarchar](10) NULL,
	[cedulaLaboratorista] [nvarchar](10) NULL,
	[fechaPrestamo] [datetime] NULL,
	[estadoPrestamo] [int] NULL,
 CONSTRAINT [PK_Prestamos_Estudiantes] PRIMARY KEY CLUSTERED 
(
	[idPrestamo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vstDatosPrestamoEstudiante]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vstDatosPrestamoEstudiante]
AS
SELECT PE.idPrestamo, E.cedulaEstudiante, E.nombreEstudiante, E.apellidoEstudiante, L.cedulaLaboratorista, L.nombreLaboratorista, L.apellidoLaboratorista, PE.fechaPrestamo
FROM     dbo.Prestamos_Estudiantes AS PE INNER JOIN
                  dbo.Estudiantes AS E ON PE.cedulaEstudiante = E.cedulaEstudiante INNER JOIN
                  dbo.Laboratoristas AS L ON PE.cedulaLaboratorista = L.cedulaLaboratorista
WHERE  (PE.estadoPrestamo = 0)
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias](
	[idCategoria] [int] IDENTITY(1,1) NOT NULL,
	[nombreCategoria] [nvarchar](20) NULL,
 CONSTRAINT [PK_Categorias] PRIMARY KEY CLUSTERED 
(
	[idCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventarios]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventarios](
	[idInventario] [int] IDENTITY(1,1) NOT NULL,
	[nombreInventario] [nvarchar](45) NULL,
	[cantidadInventario] [int] NULL,
	[idCategoria] [int] NULL,
	[lastChange] [datetime] NULL,
 CONSTRAINT [PK_Inventarios] PRIMARY KEY CLUSTERED 
(
	[idInventario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detalle_Prestamos_Estudiantes]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalle_Prestamos_Estudiantes](
	[idPrestamo] [int] NULL,
	[cantidadPrestamo] [int] NULL,
	[idInventario] [int] NULL,
	[observacion] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vstDetallePrestamosEst]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vstDetallePrestamosEst]
AS
SELECT DP.idPrestamo,DP.idInventario,I.nombreInventario,C.nombreCategoria,DP.cantidadPrestamo 
FROM Detalle_Prestamos_Estudiantes DP
INNER JOIN Inventarios I ON DP.idInventario=I.idInventario
INNER JOIN Categorias C ON I.idCategoria=C.idCategoria
GO
/****** Object:  Table [dbo].[Docentes]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Docentes](
	[cedulaDocente] [nvarchar](10) NOT NULL,
	[nombreDocente] [nvarchar](45) NULL,
	[apellidoDocente] [nvarchar](45) NULL,
	[telefonoDocente] [nvarchar](45) NULL,
 CONSTRAINT [PK_Docentes] PRIMARY KEY CLUSTERED 
(
	[cedulaDocente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prestamos_Docentes]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prestamos_Docentes](
	[idPrestamo] [int] IDENTITY(1,1) NOT NULL,
	[cedulaDocente] [nvarchar](10) NULL,
	[cedulaLaboratorista] [nvarchar](10) NULL,
	[fechaPrestamo] [datetime] NULL,
	[estadoPrestamo] [int] NULL,
 CONSTRAINT [PK_Prestamos_Docentes] PRIMARY KEY CLUSTERED 
(
	[idPrestamo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vstDatosPrestamoDocente]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vstDatosPrestamoDocente]
AS
SELECT PE.idPrestamo, E.cedulaDocente, E.nombreDocente, E.apellidoDocente, L.cedulaLaboratorista, L.nombreLaboratorista, L.apellidoLaboratorista, PE.fechaPrestamo
FROM     dbo.Prestamos_Docentes AS PE INNER JOIN
                  dbo.Docentes AS E ON PE.cedulaDocente= E.cedulaDocente INNER JOIN
                  dbo.Laboratoristas AS L ON PE.cedulaLaboratorista = L.cedulaLaboratorista
WHERE  (PE.estadoPrestamo = 0)
GO
/****** Object:  Table [dbo].[Detalle_Prestamos_Docentes]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalle_Prestamos_Docentes](
	[idPrestamo] [int] NULL,
	[cantidadPrestamo] [int] NULL,
	[idInventario] [int] NULL,
	[observacion] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vstDetallePrestamosDoc]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vstDetallePrestamosDoc]
AS
SELECT DP.idPrestamo, DP.idInventario, I.nombreInventario, C.nombreCategoria, DP.cantidadPrestamo
FROM     dbo.Detalle_Prestamos_Docentes AS DP INNER JOIN
                  dbo.Inventarios AS I ON DP.idInventario = I.idInventario INNER JOIN
                  dbo.Categorias AS C ON I.idCategoria = C.idCategoria
GO
/****** Object:  Table [dbo].[Invitados]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invitados](
	[cedulaInvitado] [nvarchar](10) NOT NULL,
	[nombreInvitado] [nvarchar](45) NULL,
	[apellidoInvitado] [nvarchar](45) NULL,
	[telefonoInvitado] [nvarchar](45) NULL,
 CONSTRAINT [PK_Invitados] PRIMARY KEY CLUSTERED 
(
	[cedulaInvitado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prestamos_Invitados]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prestamos_Invitados](
	[idPrestamo] [int] IDENTITY(1,1) NOT NULL,
	[cedulaInvitado] [nvarchar](10) NULL,
	[cedulaLaboratorista] [nvarchar](10) NULL,
	[fechaPrestamo] [datetime] NULL,
	[estadoPrestamo] [int] NULL,
 CONSTRAINT [PK_Prestamos_Invitados] PRIMARY KEY CLUSTERED 
(
	[idPrestamo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vstDatosPrestamoInvitado]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vstDatosPrestamoInvitado]
AS
SELECT PE.idPrestamo, E.cedulaInvitado, E.nombreInvitado, E.apellidoInvitado, L.cedulaLaboratorista, L.nombreLaboratorista, L.apellidoLaboratorista, PE.fechaPrestamo
FROM     dbo.Prestamos_Invitados AS PE INNER JOIN
                  dbo.Invitados AS E ON PE.cedulaInvitado = E.cedulaInvitado INNER JOIN
                  dbo.Laboratoristas AS L ON PE.cedulaLaboratorista = L.cedulaLaboratorista
WHERE  (PE.estadoPrestamo = 0)
GO
/****** Object:  Table [dbo].[Detalle_Prestamos_Invitados]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalle_Prestamos_Invitados](
	[idPrestamo] [int] NULL,
	[cantidadPrestamo] [int] NULL,
	[idInventario] [int] NULL,
	[observacion] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vstDetallePrestamosInv]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vstDetallePrestamosInv]
AS
SELECT DP.idPrestamo, DP.idInventario, I.nombreInventario, C.nombreCategoria, DP.cantidadPrestamo
FROM     dbo.Detalle_Prestamos_Invitados AS DP INNER JOIN
                  dbo.Inventarios AS I ON DP.idInventario = I.idInventario INNER JOIN
                  dbo.Categorias AS C ON I.idCategoria = C.idCategoria
GO
/****** Object:  Table [dbo].[Carreras]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carreras](
	[idCarrera] [int] IDENTITY(1,1) NOT NULL,
	[nombreCarrera] [nvarchar](45) NULL,
 CONSTRAINT [PK_Carreras] PRIMARY KEY CLUSTERED 
(
	[idCarrera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dias]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dias](
	[idDia] [nvarchar](2) NOT NULL,
	[nombreDia] [nvarchar](10) NULL,
 CONSTRAINT [PK_Dias] PRIMARY KEY CLUSTERED 
(
	[idDia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Horas]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Horas](
	[idHora] [nvarchar](2) NOT NULL,
	[horaInicio] [time](7) NULL,
	[horaFin] [time](7) NULL,
 CONSTRAINT [PK_Horas] PRIMARY KEY CLUSTERED 
(
	[idHora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Laboratorios]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Laboratorios](
	[idLaboratorio] [int] IDENTITY(1,1) NOT NULL,
	[nombreLaboratorio] [nvarchar](45) NULL,
	[ubicacionLaboratorio] [nvarchar](45) NULL,
	[capacidadLaboratorio] [int] NULL,
	[idTipoLaboratorio] [int] NULL,
	[estadoLaboratorio] [int] NULL,
 CONSTRAINT [PK_Laboratorios] PRIMARY KEY CLUSTERED 
(
	[idLaboratorio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Laboratorios_Docentes]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Laboratorios_Docentes](
	[idLabDocente] [int] IDENTITY(1,1) NOT NULL,
	[fechaPrestamo] [datetime] NULL,
	[idLaboratorio] [int] NULL,
	[cedulaLaboratorista] [nvarchar](10) NULL,
	[idMateria] [int] NULL,
	[estadoPrestamo] [int] NULL,
 CONSTRAINT [PK_Laboratorios_Docentes] PRIMARY KEY CLUSTERED 
(
	[idLabDocente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Laboratorios_Equipos]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Laboratorios_Equipos](
	[idLaboratorio] [int] NULL,
	[idEquipo] [nvarchar](5) NULL,
	[descripciónEquipos] [nvarchar](300) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Laboratorios_Horas]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Laboratorios_Horas](
	[idLaboratorio] [int] NULL,
	[idDia] [nvarchar](2) NULL,
	[idHora] [nvarchar](2) NULL,
	[idMateria] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Laboratorios_Invitados]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Laboratorios_Invitados](
	[idLabInvitado] [int] IDENTITY(1,1) NOT NULL,
	[idLaboratorio] [int] NULL,
	[cedulaLaboratorista] [nvarchar](10) NULL,
	[cedulaInvitado] [nvarchar](10) NULL,
	[idHora] [nvarchar](2) NULL,
	[estadoPrestamo] [int] NULL,
 CONSTRAINT [PK_Laboratorios_Invitados] PRIMARY KEY CLUSTERED 
(
	[idLabInvitado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Materias]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Materias](
	[idMateria] [int] IDENTITY(1,1) NOT NULL,
	[nombreMateria] [nvarchar](45) NULL,
	[cedulaDocente] [nvarchar](10) NULL,
	[idCarrera] [int] NULL,
	[nivelMateria] [nvarchar](20) NULL,
 CONSTRAINT [PK_Materias] PRIMARY KEY CLUSTERED 
(
	[idMateria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[idRol] [int] IDENTITY(1,1) NOT NULL,
	[nombreRol] [nvarchar](20) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[idRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tipo_Laboratorios]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tipo_Laboratorios](
	[idTipoLaboratorio] [int] IDENTITY(1,1) NOT NULL,
	[nombreTipoLaboratorio] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tipo_Laboratorios] PRIMARY KEY CLUSTERED 
(
	[idTipoLaboratorio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario_Roles]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario_Roles](
	[idUsuario] [int] NULL,
	[idRol] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[nombreCompletoUsuario] [nvarchar](100) NULL,
	[correoUsuario] [nchar](100) NULL,
	[passwordUsuario] [nvarchar](8) NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Carreras] ON 

INSERT [dbo].[Carreras] ([idCarrera], [nombreCarrera]) VALUES (1, N'Ingenieria En Sistemas Computacionales')
INSERT [dbo].[Carreras] ([idCarrera], [nombreCarrera]) VALUES (2, N'Ingeniería Industrial')
INSERT [dbo].[Carreras] ([idCarrera], [nombreCarrera]) VALUES (3, N'Ingeniería Electrónica')
INSERT [dbo].[Carreras] ([idCarrera], [nombreCarrera]) VALUES (4, N'Tecnologías De La Información')
INSERT [dbo].[Carreras] ([idCarrera], [nombreCarrera]) VALUES (5, N'Software')
SET IDENTITY_INSERT [dbo].[Carreras] OFF
GO
SET IDENTITY_INSERT [dbo].[Categorias] ON 

INSERT [dbo].[Categorias] ([idCategoria], [nombreCategoria]) VALUES (1, N'Cables')
INSERT [dbo].[Categorias] ([idCategoria], [nombreCategoria]) VALUES (2, N'Conectores')
INSERT [dbo].[Categorias] ([idCategoria], [nombreCategoria]) VALUES (3, N'Reguladores')
INSERT [dbo].[Categorias] ([idCategoria], [nombreCategoria]) VALUES (4, N'Equipos')
INSERT [dbo].[Categorias] ([idCategoria], [nombreCategoria]) VALUES (5, N'Proyectores')
SET IDENTITY_INSERT [dbo].[Categorias] OFF
GO
INSERT [dbo].[Detalle_Prestamos_Docentes] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (1, 5, 1, N'Ninguna')
INSERT [dbo].[Detalle_Prestamos_Docentes] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (1, 7, 2, N'Ninguna')
INSERT [dbo].[Detalle_Prestamos_Docentes] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (2, 4, 2, N'Ninguna')
INSERT [dbo].[Detalle_Prestamos_Docentes] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (3, 5, 1, N'Ninguna')
INSERT [dbo].[Detalle_Prestamos_Docentes] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (3, 7, 2, N'Ninguna')
INSERT [dbo].[Detalle_Prestamos_Docentes] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (5, 5, 2, N'Ninguna')
INSERT [dbo].[Detalle_Prestamos_Docentes] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (4, 7, 1, N'Ninguna')
GO
INSERT [dbo].[Detalle_Prestamos_Estudiantes] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (4, 5, 1, N'Ninguna')
INSERT [dbo].[Detalle_Prestamos_Estudiantes] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (14, 10, 2, N'')
INSERT [dbo].[Detalle_Prestamos_Estudiantes] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (6, 3, 2, N'Ninguna')
INSERT [dbo].[Detalle_Prestamos_Estudiantes] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (7, 2, 2, N'')
INSERT [dbo].[Detalle_Prestamos_Estudiantes] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (8, 4, 1, N'Ninguna')
INSERT [dbo].[Detalle_Prestamos_Estudiantes] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (9, 4, 2, N'Ninguna')
INSERT [dbo].[Detalle_Prestamos_Estudiantes] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (10, 1, 1, N'Ninguna')
INSERT [dbo].[Detalle_Prestamos_Estudiantes] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (11, 1, 1, N'')
INSERT [dbo].[Detalle_Prestamos_Estudiantes] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (12, 3, 1, N'Ninguna')
INSERT [dbo].[Detalle_Prestamos_Estudiantes] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (13, 5, 1, N'')
INSERT [dbo].[Detalle_Prestamos_Estudiantes] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (13, 3, 2, N'')
GO
INSERT [dbo].[Detalle_Prestamos_Invitados] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (1, 7, 2, N'Ninguna')
INSERT [dbo].[Detalle_Prestamos_Invitados] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (2, 7, 2, N'Ninguna')
INSERT [dbo].[Detalle_Prestamos_Invitados] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (3, 7, 1, N'Ninguna')
INSERT [dbo].[Detalle_Prestamos_Invitados] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (3, 3, 2, N'Ninguna')
INSERT [dbo].[Detalle_Prestamos_Invitados] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (4, 10, 2, N'Ninguna')
INSERT [dbo].[Detalle_Prestamos_Invitados] ([idPrestamo], [cantidadPrestamo], [idInventario], [observacion]) VALUES (5, 3, 2, N'Ninguna')
GO
INSERT [dbo].[Dias] ([idDia], [nombreDia]) VALUES (N'J', N'Jueves')
INSERT [dbo].[Dias] ([idDia], [nombreDia]) VALUES (N'L', N'Lunes')
INSERT [dbo].[Dias] ([idDia], [nombreDia]) VALUES (N'M', N'Martes')
INSERT [dbo].[Dias] ([idDia], [nombreDia]) VALUES (N'V', N'Viernes')
INSERT [dbo].[Dias] ([idDia], [nombreDia]) VALUES (N'X', N'Miercoles')
GO
INSERT [dbo].[Docentes] ([cedulaDocente], [nombreDocente], [apellidoDocente], [telefonoDocente]) VALUES (N'1804271821', N'Jonathan Fernando', N'Tisalema', N'0992761114')
GO
INSERT [dbo].[Estudiantes] ([cedulaEstudiante], [nombreEstudiante], [apellidoEstudiante], [telefonoEstudiante]) VALUES (N'1803015674', N'Franklin Daniel', N'Rivera Pasuña', N'0984315652')
INSERT [dbo].[Estudiantes] ([cedulaEstudiante], [nombreEstudiante], [apellidoEstudiante], [telefonoEstudiante]) VALUES (N'1804271821', N'Giovanni Marcelo', N'Rivera Rodriguez', N'0984315652')
GO
INSERT [dbo].[Horas] ([idHora], [horaInicio], [horaFin]) VALUES (N'1', CAST(N'07:00:00' AS Time), CAST(N'08:00:00' AS Time))
INSERT [dbo].[Horas] ([idHora], [horaInicio], [horaFin]) VALUES (N'10', CAST(N'16:00:00' AS Time), CAST(N'17:00:00' AS Time))
INSERT [dbo].[Horas] ([idHora], [horaInicio], [horaFin]) VALUES (N'11', CAST(N'17:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[Horas] ([idHora], [horaInicio], [horaFin]) VALUES (N'12', CAST(N'18:00:00' AS Time), CAST(N'19:00:00' AS Time))
INSERT [dbo].[Horas] ([idHora], [horaInicio], [horaFin]) VALUES (N'13', CAST(N'19:00:00' AS Time), CAST(N'20:00:00' AS Time))
INSERT [dbo].[Horas] ([idHora], [horaInicio], [horaFin]) VALUES (N'2', CAST(N'08:00:00' AS Time), CAST(N'09:00:00' AS Time))
INSERT [dbo].[Horas] ([idHora], [horaInicio], [horaFin]) VALUES (N'3', CAST(N'09:00:00' AS Time), CAST(N'10:00:00' AS Time))
INSERT [dbo].[Horas] ([idHora], [horaInicio], [horaFin]) VALUES (N'4', CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time))
INSERT [dbo].[Horas] ([idHora], [horaInicio], [horaFin]) VALUES (N'5', CAST(N'11:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[Horas] ([idHora], [horaInicio], [horaFin]) VALUES (N'6', CAST(N'12:00:00' AS Time), CAST(N'13:00:00' AS Time))
INSERT [dbo].[Horas] ([idHora], [horaInicio], [horaFin]) VALUES (N'7', CAST(N'13:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[Horas] ([idHora], [horaInicio], [horaFin]) VALUES (N'8', CAST(N'14:00:00' AS Time), CAST(N'15:00:00' AS Time))
INSERT [dbo].[Horas] ([idHora], [horaInicio], [horaFin]) VALUES (N'9', CAST(N'15:00:00' AS Time), CAST(N'16:00:00' AS Time))
GO
SET IDENTITY_INSERT [dbo].[Inventarios] ON 

INSERT [dbo].[Inventarios] ([idInventario], [nombreInventario], [cantidadInventario], [idCategoria], [lastChange]) VALUES (1, N'Portatil HP i7', 15, 4, CAST(N'2020-08-18T18:23:29.207' AS DateTime))
INSERT [dbo].[Inventarios] ([idInventario], [nombreInventario], [cantidadInventario], [idCategoria], [lastChange]) VALUES (2, N'UTP Cat 6', 11, 1, CAST(N'2020-08-18T18:26:50.770' AS DateTime))
SET IDENTITY_INSERT [dbo].[Inventarios] OFF
GO
INSERT [dbo].[Invitados] ([cedulaInvitado], [nombreInvitado], [apellidoInvitado], [telefonoInvitado]) VALUES (N'1804271821', N'Carlos Patricio', N'Chacón Tello', N'0984424785')
GO
SET IDENTITY_INSERT [dbo].[Laboratorios] ON 

INSERT [dbo].[Laboratorios] ([idLaboratorio], [nombreLaboratorio], [ubicacionLaboratorio], [capacidadLaboratorio], [idTipoLaboratorio], [estadoLaboratorio]) VALUES (2, N'Laboratorio CTT', N'Segundo Piso', 50, 5, 0)
INSERT [dbo].[Laboratorios] ([idLaboratorio], [nombreLaboratorio], [ubicacionLaboratorio], [capacidadLaboratorio], [idTipoLaboratorio], [estadoLaboratorio]) VALUES (3, N'Laboratorio Electrónica', N'Primer Piso', 20, 1, 0)
SET IDENTITY_INSERT [dbo].[Laboratorios] OFF
GO
SET IDENTITY_INSERT [dbo].[Laboratorios_Docentes] ON 

INSERT [dbo].[Laboratorios_Docentes] ([idLabDocente], [fechaPrestamo], [idLaboratorio], [cedulaLaboratorista], [idMateria], [estadoPrestamo]) VALUES (6, CAST(N'2020-08-18T00:00:00.000' AS DateTime), 2, N'1803015674', 1, 1)
INSERT [dbo].[Laboratorios_Docentes] ([idLabDocente], [fechaPrestamo], [idLaboratorio], [cedulaLaboratorista], [idMateria], [estadoPrestamo]) VALUES (7, CAST(N'2020-08-18T00:00:00.000' AS DateTime), 2, N'1803015674', 1, 1)
SET IDENTITY_INSERT [dbo].[Laboratorios_Docentes] OFF
GO
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (3, N'PC01', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (3, N'PC02', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (3, N'PC03', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (3, N'PC04', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (3, N'PC05', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (3, N'PC06', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (3, N'PC07', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (3, N'PC08', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (3, N'PC09', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (3, N'PC10', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (3, N'PC11', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (3, N'PC12', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (3, N'PC13', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (3, N'PC14', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (3, N'PC15', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (3, N'PC16', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (3, N'PC17', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (3, N'PC18', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (3, N'PC19', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (2, N'PC01', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (2, N'PC02', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (2, N'PC03', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (2, N'PC04', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (2, N'PC05', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (2, N'PC06', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (2, N'PC07', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (2, N'PC08', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (2, N'PC09', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (2, N'PC10', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (2, N'PC11', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (2, N'PC12', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (2, N'PC13', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (2, N'PC14', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (2, N'PC15', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (2, N'PC16', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (2, N'PC17', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (2, N'PC18', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
INSERT [dbo].[Laboratorios_Equipos] ([idLaboratorio], [idEquipo], [descripciónEquipos]) VALUES (2, N'PC19', N'Pantalle Led LG, Mouse Genius, Teclado Genius, CPU DELL ')
GO
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'L', N'1', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'L', N'2', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'L', N'3', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'L', N'4', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'L', N'5', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'L', N'6', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'L', N'7', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'L', N'8', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'L', N'9', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'L', N'10', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'L', N'11', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'L', N'12', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'L', N'13', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'M', N'1', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'M', N'2', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'M', N'3', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'M', N'4', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'M', N'5', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'M', N'6', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'M', N'7', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'M', N'8', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'M', N'9', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'M', N'10', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'M', N'11', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'M', N'12', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'M', N'13', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'X', N'1', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'X', N'2', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'X', N'3', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'X', N'4', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'X', N'5', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'X', N'6', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'X', N'7', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'X', N'8', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'X', N'9', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'X', N'10', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'X', N'11', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'X', N'12', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'X', N'13', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'J', N'1', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'J', N'2', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'J', N'3', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'J', N'4', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'J', N'5', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'J', N'6', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'J', N'7', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'J', N'8', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'J', N'9', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'J', N'10', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'J', N'11', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'J', N'12', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'J', N'13', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'V', N'1', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'V', N'2', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'V', N'3', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'V', N'4', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'V', N'5', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'V', N'6', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'V', N'7', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'V', N'8', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'V', N'9', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'V', N'10', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'V', N'11', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'V', N'12', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (3, N'V', N'13', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'L', N'1', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'L', N'2', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'L', N'3', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'L', N'4', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'L', N'5', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'L', N'6', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'L', N'7', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'L', N'8', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'L', N'9', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'L', N'10', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'L', N'11', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'L', N'12', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'L', N'13', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'M', N'1', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'M', N'2', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'M', N'3', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'M', N'4', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'M', N'5', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'M', N'6', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'M', N'7', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'M', N'8', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'M', N'9', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'M', N'10', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'M', N'11', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'M', N'12', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'M', N'13', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'X', N'1', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'X', N'2', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'X', N'3', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'X', N'4', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'X', N'5', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'X', N'6', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'X', N'7', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'X', N'8', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'X', N'9', 1)
GO
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'X', N'10', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'X', N'11', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'X', N'12', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'X', N'13', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'J', N'1', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'J', N'2', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'J', N'3', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'J', N'4', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'J', N'5', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'J', N'6', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'J', N'7', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'J', N'8', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'J', N'9', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'J', N'10', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'J', N'11', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'J', N'12', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'J', N'13', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'V', N'1', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'V', N'2', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'V', N'3', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'V', N'4', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'V', N'5', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'V', N'6', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'V', N'7', 0)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'V', N'8', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'V', N'9', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'V', N'10', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'V', N'11', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'V', N'12', 1)
INSERT [dbo].[Laboratorios_Horas] ([idLaboratorio], [idDia], [idHora], [idMateria]) VALUES (2, N'V', N'13', 1)
GO
INSERT [dbo].[Laboratoristas] ([cedulaLaboratorista], [nombreLaboratorista], [apellidoLaboratorista], [telefonoLaboratorista]) VALUES (N'1803015674', N'Franklin Marcelo', N'Rivera Pasuña', N'0992761114')
GO
SET IDENTITY_INSERT [dbo].[Materias] ON 

INSERT [dbo].[Materias] ([idMateria], [nombreMateria], [cedulaDocente], [idCarrera], [nivelMateria]) VALUES (1, N'Matemáticas', N'1804271821', 2, N'Octavo')
SET IDENTITY_INSERT [dbo].[Materias] OFF
GO
SET IDENTITY_INSERT [dbo].[Prestamos_Docentes] ON 

INSERT [dbo].[Prestamos_Docentes] ([idPrestamo], [cedulaDocente], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (1, N'1804271821', N'1803015674', CAST(N'2020-08-17T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Prestamos_Docentes] ([idPrestamo], [cedulaDocente], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (2, N'1804271821', N'1803015674', CAST(N'2020-08-17T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Prestamos_Docentes] ([idPrestamo], [cedulaDocente], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (3, N'1804271821', N'1803015674', CAST(N'2020-08-17T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Prestamos_Docentes] ([idPrestamo], [cedulaDocente], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (4, N'1804271821', N'1803015674', CAST(N'2020-08-17T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Prestamos_Docentes] ([idPrestamo], [cedulaDocente], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (5, N'1804271821', N'1803015674', CAST(N'2020-08-18T00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Prestamos_Docentes] OFF
GO
SET IDENTITY_INSERT [dbo].[Prestamos_Estudiantes] ON 

INSERT [dbo].[Prestamos_Estudiantes] ([idPrestamo], [cedulaEstudiante], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (4, N'1804271821', N'1803015674', CAST(N'2020-08-14T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Prestamos_Estudiantes] ([idPrestamo], [cedulaEstudiante], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (6, N'1804271821', N'1803015674', CAST(N'2020-08-14T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Prestamos_Estudiantes] ([idPrestamo], [cedulaEstudiante], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (7, N'1804271821', N'1803015674', CAST(N'2020-08-14T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Prestamos_Estudiantes] ([idPrestamo], [cedulaEstudiante], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (8, N'1804271821', N'1803015674', CAST(N'2020-08-14T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Prestamos_Estudiantes] ([idPrestamo], [cedulaEstudiante], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (9, N'1804271821', N'1803015674', CAST(N'2020-08-14T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Prestamos_Estudiantes] ([idPrestamo], [cedulaEstudiante], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (10, N'1804271821', N'1803015674', CAST(N'2020-08-14T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Prestamos_Estudiantes] ([idPrestamo], [cedulaEstudiante], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (11, N'1803015674', N'1803015674', CAST(N'2020-08-14T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Prestamos_Estudiantes] ([idPrestamo], [cedulaEstudiante], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (12, N'1803015674', N'1803015674', CAST(N'2020-08-14T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Prestamos_Estudiantes] ([idPrestamo], [cedulaEstudiante], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (13, N'1804271821', N'1803015674', CAST(N'2020-08-15T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Prestamos_Estudiantes] ([idPrestamo], [cedulaEstudiante], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (14, N'1804271821', N'1803015674', CAST(N'2020-08-18T00:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Prestamos_Estudiantes] OFF
GO
SET IDENTITY_INSERT [dbo].[Prestamos_Invitados] ON 

INSERT [dbo].[Prestamos_Invitados] ([idPrestamo], [cedulaInvitado], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (1, N'1804271821', N'1803015674', CAST(N'2020-08-17T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Prestamos_Invitados] ([idPrestamo], [cedulaInvitado], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (2, N'1804271821', N'1803015674', CAST(N'2020-08-17T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Prestamos_Invitados] ([idPrestamo], [cedulaInvitado], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (3, N'1804271821', N'1803015674', CAST(N'2020-08-17T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Prestamos_Invitados] ([idPrestamo], [cedulaInvitado], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (4, N'1804271821', N'1803015674', CAST(N'2020-08-17T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Prestamos_Invitados] ([idPrestamo], [cedulaInvitado], [cedulaLaboratorista], [fechaPrestamo], [estadoPrestamo]) VALUES (5, N'1804271821', N'1803015674', CAST(N'2020-08-18T00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Prestamos_Invitados] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([idRol], [nombreRol]) VALUES (1, N'Laboratorista')
INSERT [dbo].[Roles] ([idRol], [nombreRol]) VALUES (2, N'Admin')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Tipo_Laboratorios] ON 

INSERT [dbo].[Tipo_Laboratorios] ([idTipoLaboratorio], [nombreTipoLaboratorio]) VALUES (1, N'Electrónica')
INSERT [dbo].[Tipo_Laboratorios] ([idTipoLaboratorio], [nombreTipoLaboratorio]) VALUES (2, N'Industrial')
INSERT [dbo].[Tipo_Laboratorios] ([idTipoLaboratorio], [nombreTipoLaboratorio]) VALUES (3, N'Audiovisuales')
INSERT [dbo].[Tipo_Laboratorios] ([idTipoLaboratorio], [nombreTipoLaboratorio]) VALUES (4, N'Redes')
INSERT [dbo].[Tipo_Laboratorios] ([idTipoLaboratorio], [nombreTipoLaboratorio]) VALUES (5, N'CTT')
INSERT [dbo].[Tipo_Laboratorios] ([idTipoLaboratorio], [nombreTipoLaboratorio]) VALUES (6, N'PLC''s')
SET IDENTITY_INSERT [dbo].[Tipo_Laboratorios] OFF
GO
INSERT [dbo].[Usuario_Roles] ([idUsuario], [idRol]) VALUES (1, 2)
INSERT [dbo].[Usuario_Roles] ([idUsuario], [idRol]) VALUES (2, 1)
INSERT [dbo].[Usuario_Roles] ([idUsuario], [idRol]) VALUES (7, 1)
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([idUsuario], [nombreCompletoUsuario], [correoUsuario], [passwordUsuario]) VALUES (1, N'Jessica Moreta', N'jesdanis2103@gmail.com                                                                              ', N'123456')
INSERT [dbo].[Usuarios] ([idUsuario], [nombreCompletoUsuario], [correoUsuario], [passwordUsuario]) VALUES (2, N'Giovanni Rivera', N'giovannirivera1996@gmail.com                                                                        ', N'123456')
INSERT [dbo].[Usuarios] ([idUsuario], [nombreCompletoUsuario], [correoUsuario], [passwordUsuario]) VALUES (7, N'Elizabeth Tisalema', N'eliza-ale18@hotmail.com                                                                             ', N'123456')
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__2CB1748F6DF662C0]    Script Date: 19/08/2020 13:46:24 ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[correoUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Inventarios] ADD  CONSTRAINT [DF_Inventarios_lastChange]  DEFAULT (getdate()) FOR [lastChange]
GO
ALTER TABLE [dbo].[Detalle_Prestamos_Docentes]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_Prestamos_Docentes_Inventarios] FOREIGN KEY([idInventario])
REFERENCES [dbo].[Inventarios] ([idInventario])
GO
ALTER TABLE [dbo].[Detalle_Prestamos_Docentes] CHECK CONSTRAINT [FK_Detalle_Prestamos_Docentes_Inventarios]
GO
ALTER TABLE [dbo].[Detalle_Prestamos_Docentes]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_Prestamos_Docentes_Prestamos_Docentes] FOREIGN KEY([idPrestamo])
REFERENCES [dbo].[Prestamos_Docentes] ([idPrestamo])
GO
ALTER TABLE [dbo].[Detalle_Prestamos_Docentes] CHECK CONSTRAINT [FK_Detalle_Prestamos_Docentes_Prestamos_Docentes]
GO
ALTER TABLE [dbo].[Detalle_Prestamos_Estudiantes]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_Prestamos_Estudiantes_Inventarios] FOREIGN KEY([idInventario])
REFERENCES [dbo].[Inventarios] ([idInventario])
GO
ALTER TABLE [dbo].[Detalle_Prestamos_Estudiantes] CHECK CONSTRAINT [FK_Detalle_Prestamos_Estudiantes_Inventarios]
GO
ALTER TABLE [dbo].[Detalle_Prestamos_Estudiantes]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_Prestamos_Estudiantes_Prestamos_Estudiantes] FOREIGN KEY([idPrestamo])
REFERENCES [dbo].[Prestamos_Estudiantes] ([idPrestamo])
GO
ALTER TABLE [dbo].[Detalle_Prestamos_Estudiantes] CHECK CONSTRAINT [FK_Detalle_Prestamos_Estudiantes_Prestamos_Estudiantes]
GO
ALTER TABLE [dbo].[Detalle_Prestamos_Invitados]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_Prestamos_Invitados_Inventarios] FOREIGN KEY([idInventario])
REFERENCES [dbo].[Inventarios] ([idInventario])
GO
ALTER TABLE [dbo].[Detalle_Prestamos_Invitados] CHECK CONSTRAINT [FK_Detalle_Prestamos_Invitados_Inventarios]
GO
ALTER TABLE [dbo].[Detalle_Prestamos_Invitados]  WITH CHECK ADD  CONSTRAINT [FK_Detalle_Prestamos_Invitados_Prestamos_Invitados] FOREIGN KEY([idPrestamo])
REFERENCES [dbo].[Prestamos_Invitados] ([idPrestamo])
GO
ALTER TABLE [dbo].[Detalle_Prestamos_Invitados] CHECK CONSTRAINT [FK_Detalle_Prestamos_Invitados_Prestamos_Invitados]
GO
ALTER TABLE [dbo].[Inventarios]  WITH CHECK ADD  CONSTRAINT [FK_Inventarios_Categorias1] FOREIGN KEY([idCategoria])
REFERENCES [dbo].[Categorias] ([idCategoria])
GO
ALTER TABLE [dbo].[Inventarios] CHECK CONSTRAINT [FK_Inventarios_Categorias1]
GO
ALTER TABLE [dbo].[Laboratorios]  WITH CHECK ADD  CONSTRAINT [FK_Laboratorios_Tipo_Laboratorios] FOREIGN KEY([idTipoLaboratorio])
REFERENCES [dbo].[Tipo_Laboratorios] ([idTipoLaboratorio])
GO
ALTER TABLE [dbo].[Laboratorios] CHECK CONSTRAINT [FK_Laboratorios_Tipo_Laboratorios]
GO
ALTER TABLE [dbo].[Laboratorios_Docentes]  WITH CHECK ADD  CONSTRAINT [FK_Laboratorios_Docentes_Laboratorios] FOREIGN KEY([idLaboratorio])
REFERENCES [dbo].[Laboratorios] ([idLaboratorio])
GO
ALTER TABLE [dbo].[Laboratorios_Docentes] CHECK CONSTRAINT [FK_Laboratorios_Docentes_Laboratorios]
GO
ALTER TABLE [dbo].[Laboratorios_Docentes]  WITH CHECK ADD  CONSTRAINT [FK_Laboratorios_Docentes_Laboratoristas] FOREIGN KEY([cedulaLaboratorista])
REFERENCES [dbo].[Laboratoristas] ([cedulaLaboratorista])
GO
ALTER TABLE [dbo].[Laboratorios_Docentes] CHECK CONSTRAINT [FK_Laboratorios_Docentes_Laboratoristas]
GO
ALTER TABLE [dbo].[Laboratorios_Docentes]  WITH CHECK ADD  CONSTRAINT [FK_Laboratorios_Docentes_Materias] FOREIGN KEY([idMateria])
REFERENCES [dbo].[Materias] ([idMateria])
GO
ALTER TABLE [dbo].[Laboratorios_Docentes] CHECK CONSTRAINT [FK_Laboratorios_Docentes_Materias]
GO
ALTER TABLE [dbo].[Laboratorios_Equipos]  WITH CHECK ADD  CONSTRAINT [FK_Laboratorios_Equipos_Laboratorios] FOREIGN KEY([idLaboratorio])
REFERENCES [dbo].[Laboratorios] ([idLaboratorio])
GO
ALTER TABLE [dbo].[Laboratorios_Equipos] CHECK CONSTRAINT [FK_Laboratorios_Equipos_Laboratorios]
GO
ALTER TABLE [dbo].[Laboratorios_Horas]  WITH CHECK ADD  CONSTRAINT [FK_Laboratorios_Horas_Dias] FOREIGN KEY([idDia])
REFERENCES [dbo].[Dias] ([idDia])
GO
ALTER TABLE [dbo].[Laboratorios_Horas] CHECK CONSTRAINT [FK_Laboratorios_Horas_Dias]
GO
ALTER TABLE [dbo].[Laboratorios_Horas]  WITH CHECK ADD  CONSTRAINT [FK_Laboratorios_Horas_Horas] FOREIGN KEY([idHora])
REFERENCES [dbo].[Horas] ([idHora])
GO
ALTER TABLE [dbo].[Laboratorios_Horas] CHECK CONSTRAINT [FK_Laboratorios_Horas_Horas]
GO
ALTER TABLE [dbo].[Laboratorios_Horas]  WITH CHECK ADD  CONSTRAINT [FK_Laboratorios_Horas_Laboratorios] FOREIGN KEY([idLaboratorio])
REFERENCES [dbo].[Laboratorios] ([idLaboratorio])
GO
ALTER TABLE [dbo].[Laboratorios_Horas] CHECK CONSTRAINT [FK_Laboratorios_Horas_Laboratorios]
GO
ALTER TABLE [dbo].[Laboratorios_Invitados]  WITH CHECK ADD  CONSTRAINT [FK_Laboratorios_Invitados_Horas] FOREIGN KEY([idHora])
REFERENCES [dbo].[Horas] ([idHora])
GO
ALTER TABLE [dbo].[Laboratorios_Invitados] CHECK CONSTRAINT [FK_Laboratorios_Invitados_Horas]
GO
ALTER TABLE [dbo].[Laboratorios_Invitados]  WITH CHECK ADD  CONSTRAINT [FK_Laboratorios_Invitados_Invitados] FOREIGN KEY([cedulaInvitado])
REFERENCES [dbo].[Invitados] ([cedulaInvitado])
GO
ALTER TABLE [dbo].[Laboratorios_Invitados] CHECK CONSTRAINT [FK_Laboratorios_Invitados_Invitados]
GO
ALTER TABLE [dbo].[Laboratorios_Invitados]  WITH CHECK ADD  CONSTRAINT [FK_Laboratorios_Invitados_Laboratorios] FOREIGN KEY([idLaboratorio])
REFERENCES [dbo].[Laboratorios] ([idLaboratorio])
GO
ALTER TABLE [dbo].[Laboratorios_Invitados] CHECK CONSTRAINT [FK_Laboratorios_Invitados_Laboratorios]
GO
ALTER TABLE [dbo].[Laboratorios_Invitados]  WITH CHECK ADD  CONSTRAINT [FK_Laboratorios_Invitados_Laboratoristas] FOREIGN KEY([cedulaLaboratorista])
REFERENCES [dbo].[Laboratoristas] ([cedulaLaboratorista])
GO
ALTER TABLE [dbo].[Laboratorios_Invitados] CHECK CONSTRAINT [FK_Laboratorios_Invitados_Laboratoristas]
GO
ALTER TABLE [dbo].[Materias]  WITH CHECK ADD  CONSTRAINT [FK_Materias_Carreras] FOREIGN KEY([idCarrera])
REFERENCES [dbo].[Carreras] ([idCarrera])
GO
ALTER TABLE [dbo].[Materias] CHECK CONSTRAINT [FK_Materias_Carreras]
GO
ALTER TABLE [dbo].[Materias]  WITH CHECK ADD  CONSTRAINT [FK_Materias_Docentes] FOREIGN KEY([cedulaDocente])
REFERENCES [dbo].[Docentes] ([cedulaDocente])
GO
ALTER TABLE [dbo].[Materias] CHECK CONSTRAINT [FK_Materias_Docentes]
GO
ALTER TABLE [dbo].[Prestamos_Docentes]  WITH CHECK ADD  CONSTRAINT [FK_Prestamos_Docentes_Docentes] FOREIGN KEY([cedulaDocente])
REFERENCES [dbo].[Docentes] ([cedulaDocente])
GO
ALTER TABLE [dbo].[Prestamos_Docentes] CHECK CONSTRAINT [FK_Prestamos_Docentes_Docentes]
GO
ALTER TABLE [dbo].[Prestamos_Docentes]  WITH CHECK ADD  CONSTRAINT [FK_Prestamos_Docentes_Laboratoristas] FOREIGN KEY([cedulaLaboratorista])
REFERENCES [dbo].[Laboratoristas] ([cedulaLaboratorista])
GO
ALTER TABLE [dbo].[Prestamos_Docentes] CHECK CONSTRAINT [FK_Prestamos_Docentes_Laboratoristas]
GO
ALTER TABLE [dbo].[Prestamos_Estudiantes]  WITH CHECK ADD  CONSTRAINT [FK_Prestamos_Estudiantes_Estudiantes] FOREIGN KEY([cedulaEstudiante])
REFERENCES [dbo].[Estudiantes] ([cedulaEstudiante])
GO
ALTER TABLE [dbo].[Prestamos_Estudiantes] CHECK CONSTRAINT [FK_Prestamos_Estudiantes_Estudiantes]
GO
ALTER TABLE [dbo].[Prestamos_Estudiantes]  WITH CHECK ADD  CONSTRAINT [FK_Prestamos_Estudiantes_Laboratoristas] FOREIGN KEY([cedulaLaboratorista])
REFERENCES [dbo].[Laboratoristas] ([cedulaLaboratorista])
GO
ALTER TABLE [dbo].[Prestamos_Estudiantes] CHECK CONSTRAINT [FK_Prestamos_Estudiantes_Laboratoristas]
GO
ALTER TABLE [dbo].[Prestamos_Invitados]  WITH CHECK ADD  CONSTRAINT [FK_Prestamos_Invitados_Invitados] FOREIGN KEY([cedulaInvitado])
REFERENCES [dbo].[Invitados] ([cedulaInvitado])
GO
ALTER TABLE [dbo].[Prestamos_Invitados] CHECK CONSTRAINT [FK_Prestamos_Invitados_Invitados]
GO
ALTER TABLE [dbo].[Prestamos_Invitados]  WITH CHECK ADD  CONSTRAINT [FK_Prestamos_Invitados_Laboratoristas] FOREIGN KEY([cedulaLaboratorista])
REFERENCES [dbo].[Laboratoristas] ([cedulaLaboratorista])
GO
ALTER TABLE [dbo].[Prestamos_Invitados] CHECK CONSTRAINT [FK_Prestamos_Invitados_Laboratoristas]
GO
ALTER TABLE [dbo].[Usuario_Roles]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Roles_Roles] FOREIGN KEY([idRol])
REFERENCES [dbo].[Roles] ([idRol])
GO
ALTER TABLE [dbo].[Usuario_Roles] CHECK CONSTRAINT [FK_Usuario_Roles_Roles]
GO
ALTER TABLE [dbo].[Usuario_Roles]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Roles_Usuarios] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([idUsuario])
GO
ALTER TABLE [dbo].[Usuario_Roles] CHECK CONSTRAINT [FK_Usuario_Roles_Usuarios]
GO
/****** Object:  Trigger [dbo].[trgAumentarCantidadD]    Script Date: 19/08/2020 13:46:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trgAumentarCantidadD] ON [dbo].[Detalle_Prestamos_Docentes]
AFTER UPDATE 
AS
 DECLARE @cantPedido int
 DECLARE @cantActual int
 DECLARE @cantModificada int
 DECLARE @idInventario int

 SET @cantPedido =(
  SELECT  I.cantidadPrestamo
  FROM inserted I)

  SET @idInventario =(
  SELECT  I.idInventario
  FROM inserted I)

  SET @cantActual=(
  SELECT Inventarios.cantidadInventario
  FROM Inventarios 
  INNER JOIN inserted I ON I.idInventario=Inventarios.idInventario)

  SET @cantModificada=@cantActual+@cantPedido

  UPDATE Inventarios
  SET cantidadInventario=@cantModificada
  WHERE idInventario=@idInventario
GO
ALTER TABLE [dbo].[Detalle_Prestamos_Docentes] ENABLE TRIGGER [trgAumentarCantidadD]
GO
/****** Object:  Trigger [dbo].[trgDisminuirCantidadD]    Script Date: 19/08/2020 13:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trgDisminuirCantidadD] ON [dbo].[Detalle_Prestamos_Docentes]
AFTER INSERT 
AS
 DECLARE @cantPedido int
 DECLARE @cantActual int
 DECLARE @cantModificada int
 DECLARE @idInventario int

 SET @cantPedido =(
  SELECT  I.cantidadPrestamo
  FROM inserted I)

  SET @idInventario =(
  SELECT  I.idInventario
  FROM inserted I)

  SET @cantActual=(
  SELECT Inventarios.cantidadInventario
  FROM Inventarios 
  INNER JOIN inserted I ON I.idInventario=Inventarios.idInventario)

  SET @cantModificada=@cantActual-@cantPedido

  UPDATE Inventarios
  SET cantidadInventario=@cantModificada
  WHERE idInventario=@idInventario
GO
ALTER TABLE [dbo].[Detalle_Prestamos_Docentes] ENABLE TRIGGER [trgDisminuirCantidadD]
GO
/****** Object:  Trigger [dbo].[trgAumentarCantidad]    Script Date: 19/08/2020 13:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trgAumentarCantidad] ON [dbo].[Detalle_Prestamos_Estudiantes]
AFTER UPDATE 
AS
 DECLARE @cantPedido int
 DECLARE @cantActual int
 DECLARE @cantModificada int
 DECLARE @idInventario int

 SET @cantPedido =(
  SELECT  I.cantidadPrestamo
  FROM inserted I)

  SET @idInventario =(
  SELECT  I.idInventario
  FROM inserted I)

  SET @cantActual=(
  SELECT Inventarios.cantidadInventario
  FROM Inventarios 
  INNER JOIN inserted I ON I.idInventario=Inventarios.idInventario)

  SET @cantModificada=@cantActual+@cantPedido

  UPDATE Inventarios
  SET cantidadInventario=@cantModificada
  WHERE idInventario=@idInventario
GO
ALTER TABLE [dbo].[Detalle_Prestamos_Estudiantes] ENABLE TRIGGER [trgAumentarCantidad]
GO
/****** Object:  Trigger [dbo].[trgDisminuirCantidad]    Script Date: 19/08/2020 13:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trgDisminuirCantidad] ON [dbo].[Detalle_Prestamos_Estudiantes]
AFTER INSERT 
AS
 DECLARE @cantPedido int
 DECLARE @cantActual int
 DECLARE @cantModificada int
 DECLARE @idInventario int

 SET @cantPedido =(
  SELECT  I.cantidadPrestamo
  FROM inserted I)

  SET @idInventario =(
  SELECT  I.idInventario
  FROM inserted I)

  SET @cantActual=(
  SELECT Inventarios.cantidadInventario
  FROM Inventarios 
  INNER JOIN inserted I ON I.idInventario=Inventarios.idInventario)

  SET @cantModificada=@cantActual-@cantPedido

  UPDATE Inventarios
  SET cantidadInventario=@cantModificada
  WHERE idInventario=@idInventario
GO
ALTER TABLE [dbo].[Detalle_Prestamos_Estudiantes] ENABLE TRIGGER [trgDisminuirCantidad]
GO
/****** Object:  Trigger [dbo].[trgAumentarCantidadI]    Script Date: 19/08/2020 13:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trgAumentarCantidadI] ON [dbo].[Detalle_Prestamos_Invitados]
AFTER UPDATE 
AS
 DECLARE @cantPedido int
 DECLARE @cantActual int
 DECLARE @cantModificada int
 DECLARE @idInventario int

 SET @cantPedido =(
  SELECT  I.cantidadPrestamo
  FROM inserted I)

  SET @idInventario =(
  SELECT  I.idInventario
  FROM inserted I)

  SET @cantActual=(
  SELECT Inventarios.cantidadInventario
  FROM Inventarios 
  INNER JOIN inserted I ON I.idInventario=Inventarios.idInventario)

  SET @cantModificada=@cantActual+@cantPedido

  UPDATE Inventarios
  SET cantidadInventario=@cantModificada
  WHERE idInventario=@idInventario
GO
ALTER TABLE [dbo].[Detalle_Prestamos_Invitados] ENABLE TRIGGER [trgAumentarCantidadI]
GO
/****** Object:  Trigger [dbo].[trgDisminuirCantidadI]    Script Date: 19/08/2020 13:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trgDisminuirCantidadI] ON [dbo].[Detalle_Prestamos_Invitados]
AFTER INSERT 
AS
 DECLARE @cantPedido int
 DECLARE @cantActual int
 DECLARE @cantModificada int
 DECLARE @idInventario int

 SET @cantPedido =(
  SELECT  I.cantidadPrestamo
  FROM inserted I)

  SET @idInventario =(
  SELECT  I.idInventario
  FROM inserted I)

  SET @cantActual=(
  SELECT Inventarios.cantidadInventario
  FROM Inventarios 
  INNER JOIN inserted I ON I.idInventario=Inventarios.idInventario)

  SET @cantModificada=@cantActual-@cantPedido

  UPDATE Inventarios
  SET cantidadInventario=@cantModificada
  WHERE idInventario=@idInventario
GO
ALTER TABLE [dbo].[Detalle_Prestamos_Invitados] ENABLE TRIGGER [trgDisminuirCantidadI]
GO
/****** Object:  Trigger [dbo].[trgLastChangeInventarios]    Script Date: 19/08/2020 13:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trgLastChangeInventarios] ON [dbo].[Inventarios]
AFTER UPDATE 
AS
  UPDATE f set lastChange=CURRENT_TIMESTAMP 
  FROM 
  Inventarios AS f 
  INNER JOIN inserted 
  AS i 
  ON f.idInventario = i.idInventario;
GO
ALTER TABLE [dbo].[Inventarios] ENABLE TRIGGER [trgLastChangeInventarios]
GO
/****** Object:  Trigger [dbo].[trgDisponibleLaboratorio]    Script Date: 19/08/2020 13:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trgDisponibleLaboratorio] ON [dbo].[Laboratorios_Docentes]
AFTER UPDATE 
AS
 DECLARE @idLaboratorio int

 SET @idLaboratorio =(
  SELECT  I.idLaboratorio
  FROM inserted I)
  
  UPDATE Laboratorios
  SET estadoLaboratorio='0'
  WHERE idLaboratorio=@idLaboratorio
GO
ALTER TABLE [dbo].[Laboratorios_Docentes] ENABLE TRIGGER [trgDisponibleLaboratorio]
GO
/****** Object:  Trigger [dbo].[trgOcupadoLaboratorio]    Script Date: 19/08/2020 13:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trgOcupadoLaboratorio] ON [dbo].[Laboratorios_Docentes]
AFTER INSERT 
AS
 DECLARE @idLaboratorio int

 SET @idLaboratorio =(
  SELECT  I.idLaboratorio
  FROM inserted I)
  
  UPDATE Laboratorios
  SET estadoLaboratorio='1'
  WHERE idLaboratorio=@idLaboratorio
GO
ALTER TABLE [dbo].[Laboratorios_Docentes] ENABLE TRIGGER [trgOcupadoLaboratorio]
GO
/****** Object:  Trigger [dbo].[trgAgregarRol]    Script Date: 19/08/2020 13:46:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trgAgregarRol] ON [dbo].[Usuarios]
AFTER INSERT
AS
 DECLARE @idUsuario int
 
 SET @idUsuario=(
  SELECT  I.idUsuario
  FROM inserted I)
  
INSERT Usuario_Roles
VALUES(@idUsuario,1)
GO
ALTER TABLE [dbo].[Usuarios] ENABLE TRIGGER [trgAgregarRol]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -120
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PE"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 275
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "E"
            Begin Extent = 
               Top = 175
               Left = 48
               Bottom = 338
               Right = 268
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "L"
            Begin Extent = 
               Top = 343
               Left = 48
               Bottom = 506
               Right = 287
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vstDatosPrestamoEstudiante'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vstDatosPrestamoEstudiante'
GO
USE [master]
GO
ALTER DATABASE [Laboratorios] SET  READ_WRITE 
GO
