using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class PrestamoUsuario
    {

        public string idPrestamo { get; set; }
        public string cedulaUsuario { get; set; }
        public string cedulaLaboratorista { get; set; }
        public string fechaPrestamo { get; set; }
        public string estadoPrestamo { get; set; }
        public string mensajeError { get; set; }
        public List<DetallePrestamo> lstDetalle { get; set; }

        public PrestamoUsuario()
        {
        }

    }
}