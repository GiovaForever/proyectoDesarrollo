<%@ Page Title="" Language="C#" MasterPageFile="~/Pagina_Principal.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Proyecto_Final.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/bootstrap.min.css">
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var usuarioRol = localStorage.getItem("usuario");
            console.log(usuarioRol);
            if (usuarioRol !== "Invitado") {
                $("#btnSesion").val("Cerrar Sesión");
                $("#btnSesion").removeClass();
                $("#btnSesion").addClass("btn btn-danger");
            }
            $("#btnSesion").click(function () {
                url = "Login_Sistema.aspx";
                $(location).attr('href', url);
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Página De Inicio</h1>
</asp:Content>
