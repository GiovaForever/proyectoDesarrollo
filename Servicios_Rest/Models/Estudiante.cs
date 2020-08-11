using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class Estudiante
    {
        public string cedulaEstudiante { get; set; }
        public string nombreEstudiante { get; set; }
        public string apellidoEstudiante { get; set; }
        public string telefonoEstudiante { get; set; }
        public string mensajeError { get; set; }

        public Estudiante()
        {
        }

    }
}