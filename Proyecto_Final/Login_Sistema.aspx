<%@ Page Title="" Language="C#" MasterPageFile="~/Pagina_Principal.Master" AutoEventWireup="true" CodeBehind="Login_Sistema.aspx.cs" Inherits="Proyecto_Final.Login_Sistema" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/bootstrap.min.css">
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <!-- Los iconos tipo Solid de Fontawesome-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/solid.css">
    <script src="https://use.fontawesome.com/releases/v5.0.7/js/all.js"></script>

    <!-- Nuestro css-->
    <link rel="stylesheet" type="text/css" href="Estilos/index.css">
    <script src="Controladores/Controladores_Login.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="modal-dialog text-center">
        <div class="col-sm-12 main-section">
            <div class="modal-content">
                <div class="col-12 user-img">
                    <img src="Imagenes/user.png" />
                </div>
                <div class="col-12">
                    <div class="form-group" id="user-group">
                        <input type="text" class="form-control" placeholder="Nombre de usuario" name="username" id="txtCorreo" />
                    </div>
                    <div class="form-group" id="contrasena-group">
                        <input type="password" class="form-control" placeholder="Contrasena" name="password" id="txtContrasenia" />
                    </div>
                    <button type="button" class="btn btn-primary" onclick="return false;" id="btnIngresar"><i class="fas fa-sign-in-alt"></i> Ingresar </button>
                </div>
                <div class="col-12 forgot">
                    <p>¿No tienes una cuenta? <a class="link" href="Registro_Usuario.aspx" style="color:blue">Registrate </a></p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
