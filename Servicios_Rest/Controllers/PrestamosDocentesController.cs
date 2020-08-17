using Servicios_Rest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Servicios_Rest.Controllers
{
    public class PrestamosDocentesController : ApiController
    {

        private MasPrestDocenteDAL prestamoDocente;

        public PrestamosDocentesController()
        {
            prestamoDocente = new MasPrestDocenteDAL();
        }

        public IHttpActionResult PostPrestamos(PrestamoUsuario prestamo)
        {
            PrestamoUsuario prestamoR = prestamoDocente.PostPrestamo(prestamo);

            if (!String.IsNullOrEmpty(prestamoR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, prestamoR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, "");
            }
        }

        public IHttpActionResult GetPrestamos()
        {
            List<DatosPrestamoEstudiante> lstPrestamos = prestamoDocente.GetDatosPrestamo();

            if (lstPrestamos.Count > 0)
            {
                if (!String.IsNullOrEmpty(lstPrestamos[0].mensajeError))
                {
                    return Content(HttpStatusCode.NotFound, lstPrestamos[0].mensajeError);
                }
                else
                {
                    return Content(HttpStatusCode.OK, lstPrestamos);
                }
            }
            else
            {
                return Content(HttpStatusCode.OK, lstPrestamos);
            }
        }


        [HttpGet]
        [Route("api/PrestamosDocentes/DetallePrestamos")]
        public IHttpActionResult GetDetallePrestamos([FromUri] string idPrestamo)
        {
            List<DatosDetallePrestamosEst> lstPrestamos = prestamoDocente.GetDetallePrestamo(idPrestamo);

            if (lstPrestamos.Count > 0)
            {
                if (!String.IsNullOrEmpty(lstPrestamos[0].mensajeError))
                {
                    return Content(HttpStatusCode.NotFound, lstPrestamos[0].mensajeError);
                }
                else
                {
                    return Content(HttpStatusCode.OK, lstPrestamos);
                }
            }
            else
            {
                return Content(HttpStatusCode.OK, lstPrestamos);
            }
        }

        public IHttpActionResult PutPrestamos(PrestamoUsuario prestamo)
        {
            PrestamoUsuario prestamoR = prestamoDocente.PutPrestamo(prestamo);

            if (!String.IsNullOrEmpty(prestamoR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, prestamoR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, "");
            }
        }

    }
}
