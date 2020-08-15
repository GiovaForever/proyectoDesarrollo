<%@ Page Title="" Language="C#" MasterPageFile="~/Pagina_Principal.Master" AutoEventWireup="true" CodeBehind="Devolucion_Prestamo_Estudiante.aspx.cs" Inherits="Proyecto_Final.Devolucion_Prestamo_Estudiante" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/bootstrap.min.css">
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="DataTable/jquery.dataTables.min.css" />
    <script src="DataTable/jquery.dataTables.min.js"></script>
    <script src="Controladores/ControladoresDevolucionEstudiantes.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row container">
        <h1 style="margin-top: 7px; margin-bottom: 7px;">Devolución Equipos</h1>
    </div>
    <div class="container form-inline">
        <label class="control-label">N°:  </label>
        <input type="text" id="txtNumeroPrestamo" name="txtNumeroPrestamo" class="form-control mx-2 my-2" readonly />
        <button id="btnBuscarPrestamo" type="button" class=" btn btn-dark" data-toggle="modal" data-target="#ModalPrestamos">
            Buscar
        </button>
    </div>
    <div class="container form-inline">
        <label class="control-label">Fecha:</label>
        <input type="text" id="txtFecha" name="txtFecha" class="form-control mx-2 my-2" readonly />
    </div>
    <div class="row container">
        <div class="col-sm-5">
            <div class="form-group">

                <label class="control-label">Laboratorista:</label>
                <input type="text" id="txtCedulaLaboratorista" name="txtCedulaLaboratorista" class="form-control" readonly placeholder="Cédula" />
                <input type="text" id="txtDatosLaboratorista" name="txtDatos" class="form-control my-2" readonly placeholder="Nombre y Apellido" />
            </div>
        </div>
        <div class="col-sm-5 mx-5">
            <div class="form-group">
                <label class="control-label">Estudiante:</label>
                <input type="text" id="txtCedulaEstudiante" name="txtCedulaEstudiante" class="form-control" readonly placeholder="Cédula" />
                <input type="text" id="txtDatosEstudiante" name="txtDatos" class="form-control my-2" readonly placeholder="Nombre y Apellido" />
            </div>
        </div>
    </div>
    <div class="container my-2">
        <center>
            <table id="tbl_Detalle" class="table table-bordered  table-striped bg-white" style="width: 90%">
                <thead class="thead-dark">
                    <tr>
                        <th>Código</th>
                        <th>Nombre</th>
                        <th>Categoria</th>
                        <th>Cantidad</th>
                    </tr>
                </thead>
                <tbody class="tbl_body_table">
                    <!-- Cargar De Datos Por Ajax -->
                </tbody>
            </table>
        </center>
    </div>
    <div class="container my-2">
        <center>
            <input type="button" value="Guardar" class="btn btn-success" id="btnGuardar" />
        </center>
    </div>
    <!-- Modal Prestamos-->
    <div class="modal fade" id="ModalPrestamos" tabindex="-1" role="dialog" aria-labelledby="ModalPrestamosLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalPrestamosLabel">Elegir Prestamo</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table id="tbl_Prestamos" class="table table-bordered" align="center" style="width: 100%">
                        <thead class="thead-dark">
                            <tr>
                                <th>Id</th>
                                <th>Fecha</th>
                                <th>Ced. Estudiante</th>
                                <th>Datos Estudiante</th>
                                <th>Ced. Laboratorista</th>
                                <th>Datos Laboratorista</th>
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
