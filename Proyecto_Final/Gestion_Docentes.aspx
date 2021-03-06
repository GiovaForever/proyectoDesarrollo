﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Pagina_Principal.Master" AutoEventWireup="true" CodeBehind="Gestion_Docentes.aspx.cs" Inherits="Proyecto_Final.Gestion_Docentes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/bootstrap.min.css">
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="DataTable/jquery.dataTables.min.css" />
    <script src="DataTable/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous" />
    <script src="Controladores/ControladoresDocentes.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row container my-3">
        <h1 style="margin-top: 7px; margin-bottom: 7px;">Gestión Docentes</h1>
    </div>
    <div class="row container">
        <div class="col-sm-5">
            <input type="hidden" id="orig_id" />
            <div class="form-group">
                <label class="control-label">Cédula</label>
                <input type="text" id="txtCedula" name="txtCedula" class="form-control" maxlength="10" onkeypress="isNumber(event)" placeholder="Card ID" />
            </div>
            <div class="form-group">
                <label class="control-label">Nombre</label>
                <input type="text" id="txtNombre" name="txtNombre" class="form-control" maxlength="45" onkeypress="isLetter(event)" placeholder="Name" />
            </div>
            <div class="form-group">
                <label class="control-label">Apellido</label>
                <input type="text" id="txtApellido" name="txtApellido" class="form-control" maxlength="45" onkeypress="isLetter(event)" placeholder="Last Name" />
            </div>
            <div class="form-group">
                <label class="control-label">Teléfono</label>
                <input type="text" id="txtTelefono" name="txtTelefono" class="form-control" maxlength="10" onkeypress="isNumber(event)" placeholder="Phone" />
            </div>
            <div class="form-group">
                <button type="button" class="btn btn-primary" id="btnGuardar" onclick="return false">
                    <span class="fas fa-save mx-2"></span>Guardar
                </button>
                <button type="button" class="btn btn-danger" id="btnEliminar" onclick="return false">
                    <span class="fas fa-trash-alt mx-2"></span>Eliminar
                </button>
                <button type="button" class="btn btn-warning" id="btnLimpiar" onclick="return false">
                    <span class="fas fa-eraser mx-2"></span>Limpiar
                </button>
            </div>
        </div>
        <div class="col-sm-7" style="margin-top: 7px;">
            <table id="tbl_Docentes" class="table table-bordered  table-striped bg-white" style="width: 100%">
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
