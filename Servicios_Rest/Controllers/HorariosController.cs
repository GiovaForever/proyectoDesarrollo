using Servicios_Rest.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Servicios_Rest.Controllers
{
    public class HorariosController : ApiController
    {

        HorariosDAL horarios;
        EquiposDAL equipos;

        public HorariosController()
        {
            horarios = new HorariosDAL();
            equipos = new EquiposDAL();
        }

        public IHttpActionResult PostLaboratoriosHorario(Horario horario)
        {

            Horario horarioR = horarios.PostHorario(horario);

            if (!String.IsNullOrEmpty(horarioR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, horarioR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, horarioR);
            }

        }

        [HttpPost]
        [Route("api/Horarios/Equipos")]
        public IHttpActionResult PostLaboratoriosEquipos(Equipo equipo)
        {

            Equipo equipoR = equipos.PostEquipo(equipo);

            if (!String.IsNullOrEmpty(equipoR.mensajeError))
            {
                return Content(HttpStatusCode.NotFound, equipoR.mensajeError);
            }
            else
            {
                return Content(HttpStatusCode.OK, equipoR);
            }

        }

    }

}
