<%@ Page Title="" Language="C#" MasterPageFile="~/Pagina_Principal.Master" AutoEventWireup="true" CodeBehind="Reporte_PresDocentes.aspx.cs" Inherits="Proyecto_Final.Formulario_web14" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <link rel="stylesheet" href="Content/bootstrap.min.css">
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="DataTable/jquery.dataTables.min.css" />
    <script src="DataTable/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous" />
    <script src="Controladores/ReportePrestamoDocente.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <h1 class="my-3">Reporte Prestamos Docentes</h1>    
    <div class="container form-inline">
        <label class="control-label">N°:  </label>
        <input type="text" id="txtNumeroPrestamo" name="txtNumeroPrestamo" class="form-control mx-2 my-2" readonly />
        <button id="btnBuscarPrestamo" type="button" class=" btn btn-dark mx-3" data-toggle="modal" data-target="#ModalPrestamos">
            <span class="fas fa-search mx-3"> Buscar
        </button>
    </div>
      <asp:Button ID="Button1" runat="server" Text="GENERAR" class="btn btn-dark" 
        OnClick="Button1_Click" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <rsweb:ReportViewer ID="ReportViewerPrestamosDocdentes" runat="server" Height="448px" 
        Width="709px"></rsweb:ReportViewer>
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
                                <th>Ced. Docente</th>
                                <th>Datos Docente</th>
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
