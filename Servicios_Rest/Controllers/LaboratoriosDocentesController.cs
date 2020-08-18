using Servicios_Rest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Servicios_Rest.Controllers
{
    public class LaboratoriosDocentesController : ApiController
    {

        private MateriasCompletasDAL materias;

        public LaboratoriosDocentesController()
        {
            materias = new MateriasCompletasDAL();
        }

        public IHttpActionResult GetMateriasCompletas([FromUri] string idDia, [FromUri] string idLaboratorio)
        {

            List<MateriaCompleta> lstMaterias = materias.GetMaterias(idDia,idLaboratorio);

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

    }
}
