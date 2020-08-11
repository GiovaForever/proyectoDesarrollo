using Servicios_Rest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Servicios_Rest.Controllers
{
    public class InventariosController : ApiController
    {

        private InventariosDAL Inventarios;

        public InventariosController()
        {
            Inventarios = new InventariosDAL();
        }

        public IHttpActionResult GetInventarios()
        {

            List<Inventario> lstInventarios = Inventarios.GetInventarios();

            if (lstInventarios.Count > 0)
            {
                if (!String.IsNullOrEmpty(lstInventarios[0].mensajeError))
                {
                    return Content(HttpStatusCode.NotFound, lstInventarios[0].mensajeError);
                }
                else
                {
                    return Content(HttpStatusCode.OK, lstInventarios);
                }
            }
            else
            {
                return Content(HttpStatusCode.OK, lstInventarios);
            }

        }

        public IHttpActionResult PostInventarios(Inventario inventario)
        {

            Inventario inventarioR = Inventarios.PostInventario(inventario);

            if (!String.IsNullOrEmpty(inventarioR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, inventarioR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, inventarioR);
            }

        }
        public IHttpActionResult DeleteInventarios([FromBody]string id)
        {

            Inventario inventarioR = Inventarios.DeleteInventario(id);

            if (!String.IsNullOrEmpty(inventarioR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, inventarioR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, inventarioR);
            }

        }
        public IHttpActionResult PutInventarios(Inventario inventario)
        {

            Inventario inventarioR = Inventarios.UpdateInventario(inventario);

            if (!String.IsNullOrEmpty(inventarioR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, inventarioR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, inventarioR);
            }

        }

    }
}
