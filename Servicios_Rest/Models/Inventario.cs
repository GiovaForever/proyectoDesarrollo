using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class Inventario
    {

        public string idInventario { get; set; }
        public string nombreInventario { get; set; }
        public string cantidadInventario { get; set; }
        public string idCategoria { get; set; }
        public string nombreCategoria { get; set; }
        public string mensajeError { get; set; }

        public Inventario()
        {
        }

    }
}