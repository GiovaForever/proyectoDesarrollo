using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class MateriaHoras
    {

        public string horaInicio { get; set; }
        public string horaFin { get; set; }
        public string mensajeError { get; set; }

        public MateriaHoras()
        {
        }

    }
}