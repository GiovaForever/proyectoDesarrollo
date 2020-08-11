using Servicios_Rest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Servicios_Rest.Controllers
{
    public class InvitadosController : ApiController
    {

        private InvitadosDAL invitados;

        public InvitadosController()
        {
            invitados = new InvitadosDAL();
        }

        public IHttpActionResult GetInvitados()
        {

            List<Invitado> lstInvitados = invitados.GetInvitados();

            if (lstInvitados.Count > 0)
            {
                if (!String.IsNullOrEmpty(lstInvitados[0].mensajeError))
                {
                    return Content(HttpStatusCode.NotFound, lstInvitados[0].mensajeError);
                }
                else
                {
                    return Content(HttpStatusCode.OK, lstInvitados);
                }
            }
            else
            {
                return Content(HttpStatusCode.OK, lstInvitados);
            }

        }
        public IHttpActionResult PostInvitados(Invitado invitado)
        {

            Invitado invitadoR = invitados.PostInvitado(invitado);

            if (!String.IsNullOrEmpty(invitadoR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, invitadoR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, invitadoR);
            }

        }
        public IHttpActionResult DeleteInvitados([FromBody]string cedula)
        {

            Invitado invitadoR = invitados.DeleteInvitado(cedula);

            if (!String.IsNullOrEmpty(invitadoR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, invitadoR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, invitadoR);
            }

        }
        public IHttpActionResult PutInvitados(Invitado invitado)
        {

            Invitado invitadoR = invitados.UpdateInvitado(invitado);

            if (!String.IsNullOrEmpty(invitadoR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, invitadoR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, invitadoR);
            }

        }

    }
}
