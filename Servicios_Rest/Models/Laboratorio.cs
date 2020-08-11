using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class Laboratorio
    {

        public string idLaboratorio { get; set; }
        public string nombreLaboratorio { get; set; }
        public string ubicacionLaboratorio { get; set; }
        public string capacidadLaboratorio { get; set; }
        public string tipoLaboratorio { get; set; }
        public string estadoLaboratorio { get; set; }
        public string mensajeError { get; set; }

        public Laboratorio()
        {
        }

    }
}