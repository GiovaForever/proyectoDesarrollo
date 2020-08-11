using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
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
