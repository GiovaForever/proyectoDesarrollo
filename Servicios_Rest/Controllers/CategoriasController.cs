using Servicios_Rest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Servicios_Rest.Controllers
{
    public class CategoriasController : ApiController
    {

        private CategoriasDAL Categorias;

        public CategoriasController()
        {
            Categorias = new CategoriasDAL();
        }

        public IHttpActionResult GetCategorias()
        {

            List<Categoria> lstCategoria = Categorias.GetCategorias();

            if (lstCategoria.Count > 0)
            {
                if (!String.IsNullOrEmpty(lstCategoria[0].mensajeError))
                {
                    return Content(HttpStatusCode.NotFound, lstCategoria[0].mensajeError);
                }
                else
                {
                    return Content(HttpStatusCode.OK, lstCategoria);
                }
            }
            else
            {
                return Content(HttpStatusCode.OK, lstCategoria);
            }

        }

    }
}
