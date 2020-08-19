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
            }
            $("#btnSesion").click(function () {
                url = "Login_Sistema.aspx";
                $(location).attr('href', url);
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <center></center>
    <h1 class="my-4" style="width: 100%; text-align: center; color: blue;">Página De Inicio</h1>
    </center>
    <%-------%>
    <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img class="d-block w-100" src="Imagenes/facultad3.png" alt="First slide" height="300px">
            </div>
            <div class="carousel-item">
                <img class="d-block w-100" src="Imagenes/facultad2.jpg" alt="Second slide" height="300px">
            </div>
            <div class="carousel-item">
                <img class="d-block w-100" src="Imagenes/fac.jpg" alt="Third slide" height="300px">
            </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
    <%-------%>
    <div class="form">
        <h1 class="my-3" style="width: 100%; text-align: center; color: blue;">Control de Laboratorios</h1>
        <h6 class="my-3" style="width: 100%; text-align: center">Página Web para facilitar el control de prestamos en la Facultad de Ingeniería en Sistemas, Electrónica e Industrial</h6>
    </div>
</asp:Content>
