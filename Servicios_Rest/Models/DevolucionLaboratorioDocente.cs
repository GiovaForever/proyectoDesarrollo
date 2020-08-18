using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class DevolucionLaboratorioDocente
    {

        public string idLabDocente { get; set; }
        public string fechaPrestamo { get; set; }
        public string nombreLaboratorista { get; set; }
        public string apellidoLaboratorista { get; set; }
        public string idLaboratorio { get; set; }
        public string nombreLaboratorio { get; set; }
        public string nombreTipoLaboratorio { get; set; }
        public string idMateria { get; set; }
        public string nombreMateria { get; set; }
        public string nombreDocente { get; set; }
        public string apellidoDocente { get; set; }
        public string horario { get; set; }
        public string mensajeError { get; set; }

        public DevolucionLaboratorioDocente()
        {
        }

    }
}