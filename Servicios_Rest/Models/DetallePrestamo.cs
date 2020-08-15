using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class DetallePrestamo
    {

        public string  cantidadPrestamo{ get; set; }
        public string  idInventario{ get; set; }
        public string  observacion{ get; set; }
        public string  mensajeError{ get; set; }

        public DetallePrestamo()
        {
        }

    }
}