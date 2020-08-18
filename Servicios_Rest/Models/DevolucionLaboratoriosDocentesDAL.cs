using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class DevolucionLaboratoriosDocentesDAL
    {

        MateriaHorasDAL materia;
        public DevolucionLaboratoriosDocentesDAL() { materia = new MateriaHorasDAL(); }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }

        public List<DevolucionLaboratorioDocente> GetLaboratorios(string idDia)
        {
            try
            {
                List<DevolucionLaboratorioDocente> lista = new List<DevolucionLaboratorioDocente>();

                string sql = @"SELECT LD.idLabDocente,LD.fechaPrestamo,L.nombreLaboratorista,L.apellidoLaboratorista,LAB.idLaboratorio,LAB.nombreLaboratorio,
		                                TL.nombreTipoLaboratorio,M.idMateria,M.nombreMateria,D.nombreDocente,D.apellidoDocente
                                FROM Laboratorios_Docentes LD
                                INNER JOIN Laboratoristas L ON L.cedulaLaboratorista=LD.cedulaLaboratorista AND LD.estadoPrestamo='0'
                                INNER JOIN Laboratorios LAB ON LD.idLaboratorio=LAB.idLaboratorio
                                INNER JOIN Tipo_Laboratorios TL ON LAB.idTipoLaboratorio=TL.idTipoLaboratorio
                                INNER JOIN Materias M ON LD.idMateria=M.idMateria
                                INNER JOIN Docentes D ON M.cedulaDocente=D.cedulaDocente";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader(CommandBehavior.CloseConnection);

                        while (reader.Read())
                        {
                            DevolucionLaboratorioDocente devolucionLaboratorioDocente = new DevolucionLaboratorioDocente()
                            {
                                idLabDocente = reader["idLabDocente"].ToString(),
                                fechaPrestamo = Convert.ToDateTime(reader["fechaPrestamo"].ToString()).ToShortDateString(),
                                nombreLaboratorista = reader["nombreLaboratorista"].ToString(),
                                apellidoLaboratorista = reader["apellidoLaboratorista"].ToString(),
                                idLaboratorio = reader["idLaboratorio"].ToString(),
                                nombreLaboratorio = reader["nombreLaboratorio"].ToString(),
                                nombreTipoLaboratorio = reader["nombreTipoLaboratorio"].ToString(),
                                idMateria = reader["idMateria"].ToString(),
                                nombreMateria = reader["nombreMateria"].ToString(),
                                nombreDocente = reader["nombreDocente"].ToString(),
                                apellidoDocente = reader["apellidoDocente"].ToString(),
                                horario = obtenerHorario(reader["idMateria"].ToString(), idDia)
                            };
                            lista.Add(devolucionLaboratorioDocente);
                        }
                        reader.Close();
                    }
                }
                return lista;
            }
            catch (Exception ex)
            {
                return new List<DevolucionLaboratorioDocente>
                {
                    new DevolucionLaboratorioDocente
                    {
                        mensajeError=ex.Message
                    }
                };
            }
        }

        private string obtenerHorario(string idMateria, string idDia)
        {

            List<MateriaHoras> lstHorario = materia.GetHoras(idMateria, idDia);

            if (String.IsNullOrEmpty(lstHorario[0].mensajeError))
            {
                string horario = Convert.ToDateTime(lstHorario[0].horaInicio).ToShortTimeString() + " - " + Convert.ToDateTime(lstHorario[lstHorario.Count - 1].horaFin).ToShortTimeString();
                return horario;
            }

            return "";

        }

    }

}