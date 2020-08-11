using Servicios_Rest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Servicios_Rest.Controllers
{
    public class CarrerasController : ApiController
    {

        private CarrerasDAL carreras;

        public CarrerasController()
        {
            carreras = new CarrerasDAL();
        }

        public IHttpActionResult GetCarreras()
        {

            List<Carrera> lstCarreras = carreras.GetCarreras();

            if (lstCarreras.Count > 0)
            {
                if (!String.IsNullOrEmpty(lstCarreras[0].mensajeError))
                {
                    return Content(HttpStatusCode.NotFound, lstCarreras[0].mensajeError);
                }
                else
                {
                    return Content(HttpStatusCode.OK, lstCarreras);
                }
            }
            else
            {
                return Content(HttpStatusCode.OK, lstCarreras);
            }

        }

    }
}
