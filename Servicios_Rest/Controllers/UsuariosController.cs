using Servicios_Rest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Servicios_Rest.Controllers
{
    public class UsuariosController : ApiController
    {

        private UsuariosDAL usuarios;

        public UsuariosController()
        {
            usuarios = new UsuariosDAL();
        }

        public IHttpActionResult GetRolUsuario(Usuario usuario)
        {
            List<string> lstResult = usuarios.GetRolUsuario(usuario);

            if (lstResult[0].Equals("Error"))
            {
                return Content(HttpStatusCode.NotFound, lstResult[1]);
            }
            else
            {
                return Content(HttpStatusCode.OK, lstResult[1]);
            }

        }

    }
}
