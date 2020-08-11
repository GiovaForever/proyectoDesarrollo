using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class Categoria
    {

        public string idCategoria { get; set; }
        public string nombreCategoria { get; set; }
        public string mensajeError { get; set; }

        public Categoria()
        {
        }

    }
}