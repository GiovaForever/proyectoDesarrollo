using Servicios_Rest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Servicios_Rest.Controllers
{
    public class TipoLaboratoriosController : ApiController
    {

        private TipoLaboratoriosDAL tipoLaboratorios;

        public TipoLaboratoriosController()
        {
            tipoLaboratorios= new TipoLaboratoriosDAL();
        }

        public IHttpActionResult GetTipoLaboratorios()
        {

            List<TipoLaboratorio> lstTipoLaboratorio = tipoLaboratorios.GetTipoLaboratorios();

            if (lstTipoLaboratorio.Count > 0)
            {
                if (!String.IsNullOrEmpty(lstTipoLaboratorio[0].mensajeError))
                {
                    return Content(HttpStatusCode.NotFound, lstTipoLaboratorio[0].mensajeError);
                }
                else
                {
                    return Content(HttpStatusCode.OK, lstTipoLaboratorio);
                }
            }
            else
            {
                return Content(HttpStatusCode.OK, lstTipoLaboratorio);
            }

        }

        public IHttpActionResult GetTipoLaboratorioById(string nombre)
        {

            List<TipoLaboratorio> lstTipoLaboratorio = tipoLaboratorios.GetTipoLaboratorios();

            if (lstTipoLaboratorio.Count > 0)
            {
                if (!String.IsNullOrEmpty(lstTipoLaboratorio[0].mensajeError))
                {
                    return Content(HttpStatusCode.NotFound, lstTipoLaboratorio[0].mensajeError);
                }
                else
                {
                    TipoLaboratorio tipo = lstTipoLaboratorio.Where(x => x.nombreTipoLaboratorio == nombre).FirstOrDefault();
                    return Content(HttpStatusCode.OK, tipo);
                }
            }
            else
            {
                return Content(HttpStatusCode.OK, lstTipoLaboratorio);
            }

        }

    }
}
