using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class LaboratorioHorario
    {

        public string idLaboratorio { get; set; }
        public string nombreLaboratorio { get; set; }
        public string ubicacionLaboratorio { get; set; }
        public string nombreTipoLaboratorio { get; set; }
        public string mensajeError { get; set; }

        public LaboratorioHorario()
        {
        }

    }
}