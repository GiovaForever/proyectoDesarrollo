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
    public partial class Formulario_web12 : System.Web.UI.Page
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
            string ruta = "ReporteInventario.rdlc";
            ConjuntoDatosDataSet.InventarioDataTable vista = new ConjuntoDatosDataSet.InventarioDataTable();
            DatosReportes.ConjuntoDatosDataSetTableAdapters.InventarioTableAdapter datos = new DatosReportes.ConjuntoDatosDataSetTableAdapters.InventarioTableAdapter();
            ReportDataSource rs = new ReportDataSource();
            datos.Fill(vista);
            rs.Name = "DataSetInventario";
            rs.Value = vista;
            ReportViewerInventario.LocalReport.DataSources.Clear();
            ReportViewerInventario.LocalReport.DataSources.Add(rs);
            ReportViewerInventario.ProcessingMode = ProcessingMode.Local;
            ReportViewerInventario.LocalReport.ReportPath = ruta;
            ReportViewerInventario.LocalReport.Refresh();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string id = String.Format("{0}", Request.Form["txt1"]);
         ConjuntoDatosDataSet.LabParametroDataTable valor = new ConjuntoDatosDataSet.LabParametroDataTable();
              DatosReportes.ConjuntoDatosDataSetTableAdapters.LabParametroTableAdapter datos = new DatosReportes.ConjuntoDatosDataSetTableAdapters.LabParametroTableAdapter();
                ReportDataSource rs = new ReportDataSource();
                datos.Fill(valor, Convert.ToInt32(id));
                rs.Name = "DataSetInvCat";
                rs.Value = valor;
                ReportViewerInventario.LocalReport.DataSources.Clear();
                ReportViewerInventario.LocalReport.DataSources.Add(rs);
                ReportViewerInventario.ProcessingMode = ProcessingMode.Local;
                ReportViewerInventario.LocalReport.ReportPath = "ReporteInventarioCategoria.rdlc";
                ReportViewerInventario.LocalReport.Refresh();
        }
    }
}