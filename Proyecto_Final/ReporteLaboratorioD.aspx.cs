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
            string id = String.Format("{0}", Request.Form["txtCodigo"]);
            ConjuntoDatosDataSet.RepLabDataTable valor = new ConjuntoDatosDataSet.RepLabDataTable();
            DatosReportes.ConjuntoDatosDataSetTableAdapters.RepLabTableAdapter datos = new DatosReportes.ConjuntoDatosDataSetTableAdapters.RepLabTableAdapter();
            ReportDataSource rs = new ReportDataSource();
            datos.Fill(valor, Convert.ToInt32(id));
            rs.Name = "DataSetLabDoc";
            rs.Value = valor;
            ReportViewerPrestamosLab.LocalReport.DataSources.Clear();
            ReportViewerPrestamosLab.LocalReport.DataSources.Add(rs);
            ReportViewerPrestamosLab.ProcessingMode = ProcessingMode.Local;
            ReportViewerPrestamosLab.LocalReport.ReportPath = "ReporteLab.rdlc";
            ReportViewerPrestamosLab.LocalReport.Refresh();
        }
    }
}