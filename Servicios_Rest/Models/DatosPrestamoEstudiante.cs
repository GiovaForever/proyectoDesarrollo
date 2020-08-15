using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class DatosPrestamoEstudiante
    {

        public string idPrestamo { get; set; }
        public string fechaPrestamo { get; set; }
        public string cedulaEstudiante { get; set; }
        public string nombreEstudiante { get; set; }
        public string apellidoEstudiante { get; set; }
        public string cedulaLaboratorista { get; set; }
        public string nombreLaboratorista { get; set; }
        public string apellidoLaboratorista { get; set; }
        public string mensajeError { get; set; }

        public DatosPrestamoEstudiante()
        {
        }

    }
}