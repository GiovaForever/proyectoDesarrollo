<%@ Page Title="" Language="C#" MasterPageFile="~/Pagina_Principal.Master" AutoEventWireup="true" CodeBehind="Gestion_Invitados.aspx.cs" Inherits="Proyecto_Final.Gestion_Invitados" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/bootstrap.min.css">
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="DataTable/jquery.dataTables.min.css" />
    <script src="DataTable/jquery.dataTables.min.js"></script>
    <script src="Controladores/ControladoresInvitados.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row container">
        <div class="col-sm-5">
            <h1 style="margin-top: 7px; margin-bottom: 7px;">Gestión Invitados</h1>
            <input type="hidden" id="orig_id" />
            <div class="form-group">
                <label class="control-label">Cédula</label>
                <input type="text" id="txtCedula" name="txtCedula" class="form-control" maxlength="10" onkeypress="isNumber(event)" />
            </div>
            <div class="form-group">
                <label class="control-label">Nombre</label>
                <input type="text" id="txtNombre" name="txtNombre" class="form-control" maxlength="45" onkeypress="isLetter(event)" />
            </div>
            <div class="form-group">
                <label class="control-label">Apellido</label>
                <input type="text" id="txtApellido" name="txtApellido" class="form-control" maxlength="45" onkeypress="isLetter(event)" />
            </div>
            <div class="form-group">
                <label class="control-label">Teléfono</label>
                <input type="text" id="txtTelefono" name="txtTelefono" class="form-control" maxlength="10" onkeypress="isNumber(event)" />
            </div>
            <div class="form-group">
                <input type="button" value="Guardar" class="btn btn-primary" id="btnGuardar" />
                <input type="button" value="Eliminar" class="btn btn-danger" id="btnEliminar" />
                <input type="button" value="Limpiar" class="btn btn-warning" id="btnLimpiar" />
            </div>
        </div>
        <div class="col-sm-7" style="margin-top: 7px;">
            <table id="tbl_Invitados" class="table table-bordered  table-striped bg-white" style="width: 100%">
                <thead class="thead-dark">
                    <tr>
                        <th>Cédula</th>
                        <th>Nombres</th>
                        <th>Apellidos</th>
                        <th>Teléfono</th>
                    </tr>
                </thead>
                <tbody class="tbl_body_table">
                    <!-- Cargar De Datos Por Ajax -->
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
