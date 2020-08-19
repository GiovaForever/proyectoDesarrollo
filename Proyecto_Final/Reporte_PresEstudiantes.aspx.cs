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
    public partial class Formulario_web13 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string id = String.Format("{0}", Request.Form["txtNumeroPrestamo"]);
            ConjuntoDatosDataSet.PrestamosEstudiantesDataTable valor = new ConjuntoDatosDataSet.PrestamosEstudiantesDataTable();
            DatosReportes.ConjuntoDatosDataSetTableAdapters.PrestamosEstudiantesTableAdapter datos = new DatosReportes.ConjuntoDatosDataSetTableAdapters.PrestamosEstudiantesTableAdapter();
            ReportDataSource rs = new ReportDataSource();
            datos.Fill(valor, Convert.ToInt32(id));
            rs.Name = "DataSetPrestamosEstudiantes";
            rs.Value = valor;
            ReportViewerPrestamosEstudiantes.LocalReport.DataSources.Clear();
            ReportViewerPrestamosEstudiantes.LocalReport.DataSources.Add(rs);
            ReportViewerPrestamosEstudiantes.ProcessingMode = ProcessingMode.Local;
            ReportViewerPrestamosEstudiantes.LocalReport.ReportPath = "ReportePrestamosEstudiantes.rdlc";
            ReportViewerPrestamosEstudiantes.LocalReport.Refresh();
        }
    }
}