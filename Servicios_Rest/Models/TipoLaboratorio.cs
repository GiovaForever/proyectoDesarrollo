using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class TipoLaboratorio
    {

        public string idTipoLaboratorio { get; set; }
        public string nombreTipoLaboratorio { get; set; }
        public string mensajeError { get; set; }

        public TipoLaboratorio()
        {
        }

    }
}