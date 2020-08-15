using Servicios_Rest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Servicios_Rest.Controllers
{
    public class PrestamosEstudiantesController : ApiController
    {

        private MasPrestEstudianteDAL prestamoEstudiante;

        public PrestamosEstudiantesController()
        {
            prestamoEstudiante = new MasPrestEstudianteDAL();
        }

        public IHttpActionResult PostPrestamos(PrestamoUsuario prestamo)
        {
            PrestamoUsuario prestamoR = prestamoEstudiante.PostPrestamo(prestamo);

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
            List<DatosPrestamoEstudiante> lstPrestamos = prestamoEstudiante.GetDatosPrestamo();

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
        [Route("api/PrestamosEstudiantes/DetallePrestamos")]
        public IHttpActionResult GetDetallePrestamos([FromUri] string idPrestamo)
        {
            List<DatosDetallePrestamosEst> lstPrestamos = prestamoEstudiante.GetDetallePrestamo(idPrestamo);

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
            PrestamoUsuario prestamoR = prestamoEstudiante.PutPrestamo(prestamo);

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
