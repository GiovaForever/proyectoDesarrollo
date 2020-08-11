using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class Docente
    {

        public string cedulaDocente { get; set; }
        public string nombreDocente { get; set; }
        public string apellidoDocente { get; set; }
        public string telefonoDocente { get; set; }
        public string mensajeError { get; set; }

        public Docente()
        {
        }

    }
}