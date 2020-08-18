<%@ Page Title="" Language="C#" MasterPageFile="~/Pagina_Principal.Master" AutoEventWireup="true" CodeBehind="Prestamos_Estudiantes.aspx.cs" Inherits="Proyecto_Final.Prestamos_Estudiantes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/bootstrap.min.css">
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="DataTable/jquery.dataTables.min.css" />
    <script src="DataTable/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous" />
    <script src="Controladores/ControladoresPrestamosEstudiantes.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row container my-3">
        <h1 style="margin-top: 7px; margin-bottom: 7px;">Préstamos Equipos</h1>
    </div>
    <div class="container form-inline">
        <label class="control-label">N°:  </label>
        <input type="text" id="txtNumeroPrestamo" name="txtNumeroPrestamo" class="form-control mx-2 my-2" readonly />
    </div>
    <div class="container form-inline">
        <label class="control-label">Fecha:</label>
        <input type="text" id="txtFecha" name="txtFecha" class="form-control mx-2 my-2" readonly />
    </div>
    <div class="row container">
        <div class="col-sm-5">
            <div class="form-group">
                <table style="width: 100%">
                    <tr>
                        <td style="width: 70%;"></td>
                        <td style="width: 30%"></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <label class="control-label">Laboratorista:</label>
                        </td>
                    </tr>
                    <tr style="margin-bottom: 5px">
                        <td>
                            <input type="text" id="txtCedulaLaboratorista" name="txtCedulaLaboratorista" class="form-control" readonly placeholder="Cédula" />
                        </td>
                        <td rowspan="2" style="text-align: center">
                            <button id="btnBuscarLaboratorista" type="button" class=" btn btn-dark" data-toggle="modal" data-target="#ModalLaboratorista">
                                <span class="fas fa-search mx-3">  Buscar
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" id="txtDatosLaboratorista" name="txtDatos" class="form-control my-2" readonly placeholder="Nombre y Apellido" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <label class="control-label">Estudiante:</label>
                        </td>
                    </tr>
                    <tr style="margin-bottom: 5px">
                        <td>
                            <input type="text" id="txtCedulaEstudiante" name="txtCedulaEstudiante" class="form-control" readonly placeholder="Cédula" />
                        </td>
                        <td rowspan="2" style="text-align: center">
                            <button id="btnBuscarEstudiante" type="button" class=" btn btn-dark" data-toggle="modal" data-target="#ModalEstudiante">
                                <span class="fas fa-search mx-3">  Buscar
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" id="txtDatosEstudiante" name="txtDatos" class="form-control my-2" readonly placeholder="Nombre y Apellido" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="col-sm-5 mx-5">
            <div class="form-group">
                <table style="width: 100%">
                    <tr>
                        <td style="width: 70%;"></td>
                        <td style="width: 30%"></td>
                    </tr>
                    <tr>
                        <td>
                            <label class="control-label">Inventario:</label>
                        </td>
                    </tr>
                    <tr style="margin-bottom: 5px">
                        <td>
                            <input type="text" id="txtCategoria" name="txtCategoria" class="form-control" readonly placeholder="Categoria" />
                        </td>
                        <td rowspan="2" style="text-align: center">
                            <button id="btnBuscarInventario" type="button" class=" btn btn-dark" data-toggle="modal" data-target="#ModalInventario" tabindex="1">
                                <span class="fas fa-search mx-3">  Buscar
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" id="txtNombreInventario" name="txtNombreInventario" class="form-control my-2" readonly placeholder="Nombre" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" id="txtCantidad" name="txtCantidad" class="form-control my-2" placeholder="0" maxlength="2" />
                        </td>
                    </tr>
                </table>
                <div class="form-group">
                    <button id="btnAgregar" name="btnAgregar" class="btn btn-success" onclick="return false">
                    <span class="fas fa-plus-square mx-2"></span>Agregar
                </button>
                    <input type="text" id="txtId" name="txtId" style="opacity: 1; width: 30px" />
                    <input type="text" id="txtCantExis" name="txtCantExis" style="opacity: 1; width: 30px" />
                </div>
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
            <button id="btnGuardar" name="btnGuardar" class="btn btn-primary" onclick="return false">
                    <span class="fas fa-save mx-2"></span>Guardar
                </button>
        </center>
    </div>
    <!-- Modal Laboratoristas-->
    <div class="modal fade" id="ModalLaboratorista" tabindex="-1" role="dialog" aria-labelledby="ModalLaboratoristaLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalLaboratoristaLabel">Buscar Laboratoristas</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table id="tbl_Laboratoristas" class="table table-bordered" align="center">
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
    <!-- Modal Estudiantes-->
    <div class="modal fade" id="ModalEstudiante" tabindex="-1" role="dialog" aria-labelledby="ModalEstudianteLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalEstudianteLabel">Buscar Estudiantes</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table id="tbl_Estudiantes" class="table table-bordered" align="center">
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
    <!-- Modal Inventario-->
    <div class="modal fade" id="ModalInventario" tabindex="-1" role="dialog" aria-labelledby="ModalInventarioLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalInventarioLabel">Elegir Material</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table id="tbl_Inventario" class="table table-bordered" align="center" style="width:100%">
                        <thead class="thead-dark">
                            <tr>
                                <th>Id</th>
                                <th>Nombre</th>
                                <th>Cantidad</th>
                                <th>idCategoria</th>
                                <th>Categoria</th>
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
