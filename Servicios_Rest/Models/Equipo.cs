using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class Equipo
    {
        public string idLaboratorio { get; set; }
        public List<List<string>> lstEquipos { get; set; }
        public string mensajeError { get; set; }

        public Equipo()
        {
        }

    }
}