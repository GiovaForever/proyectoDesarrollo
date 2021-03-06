﻿using Servicios_Rest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Servicios_Rest.Controllers
{
    public class ValuesController : ApiController
    {

        valuesDAL values;

        public ValuesController()
        {
            values = new valuesDAL();
        }

        [HttpGet]
        [Route("api/values/date")]
        public IHttpActionResult GetDate()
        {

            List<string> lstResult = values.GetFechaPrestamo();

            if (lstResult[0].Equals("Error"))
            {
                return Content(HttpStatusCode.NotFound, lstResult[1]);
            }
            else
            {
                return Content(HttpStatusCode.OK, lstResult[1]);
            }

        }

        [HttpGet]
        [Route("api/values/prestamoEstudiante")]
        public IHttpActionResult GetPrestamoEstudiante()
        {
            List<string> lstResult = values.GetIdPrestEstudiantes();

            if (lstResult[0].Equals("Error"))
            {
                return Content(HttpStatusCode.NotFound, lstResult[1]);
            }
            else
            {
                return Content(HttpStatusCode.OK, Convert.ToString(Convert.ToInt32(lstResult[1]) + 1));
            }

        }

        [HttpGet]
        [Route("api/values/prestamoDocente")]
        public IHttpActionResult GetPrestamoDocente()
        {
            List<string> lstResult = values.GetIdPrestDocentes();

            if (lstResult[0].Equals("Error"))
            {
                return Content(HttpStatusCode.NotFound, lstResult[1]);
            }
            else
            {
                return Content(HttpStatusCode.OK, Convert.ToString(Convert.ToInt32(lstResult[1]) + 1));
            }

        }

        [HttpGet]
        [Route("api/values/prestamoLabDocente")]
        public IHttpActionResult GetPrestamoLabDocente()
        {
            List<string> lstResult = values.GetIdLaboratorioDocente();

            if (lstResult[0].Equals("Error"))
            {
                return Content(HttpStatusCode.NotFound, lstResult[1]);
            }
            else
            {
                return Content(HttpStatusCode.OK, Convert.ToString(Convert.ToInt32(lstResult[1]) + 1));
            }

        }

        [HttpGet]
        [Route("api/values/codigoDiaPrestamo")]
        public IHttpActionResult GetCodigoDiaPrestamo()
        {
            List<string> lstResult = values.GetIdDia();

            if (lstResult[0].Equals("Error"))
            {
                return Content(HttpStatusCode.NotFound, lstResult[1]);
            }
            else
            {
                return Content(HttpStatusCode.OK, Convert.ToString(lstResult[1]));
            }

        }

        [HttpGet]
        [Route("api/values/prestamoInvitado")]
        public IHttpActionResult GetPrestamoInvitados()
        {
            List<string> lstResult = values.GetIdPrestInvitados();

            if (lstResult[0].Equals("Error"))
            {
                return Content(HttpStatusCode.NotFound, lstResult[1]);
            }
            else
            {
                return Content(HttpStatusCode.OK, Convert.ToString(Convert.ToInt32(lstResult[1]) + 1));
            }

        }

    }
}
