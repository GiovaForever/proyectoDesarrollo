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
    public partial class Formulario_web1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarReporteGeneral();
            }
        }
        private void cargarReporteGeneral()
        {
            string ruta = "ReporteMaterias.rdlc";
            ConjuntoDatosDataSet.MateriasDataTable vista = new ConjuntoDatosDataSet.MateriasDataTable();
            DatosReportes.ConjuntoDatosDataSetTableAdapters.MateriasTableAdapter datos = new DatosReportes.ConjuntoDatosDataSetTableAdapters.MateriasTableAdapter();
            ReportDataSource rs = new ReportDataSource();
            datos.Fill(vista);
            rs.Name = "DataSetMaterias";
            rs.Value = vista;
            ReportViewerMaterias.LocalReport.DataSources.Clear();
            ReportViewerMaterias.LocalReport.DataSources.Add(rs);
            ReportViewerMaterias.ProcessingMode = ProcessingMode.Local;
            ReportViewerMaterias.LocalReport.ReportPath = ruta;
            ReportViewerMaterias.LocalReport.Refresh();
        }
    }
}