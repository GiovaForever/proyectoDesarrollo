using Servicios_Rest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Servicios_Rest.Controllers
{
    public class DocentesController : ApiController
    {

        private DocentesDAL docentes;

        public DocentesController()
        {
            docentes = new DocentesDAL();
        }

        public IHttpActionResult Getdocentes()
        {

            List<Docente> lstdocentes = docentes.GetDocentes();

            if (lstdocentes.Count > 0)
            {
                if (!String.IsNullOrEmpty(lstdocentes[0].mensajeError))
                {
                    return Content(HttpStatusCode.NotFound, lstdocentes[0].mensajeError);
                }
                else
                {
                    return Content(HttpStatusCode.OK, lstdocentes);
                }
            }
            else
            {
                return Content(HttpStatusCode.OK, lstdocentes);
            }

        }
        public IHttpActionResult Postdocentes(Docente docente)
        {

            Docente docenteR = docentes.PostDocente(docente);

            if (!String.IsNullOrEmpty(docenteR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, docenteR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, docenteR);
            }

        }
        public IHttpActionResult Deletedocentes([FromBody]string cedula)
        {

            Docente docenteR = docentes.DeleteDocente(cedula);

            if (!String.IsNullOrEmpty(docenteR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, docenteR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, docenteR);
            }

        }
        public IHttpActionResult Putdocentes(Docente docente)
        {

            Docente docenteR = docentes.UpdateDocente(docente);

            if (!String.IsNullOrEmpty(docenteR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, docenteR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, docenteR);
            }

        }

    }
}
