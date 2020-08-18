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
        private LaboratoriosDocentesDAL laboratorios;
        private DevolucionLaboratoriosDocentesDAL devolucionLaboratorios;

        public LaboratoriosDocentesController()
        {
            materias = new MateriasCompletasDAL();
            laboratorios = new LaboratoriosDocentesDAL();
            devolucionLaboratorios = new DevolucionLaboratoriosDocentesDAL();
        }

        public IHttpActionResult GetMateriasCompletas([FromUri] string idDia, [FromUri] string idLaboratorio)
        {

            List<MateriaCompleta> lstMaterias = materias.GetMaterias(idDia, idLaboratorio);

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

        [HttpGet]
        [Route("api/LaboratoriosDocentes/laboratoriosOcupados")]
        public IHttpActionResult GetLaboratoriosOcupados([FromUri] string idDia)
        {

            List<DevolucionLaboratorioDocente> lstDevolucion = devolucionLaboratorios.GetLaboratorios(idDia);

            if (lstDevolucion.Count > 0)
            {
                if (!String.IsNullOrEmpty(lstDevolucion[0].mensajeError))
                {
                    return Content(HttpStatusCode.NotFound, lstDevolucion[0].mensajeError);
                }
                else
                {
                    return Content(HttpStatusCode.OK, lstDevolucion);
                }
            }
            else
            {
                return Content(HttpStatusCode.OK, lstDevolucion);
            }

        }

        public IHttpActionResult PostLabDocentes(LaboratorioDocente laboratorio)
        {

            LaboratorioDocente laboratorioDocente = laboratorios.PostLabDocente(laboratorio);

            if (!String.IsNullOrEmpty(laboratorioDocente.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, laboratorioDocente.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, laboratorioDocente);
            }

        }

        public IHttpActionResult PutLabDocentes(string idLaboratorio)
        {

            LaboratorioDocente laboratorioDocente = laboratorios.PutLabDocente(idLaboratorio);

            if (!String.IsNullOrEmpty(laboratorioDocente.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, laboratorioDocente.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, laboratorioDocente);
            }

        }


    }

}
