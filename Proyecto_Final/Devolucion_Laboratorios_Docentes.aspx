<%@ Page Title="" Language="C#" MasterPageFile="~/Pagina_Principal.Master" AutoEventWireup="true" CodeBehind="Devolucion_Laboratorios_Docentes.aspx.cs" Inherits="Proyecto_Final.Devolucion_Laboratorios_Docentes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/bootstrap.min.css">
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="DataTable/jquery.dataTables.min.css" />
    <script src="DataTable/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous" />
    <script src="Controladores/ControladoresDevolucionLabDocente.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row container my-3">
        <h1 style="margin-top: 7px; margin-bottom: 7px;">Devolución Laboratorios</h1>
    </div>
    <div class="row container">
        <div class="col-sm-5">
            <div class="form-group form-inline">
                <label class="control-label">Código:</label>
                <input type="text" id="txtCodigo" name="txtCodigo" class="form-control mx-2" readonly placeholder="Id" />
                <button id="btnBuscarPrestamos" type="button" class=" btn btn-dark mx-2" data-toggle="modal" data-target="#ModalPrestamos">
                    <span class="fas fa-search mx-2"></span>Buscar
                </button>
            </div>
            <div class="form-group form-inline">
                <label class="control-label">Fecha:</label>
                <input type="text" id="txtFecha" name="txtCodigo" class="form-control mx-3" readonly placeholder="dd/mm/yyyy" />
            </div>
            <div class="form-group">
                <label class="control-label">Laboratorista:</label>
                <input type="text" id="txtNombreLaboratorista" name="txtNombre" class="form-control my-2" readonly placeholder="Name" />
            </div>
            <div class="form-group">
                <label class="control-label">Laboratorio:</label>
                <input type="text" id="txtNombreLaboratorio" name="txtNombreLaboratorio" class="form-control my-2" readonly placeholder="LAB 000" />
                <input type="text" id="txtTipoLaboratorio" name="txtTipoLaboratorio" class="form-control my-2" readonly placeholder="CTT" />
            </div>
        </div>
        <div class="col-sm-5">
            <div class="form-group form-inline">
                <label class="control-label" style="opacity:0">Código:</label>
                <button id="btn" type="button" class=" btn btn-dark mx-2" data-toggle="modal" data-target="#ModalPrestamos" style="opacity:0">
                    <span class="fas mx-2"></span>
                </button>
            </div>
            <div class="form-group form-inline">
                <input type="text" id="txtCodigoLaboratorio" name="txtCodigoLaboratorio" class="form-control mx-3" readonly style="opacity: 0; width: 30px" />
                <input type="text" id="txtCodigoDia" name="txtCodigoDia" class="form-control mx-3" readonly style="opacity: 0; width: 30px" />
                <input type="text" id="txtCodigoMateria" name="txtCodigoMateria" class="form-control mx-3" readonly style="opacity: 0; width: 30px" />
            </div>
            <div class="form-group">
                <label class="control-label">Docente:</label>
                <input type="text" id="txtNombreDocente" name="txtNombreDocente" class="form-control my-2" readonly placeholder="Name" />
            </div>
            <div class="form-group">
                <label class="control-label">Materia:</label>
                <input type="text" id="txtNombreMateria" name="txtNombre" class="form-control my-2" readonly placeholder="Subject" />
                <input type="text" id="txtCargaHoraria" name="txtNombre" class="form-control my-2" readonly placeholder="00:00 - 00:00" />
            </div>
        </div>
        <div class="container my-2">
            <center>
                <button id="btnGuardar" name="btnGuardar" class="btn btn-success" onclick="return false">
                    <span class="fas fa-save mx-2"></span>Guardar
                </button>
            <button id="btnLimpiar" name="btnGuardar" class="btn btn-warning" onclick="return false">
                    <span class="fas fa-eraser mx-2"></span>Limpiar
                </button>
            </center>
        </div>
    </div>
    <!-- Modal Laboratoristas-->
    <div class="modal fade" id="ModalPrestamos" tabindex="-1" role="dialog" aria-labelledby="ModalPrestamosLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalPrestamosLabel">Buscar Laboratoristas</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table id="tbl_Prestamos" class="table table-bordered" align="center" style="width:100%">
                        <thead class="thead-dark">
                            <tr>
                                <th>idLabDocente</th>
                                <th>fechaPrestamo</th>
                                <th>datosLaboratorista</th>
                                <th>idLaboratorio</th>
                                <th>Laboratorio</th>
                                <th>Tipo</th>
                                <th>idMateria</th>
                                <th>Materia</th>
                                <th>Docente</th>
                                <th>Horario</th>
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
