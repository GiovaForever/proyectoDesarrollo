using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class Horario
    {
        public string idLaboratorio { get; set; }
        public List<List<string>> lstHorarios { get; set; }
        public string mensajeError { get; set; }

        public Horario()
        {
        }
    }
}