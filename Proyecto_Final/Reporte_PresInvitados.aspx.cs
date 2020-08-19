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
    public partial class Formulario_web15 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string id = String.Format("{0}", Request.Form["txtNumeroPrestamo"]);
            ConjuntoDatosDataSet.PrestamosInvitadosDataTable valor = new ConjuntoDatosDataSet.PrestamosInvitadosDataTable();
            DatosReportes.ConjuntoDatosDataSetTableAdapters.PrestamosInvitadosTableAdapter datos = new DatosReportes.ConjuntoDatosDataSetTableAdapters.PrestamosInvitadosTableAdapter();
            ReportDataSource rs = new ReportDataSource();
            datos.Fill(valor, Convert.ToInt32(id));
            rs.Name = "DataSetPrestamosInvitados";
            rs.Value = valor;
            ReportViewerPrestamosInvitados.LocalReport.DataSources.Clear();
            ReportViewerPrestamosInvitados.LocalReport.DataSources.Add(rs);
            ReportViewerPrestamosInvitados.ProcessingMode = ProcessingMode.Local;
            ReportViewerPrestamosInvitados.LocalReport.ReportPath = "ReportePrestamoInvitados.rdlc";
            ReportViewerPrestamosInvitados.LocalReport.Refresh();
        }
    }
}