using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class Invitado
    {

        public string cedulaInvitado { get; set; }
        public string nombreInvitado { get; set; }
        public string apellidoInvitado { get; set; }
        public string telefonoInvitado { get; set; }
        public string mensajeError { get; set; }

        public Invitado()
        {
        }

    }
}