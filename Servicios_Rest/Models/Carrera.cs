using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class Carrera
    {

        public string idCarrera { get; set; }
        public string nombreCarrera { get; set; }
        public string mensajeError { get; set; }

        public Carrera()
        {
        }

    }
}