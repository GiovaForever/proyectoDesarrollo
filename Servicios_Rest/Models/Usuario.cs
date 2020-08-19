using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class Usuario
    {

        public string nombreCompletoUsuario { get; set; }
        public string correoUsuario { get; set; }
        public string passwordUsuario { get; set; }
        public string idRol { get; set; }
        public string nombreRol { get; set; }
        public string mensajeError { get; set; }

        public Usuario()
        {
        }
    }
}