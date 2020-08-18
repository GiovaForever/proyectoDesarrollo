<%@ Page Title="" Language="C#" MasterPageFile="~/Pagina_Principal.Master" AutoEventWireup="true" CodeBehind="Prestamos_Laboratorios_Docentes.aspx.cs" Inherits="Proyecto_Final.Prestamos_Laboratorios_Docentes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/bootstrap.min.css">
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="DataTable/jquery.dataTables.min.css" />
    <script src="DataTable/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous" />
    <script src="Controladores/ControladoresLaboratoriosDocentes.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row container my-3">
        <h1 style="margin-top: 7px; margin-bottom: 7px;">Prestamos Laboratorios</h1>
    </div>
    <div class="row container">
        <div class="col-sm-5">
            <div class="form-group">
                <label class="control-label">Código:</label>
            </div>
            <div class="form-group form-inline">
                <input type="text" id="txtCodigo" name="txtCodigo" class="form-control" readonly placeholder="Id" />
            </div>
            <div class="form-group">
                <label class="control-label">Laboratorista:</label>
                <input type="text" id="txtCedulaLaboratorista" name="txtNombre" class="form-control my-2" readonly placeholder="9999999999" />
                <input type="text" id="txtNombreLaboratorista" name="txtNombre" class="form-control my-2" readonly placeholder="LAB00" />
                <center>
                    <button id="btnBuscarLaboratorista" type="button" class=" btn btn-dark mx-2" data-toggle="modal" data-target="#ModalLaboratorista">
                        <span class="fas fa-search mx-2"></span>Buscar
                    </button>
                </center>
            </div>
            <div class="form-group">
                <label class="control-label">Laboratorio:</label>
                <input type="text" id="txtNombreLaboratorio" name="txtNombreLaboratorio" class="form-control my-2" readonly placeholder="LAB 000" />
                <input type="text" id="txtTipoLaboratorio" name="txtTipoLaboratorio" class="form-control my-2" readonly placeholder="CTT" />
                <center>
                    <button id="btnBuscarLaboratorio" type="button" class=" btn btn-dark mx-2" data-toggle="modal" data-target="#ModalLaboratorio">
                        <span class="fas fa-search mx-2"></span>Buscar
                    </button>
                </center>
            </div>
        </div>
        <div class="col-sm-5">
            <div class="form-group">
                <label class="control-label" style="opacity: 0">Código:</label>
            </div>
            <div class="form-group form-inline">
                <input type="text" id="txtCodigoLaboratorio" name="txtCodigoLaboratorio" class="form-control" readonly style="opacity: 1; width: 30px" />
                <input type="text" id="txtCodigoDia" name="txtCodigoDia" class="form-control" readonly style="opacity: 1; width: 30px" />
                <input type="text" id="txtCodigoMateria" name="txtCodigoMateria" class="form-control" readonly style="opacity: 1; width: 30px" />
            </div>
            <div class="form-group">
                <label class="control-label">Materia:</label>
                <input type="text" id="txtNombreMateria" name="txtNombre" class="form-control my-2" readonly placeholder="Subject" />
                <input type="text" id="txtCargaHoraria" name="txtNombre" class="form-control my-2" readonly placeholder="00:00 - 00:00" />
                <center>
                    <button id="btnBuscarMateria" type="button" class=" btn btn-dark mx-2" data-toggle="modal" data-target="#ModalMaterias">
                        <span class="fas fa-search mx-2"></span>Buscar
                    </button>
                </center>
            </div>
            <div class="form-group">
                <label class="control-label">Docente:</label>
                <input type="text" id="txtCedulaDocente" name="txtCedulaDocente" class="form-control my-2" readonly placeholder="9999999999" />
                <input type="text" id="txtNombreDocente" name="txtNombreDocente" class="form-control my-2" readonly placeholder="Name" />
            </div>
        </div>
        <div class="container my-2">
            <center>
                <button id="btnGuardar" name="btnGuardar" class="btn btn-success" onclick="return false">
                    <span class="fas fa-save mx-2"></span>Guardar
                </button>
            </center>
        </div>
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
    <!-- Modal Laboratorios-->
    <div class="modal fade" id="ModalLaboratorio" tabindex="-1" role="dialog" aria-labelledby="ModalLaboratorioLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalLaboratorioLabel">Buscar Laboratorio</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table id="tbl_Laboratorios" class="table table-bordered" align="center" style="width: 100%">
                        <thead class="thead-dark">
                            <tr>
                                <th>Id</th>
                                <th>Nombre</th>
                                <th>Ubicación</th>
                                <th>Tipo Laboratorio</th>
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
     <!-- Modal Materias-->
    <div class="modal fade" id="ModalMaterias" tabindex="-1" role="dialog" aria-labelledby="ModalMateriasLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalMateriasLabel">Buscar Materias:</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table id="tbl_Materias" class="table table-bordered" align="center" style="width: 100%">
                        <thead class="thead-dark">
                            <tr>
                                <th>idMateria</th>
                                <th>Materia</th>
                                <th>Cédula</th>
                                <th>Nombre</th>
                                <th>Apellido</th>
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
