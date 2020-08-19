using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using Proyecto_Final.DatosReportes;
namespace Proyecto_Final
{
    public partial class Formulario_web14 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string id = String.Format("{0}", Request.Form["txtNumeroPrestamo"]);
            ConjuntoDatosDataSet.PrestamosDocentesDataTable valor = new ConjuntoDatosDataSet.PrestamosDocentesDataTable();
            DatosReportes.ConjuntoDatosDataSetTableAdapters.PrestamosDocentesTableAdapter datos = new DatosReportes.ConjuntoDatosDataSetTableAdapters.PrestamosDocentesTableAdapter();
            ReportDataSource rs = new ReportDataSource();
            datos.Fill(valor, Convert.ToInt32(id));
            rs.Name = "DataSetPrestamosEstudiantes";
            rs.Value = valor;
            ReportViewerPrestamosDocdentes.LocalReport.DataSources.Clear();
            ReportViewerPrestamosDocdentes.LocalReport.DataSources.Add(rs);
            ReportViewerPrestamosDocdentes.ProcessingMode = ProcessingMode.Local;
            ReportViewerPrestamosDocdentes.LocalReport.ReportPath = "ReportePrestamosEstudiantes.rdlc";
            ReportViewerPrestamosDocdentes.LocalReport.Refresh();
        }
    }
}