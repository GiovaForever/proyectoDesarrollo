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
    public partial class Formulario_web11 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string laboratorio = String.Format("{0}", Request.Form["txt1"]);
            ConjuntoDatosDataSet.LaboratoriosDataTable valor = new ConjuntoDatosDataSet.LaboratoriosDataTable();
            DatosReportes.ConjuntoDatosDataSetTableAdapters.LaboratoriosTableAdapter datos = new DatosReportes.ConjuntoDatosDataSetTableAdapters.LaboratoriosTableAdapter();
            ReportDataSource rs = new ReportDataSource();
            datos.Fill(valor, Convert.ToInt32(laboratorio));
            rs.Name = "DataSetLaboratorios";
            rs.Value = valor;
            ReportViewerLaboratorios.LocalReport.DataSources.Clear();
            ReportViewerLaboratorios.LocalReport.DataSources.Add(rs);
            ReportViewerLaboratorios.ProcessingMode = ProcessingMode.Local;
            ReportViewerLaboratorios.LocalReport.ReportPath = "ReporteEquipos.rdlc";
            ReportViewerLaboratorios.LocalReport.Refresh();
        }
    }
}