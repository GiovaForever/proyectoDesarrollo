using Servicios_Rest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Servicios_Rest.Controllers
{
    public class PrestamosInvitadosController : ApiController
    {

        private MasPrestInvitadoDAL prestamoInvitado;

        public PrestamosInvitadosController()
        {
            prestamoInvitado = new MasPrestInvitadoDAL();
        }

        public IHttpActionResult PostPrestamos(PrestamoUsuario prestamo)
        {
            PrestamoUsuario prestamoR = prestamoInvitado.PostPrestamo(prestamo);

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
            List<DatosPrestamoEstudiante> lstPrestamos = prestamoInvitado.GetDatosPrestamo();

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
        [Route("api/PrestamosInvitados/DetallePrestamos")]
        public IHttpActionResult GetDetallePrestamos([FromUri] string idPrestamo)
        {
            List<DatosDetallePrestamosEst> lstPrestamos = prestamoInvitado.GetDetallePrestamo(idPrestamo);

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
            PrestamoUsuario prestamoR = prestamoInvitado.PutPrestamo(prestamo);

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
