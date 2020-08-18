using Servicios_Rest.Models;
using System;
using System.Collections.Generic;
using System.Net;
using System.Web.Http;

namespace Servicios_Rest.Controllers
{
    public class EstudiantesController : ApiController
    {

        private EstudiantesDAL estudiantes;

        public EstudiantesController()
        {
            estudiantes = new EstudiantesDAL();
        }

        public IHttpActionResult GetEstudiantes()
        {

            List<Estudiante> lstEstudiantes = estudiantes.GetEstudiantes();

            if (lstEstudiantes.Count>0)
            {
                if (!String.IsNullOrEmpty(lstEstudiantes[0].mensajeError))
                {
                    return Content(HttpStatusCode.NotFound, lstEstudiantes[0].mensajeError);
                }
                else
                {
                    return Content(HttpStatusCode.OK, lstEstudiantes);
                }
            }
            else
            {
                return Content(HttpStatusCode.OK, lstEstudiantes);
            }

        }
        public IHttpActionResult PostEstudiantes(Estudiante estudiante)
        {

            Estudiante estudianteR = estudiantes.PostEstudiante(estudiante);

            if (!String.IsNullOrEmpty(estudianteR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, estudianteR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, estudianteR);
            }

        }

        public IHttpActionResult DeleteEstudiantes([FromBody]string cedula)
        {

            Estudiante estudianteR = estudiantes.DeleteEstudiante(cedula);

            if (!String.IsNullOrEmpty(estudianteR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, estudianteR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, estudianteR);
            }

        }
        public IHttpActionResult PutEstudiantes(Estudiante estudiante)
        {

            Estudiante estudianteR = estudiantes.UpdateEstudiante(estudiante);

            if (!String.IsNullOrEmpty(estudianteR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, estudianteR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, estudianteR);
            }

        }

    }
}
