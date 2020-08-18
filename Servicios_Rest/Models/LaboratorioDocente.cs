using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class LaboratorioDocente
    {

        public string idLabDocente{ get; set; }
        public string fechaPrestamo { get; set; }
        public string idLaboratorio { get; set; }
        public string cedulaLaboratorista { get; set; }
        public string idMateria { get; set; }
        public string estadoPrestamo { get; set; }
        public string mensajeError { get; set; }

        public LaboratorioDocente()
        {
        }

    }
}