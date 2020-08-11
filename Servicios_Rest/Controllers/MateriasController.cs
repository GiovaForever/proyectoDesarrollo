using Servicios_Rest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Servicios_Rest.Controllers
{
    public class MateriasController : ApiController
    {

        private MateriasDAL materias;

        public MateriasController()
        {
            materias = new MateriasDAL();
        }

        public IHttpActionResult GetMaterias()
        {

            List<Materia> lstMaterias = materias.GetMaterias();

            if (lstMaterias.Count > 0)
            {
                if (!String.IsNullOrEmpty(lstMaterias[0].mensajeError))
                {
                    return Content(HttpStatusCode.NotFound, lstMaterias[0].mensajeError);
                }
                else
                {
                    return Content(HttpStatusCode.OK, lstMaterias);
                }
            }
            else
            {
                return Content(HttpStatusCode.OK, lstMaterias);
            }

        }

        public IHttpActionResult PostMaterias(Materia materia)
        {

            Materia materiaR = materias.PostMateria(materia);

            if (!String.IsNullOrEmpty(materiaR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, materiaR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, materiaR);
            }

        }
        public IHttpActionResult DeleteMaterias([FromBody]string id)
        {

            Materia materiaR = materias.DeleteMateria(id);

            if (!String.IsNullOrEmpty(materiaR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, materiaR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, materiaR);
            }

        }
        public IHttpActionResult PutMaterias(Materia Materia)
        {

            Materia materiaR = materias.UpdateMateria(Materia);

            if (!String.IsNullOrEmpty(materiaR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, materiaR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, materiaR);
            }

        }

    }
}
