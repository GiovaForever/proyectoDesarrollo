<%@ Page Title="" Language="C#" MasterPageFile="~/Pagina_Principal.Master" AutoEventWireup="true" CodeBehind="Reporte_Materias.aspx.cs" Inherits="Proyecto_Final.Formulario_web1" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Content/bootstrap.min.css">
    <script src="Scripts/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="DataTable/jquery.dataTables.min.css" />
    <script src="DataTable/jquery.dataTables.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <h1 class="my-3">Reporte Materias</h1>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
     <rsweb:ReportViewer ID="ReportViewerMaterias" runat="server" Height="448px" 
        Width="709px"></rsweb:ReportViewer>
</asp:Content>
