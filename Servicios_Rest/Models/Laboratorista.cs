using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class Laboratorista
    {

        public string cedulaLaboratorista { get; set; }
        public string nombreLaboratorista { get; set; }
        public string apellidoLaboratorista { get; set; }
        public string telefonoLaboratorista { get; set; }
        public string mensajeError { get; set; }

        public Laboratorista()
        {
        }

    }
}