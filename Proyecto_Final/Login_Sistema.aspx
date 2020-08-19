<%@ Page Title="" Language="C#" MasterPageFile="~/Pagina_Principal.Master" AutoEventWireup="true" CodeBehind="Login_Sistema.aspx.cs" Inherits="Proyecto_Final.Login_Sistema" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/bootstrap.min.css">
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
    <link rel="stylesheet" href="Estilos/Estilos_Login.css">
    <script src="Controladores/Controladores_Login.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="formulario">
        <h1>Ingreso al Sistema</h1>
        <div class="contenedor">
            <div class="input-contenedor">
                <i class="fas fa-envelope icon"></i>
                <input type="text" placeholder="Correo Electronico" class="estiloText" id="txtCorreo">
            </div>
            <div class="input-contenedor">
                <i class="fas fa-key icon"></i>
                <input type="password" placeholder="Contraseña" class="estiloText" id="txtContrasenia">
            </div>
            <input type="button" value="Login" class="button my-3" id="btnIngresar" onclick="return false;">
            <p>¿No tienes una cuenta? <a class="link" href="Registro_Usuario.aspx">Registrate </a></p>
        </div>
    </div>
</asp:Content>
