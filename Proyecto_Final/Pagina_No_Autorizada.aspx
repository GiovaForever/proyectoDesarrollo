<%@ Page Title="" Language="C#" MasterPageFile="~/Pagina_Principal.Master" AutoEventWireup="true" CodeBehind="Pagina_No_Autorizada.aspx.cs" Inherits="Proyecto_Final.Pagina_No_Autorizada" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/bootstrap.min.css">
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <style>
        .center {
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
    </style>
    <script type="text/javascript">
        var usuarioRol = localStorage.getItem("usuario");
        console.log(usuarioRol);
        $(document).ready(function () {
            var usuarioRol = localStorage.getItem("usuario");
            console.log(usuarioRol);
            if (usuarioRol !== "Invitado") {
                $("#btnSesion").val("Cerrar Sesión");
            }
            $("#btnSesion").click(function () {
                url = "Login_Sistema.aspx";
                $(location).attr('href', url);
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container my-4">
        <img src="Imagenes/imagen_no_autorizado.png" alt="No Autorizado" style="width: 20%; height: 20%" class="center" />
    </div>
    <div class="container col-md-12 text-center">
        <h1 style="color: red" class="my-3">ACCESO NO AUTORIZADO.</h1>
        <h5 style="color: blue" class="my-3">Está Página Requiere De Permisos.</h5>
        <a href="Login_Sistema.aspx" class="btn  btn-secondary my-3">Iniciar Sesion</a>
    </div>
</asp:Content>
