using Servicios_Rest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Servicios_Rest.Controllers
{
    public class LaboratoristasController : ApiController
    {

        private LaboratoristasDAL Laboratoristas;

        public LaboratoristasController()
        {
            Laboratoristas = new LaboratoristasDAL();
        }

        public IHttpActionResult GetLaboratoristas()
        {

            List<Laboratorista> lstLaboratoristas = Laboratoristas.GetLaboratoristas();

            if (lstLaboratoristas.Count > 0)
            {
                if (!String.IsNullOrEmpty(lstLaboratoristas[0].mensajeError))
                {
                    return Content(HttpStatusCode.NotFound, lstLaboratoristas[0].mensajeError);
                }
                else
                {
                    return Content(HttpStatusCode.OK, lstLaboratoristas);
                }
            }
            else
            {
                return Content(HttpStatusCode.OK, lstLaboratoristas);
            }

        }
        public IHttpActionResult PostLaboratoristas(Laboratorista Laboratorista)
        {

            Laboratorista LaboratoristaR = Laboratoristas.PostLaboratorista(Laboratorista);

            if (!String.IsNullOrEmpty(LaboratoristaR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, LaboratoristaR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, LaboratoristaR);
            }

        }
        public IHttpActionResult DeleteLaboratoristas([FromBody]string cedula)
        {

            Laboratorista LaboratoristaR = Laboratoristas.DeleteLaboratorista(cedula);

            if (!String.IsNullOrEmpty(LaboratoristaR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, LaboratoristaR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, LaboratoristaR);
            }

        }
        public IHttpActionResult PutLaboratoristas(Laboratorista Laboratorista)
        {

            Laboratorista LaboratoristaR = Laboratoristas.UpdateLaboratorista(Laboratorista);

            if (!String.IsNullOrEmpty(LaboratoristaR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, LaboratoristaR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, LaboratoristaR);
            }

        }

    }
}
