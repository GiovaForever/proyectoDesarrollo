using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class Materia
    {

        public string idMateria { get; set; }
        public string nombreMateria { get; set; }
        public string cedulaDocente { get; set; }
        public string nombreDocente { get; set; }
        public string apellidoDocente { get; set; }
        public string nivelMateria { get; set; }
        public string idCarrera { get; set; }
        public string nombreCarrera { get; set; }
        public string mensajeError { get; set; }

        public Materia()
        {
        }

    }
}