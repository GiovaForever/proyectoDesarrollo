<%@ Page Title="" Language="C#" MasterPageFile="~/Pagina_Principal.Master" AutoEventWireup="true" CodeBehind="Gestion_Materias.aspx.cs" Inherits="Proyecto_Final.Gestion_Materias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/bootstrap.min.css">
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="DataTable/jquery.dataTables.min.css" />
    <script src="DataTable/jquery.dataTables.min.js"></script>
    <script src="Controladores/ControladoresMaterias.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row container">
        <div class="col-sm-5">
            <h1 style="margin-top: 7px; margin-bottom: 7px;">Gestión Materias</h1>
            <input type="hidden" id="orig_id" />
            <div class="form-group">
                <label class="control-label">Nombre</label>
                <input type="text" id="txtNombre" name="txtNombre" class="form-control" maxlength="45" onkeypress="isLetter(event)" />
            </div>
            <div class="form-group">
                <label class="control-label">Nivel</label>
                <input type="text" id="txtNivel" name="txtNivel" class="form-control" maxlength="10" onkeypress="isLetter(event)" />
            </div>
            <div class="form-group">
                <label class="control-label">Carrera</label>
                <select name="cmbCarrera" id="cmbCarrera" class="form-control dropdown">
                    <option value="">---Seleccione---</option>
                </select>
            </div>
            <div class="form-group">
                <label class="control-label">Docente</label>
                <table style="width: 100%">
                    <tr>
                        <td style="width: 70%;"></td>
                        <td style="width: 30%"></td>
                    </tr>
                    <tr style="margin-bottom: 5px">
                        <td>
                            <input type="text" id="txtCedula" name="txtCedula" class="form-control" readonly placeholder="Cédula" style="padding-top: 5px;" />
                        </td>
                        <td rowspan="2" style="text-align: center">
                            <button id="btnBuscarDocente" type="button" class=" btn btn-info " data-toggle="modal" data-target="#exampleModal" tabindex="1">
                                Buscar
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" id="txtDatos" name="txtDatos" class="form-control my-3" readonly placeholder="Nombre y Apellido" style="padding-top: 5px;" />
                        </td>
                    </tr>
                </table>
            </div>
            <div class="form-group">
                <input type="button" value="Guardar" class="btn btn-primary" id="btnGuardar" />
                <input type="button" value="Eliminar" class="btn btn-danger" id="btnEliminar" />
                <input type="button" value="Limpiar" class="btn btn-warning" id="btnLimpiar" />
                <input type="text" id="txtId" name="txtId" style="opacity: 0; width: 5px" />
            </div>
        </div>
        <div class="col-sm-7" style="margin-top: 7px;">
            <table id="tbl_Materias" class="table table-bordered  table-striped bg-white" style="width: 100%">
                <thead class="thead-dark">
                    <tr>
                        <th>Id</th>
                        <th>Nombre</th>
                        <th>Cedula</th>
                        <th>Docente</th>
                        <th>Nivel</th>
                        <th>idCarrera</th>
                        <th>Carrera</th>
                    </tr>
                </thead>
                <tbody class="tbl_body_table">
                    <!-- Cargar De Datos Por Ajax -->
                </tbody>
            </table>
        </div>
    </div>
    <!-- Modal Docentes-->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Buscar Docente</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table id="tbl_Docentes" class="table table-bordered" align="center">
                        <thead class="thead-dark">
                            <tr>
                                <th>Cédula</th>
                                <th>Nombres</th>
                                <th>Apellidos</th>
                            </tr>
                        </thead>
                        <tbody id="tbl_body_table">
                            <!--Carga De Datos Por AJAX-->
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button id="btnAceptar" type="button" class="btn btn-primary" data-dismiss="modal">Aceptar</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
