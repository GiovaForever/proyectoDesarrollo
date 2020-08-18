using Servicios_Rest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Servicios_Rest.Controllers
{
    public class LaboratoriosController : ApiController
    {

        private LaboratoriosDAL laboratorios;

        public LaboratoriosController()
        {
            laboratorios = new LaboratoriosDAL();
        }

        public IHttpActionResult GetLaboratorios()
        {

            List<Laboratorio> lstTipoLaboratorio = laboratorios.GetLaboratorios();

            if (lstTipoLaboratorio.Count > 0)
            {
                if (!String.IsNullOrEmpty(lstTipoLaboratorio[0].mensajeError))
                {
                    return Content(HttpStatusCode.NotFound, lstTipoLaboratorio[0].mensajeError);
                }
                else
                {
                    return Content(HttpStatusCode.OK, lstTipoLaboratorio);
                }
            }
            else
            {
                return Content(HttpStatusCode.OK, lstTipoLaboratorio);
            }

        }

        public IHttpActionResult PostLaboratorios(Laboratorio laboratorio)
        {

            Laboratorio laboratorioR = laboratorios.PostLaboratorios(laboratorio);

            if (!String.IsNullOrEmpty(laboratorioR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, laboratorioR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, laboratorioR);
            }

        }
        public IHttpActionResult Deletedocentes([FromBody]string id)
        {

            Laboratorio laboratorioR = laboratorios.DeleteLaboratorios(id);

            if (!String.IsNullOrEmpty(laboratorioR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, laboratorioR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, laboratorioR);
            }

        }
        public IHttpActionResult Putdocentes(Laboratorio laboratorio)
        {

            Laboratorio laboratorioR = laboratorios.PutLaboratorios(laboratorio);

            if (!String.IsNullOrEmpty(laboratorioR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, laboratorioR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, laboratorioR);
            }

        }

        [HttpGet]
        [Route("api/Laboratorios/detalleLaboratorio")]
        public IHttpActionResult GetLaboratoriosDetalle()
        {

            List<LaboratorioHorario> lstTipoLaboratorio = laboratorios.GetLaboratorioHorario();

            if (lstTipoLaboratorio.Count > 0)
            {
                if (!String.IsNullOrEmpty(lstTipoLaboratorio[0].mensajeError))
                {
                    return Content(HttpStatusCode.NotFound, lstTipoLaboratorio[0].mensajeError);
                }
                else
                {
                    return Content(HttpStatusCode.OK, lstTipoLaboratorio);
                }
            }
            else
            {
                return Content(HttpStatusCode.OK, lstTipoLaboratorio);
            }

        }

        [HttpGet]
        [Route("api/Laboratorios/laboratorioLibres")]
        public IHttpActionResult GetLaboratoriosLibres()
        {

            List<Laboratorio> lstTipoLaboratorio = laboratorios.GetLaboratorios();


            if (lstTipoLaboratorio.Count > 0)
            {
                if (!String.IsNullOrEmpty(lstTipoLaboratorio[0].mensajeError))
                {
                    return Content(HttpStatusCode.NotFound, lstTipoLaboratorio[0].mensajeError);
                }
                else
                {
                    lstTipoLaboratorio = lstTipoLaboratorio.Where(x => x.estadoLaboratorio == "Libre").ToList();
                    return Content(HttpStatusCode.OK, lstTipoLaboratorio);
                }
            }
            else
            {
                return Content(HttpStatusCode.OK, lstTipoLaboratorio);
            }

        }

    }
}
