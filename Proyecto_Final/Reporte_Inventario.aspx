<%@ Page Title="" Language="C#" MasterPageFile="~/Pagina_Principal.Master" AutoEventWireup="true" CodeBehind="Reporte_Inventario.aspx.cs" Inherits="Proyecto_Final.Formulario_web12" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/bootstrap.min.css">
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="DataTable/jquery.dataTables.min.css" />
    <script src="DataTable/jquery.dataTables.min.js"></script>
    <script src="Controladores/ReporteInventarios.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="my-3">Reporte Inventarios</h1>
    <%--<div class="row container">
        <div class="form-group">
            <label class="control-label">Categoria</label>
            <select name="cmbCategoria" id="cmbCategoria" class="form-control dropdown">
                <option value="">---Seleccione---</option>
            </select>
        </div>
    </div>--%>
<%--    <asp:Button ID="Button1" runat="server" Text="GENERAR" class="btn btn-dark"
        OnClick="Button1_Click" />--%>
    <input type="text" id="txt1" name="txt1" style="visibility: hidden" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <rsweb:ReportViewer ID="ReportViewerInventario" runat="server" Height="448px"
        Width="709px">
    </rsweb:ReportViewer>
</asp:Content>
