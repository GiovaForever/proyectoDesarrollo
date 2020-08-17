<%@ Page Title="" Language="C#" MasterPageFile="~/Pagina_Principal.Master" AutoEventWireup="true" CodeBehind="Gestion_Inventarios.aspx.cs" Inherits="Proyecto_Final.Gestion_Inventarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/bootstrap.min.css">
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="DataTable/jquery.dataTables.min.css" />
    <script src="DataTable/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous" />
    <script src="Controladores/ControladoresInventarios.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row container my-3">
        <h1 style="margin-top: 7px; margin-bottom: 7px;">Gestión Inventarios</h1>
    </div>
    <div class="row container">
        <div class="col-sm-5">
            <input type="hidden" id="orig_id" />
            <div class="form-group">
                <label class="control-label">Nombre</label>
                <input type="text" id="txtNombre" name="txtNombre" class="form-control" maxlength="45" onkeypress="isLetter(event)" placeholder="Name" />
            </div>
            <div class="form-group">
                <label class="control-label">Categoria</label>
                <select name="cmbCategoria" id="cmbCategoria" class="form-control dropdown">
                    <option value="">---Seleccione---</option>
                </select>
            </div>
            <div class="form-group">
                <label class="control-label">Cantidad</label>
                <input type="text" id="txtCantidad" name="txtCantidad" class="form-control" maxlength="2" onkeypress="isNumber(event)" placeholder="0" />
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
                <input type="text" id="txtId" name="txtId" style="opacity: 0; width: 5px" />
            </div>
        </div>
        <div class="col-sm-7" style="margin-top: 7px;">
            <table id="tbl_Inventarios" class="table table-bordered  table-striped bg-white" style="width: 100%">
                <thead class="thead-dark">
                    <tr>
                        <th>Id</th>
                        <th>Nombre</th>
                        <th>Cantidad</th>
                        <th>idCategoria</th>
                        <th>Categoria</th>
                    </tr>
                </thead>
                <tbody class="tbl_body_table">
                    <!-- Cargar De Datos Por Ajax -->
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
