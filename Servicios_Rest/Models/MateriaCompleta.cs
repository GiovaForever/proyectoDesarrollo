using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class MateriaCompleta
    {

        public string idMateria { get; set; }
        public string nombreMateria { get; set; }
        public string cedulaDocente { get; set; }
        public string nombreDocente { get; set; }
        public string apellidoDocente { get; set; }
        public string horarioMateria { get; set; }
        public string mensajeError { get; set; }

        public MateriaCompleta()
        {
        }

    }
}