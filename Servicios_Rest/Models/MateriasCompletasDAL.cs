using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class MateriasCompletasDAL
    {
        MateriaHorasDAL materia;
        public MateriasCompletasDAL() { materia = new MateriaHorasDAL(); }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }

        public List<MateriaCompleta> GetMaterias(string idDia,string idLaboratorio)
        {
            try
            {
                List<MateriaCompleta> lista = new List<MateriaCompleta>();

                string sql = @"SELECT DISTINCT(LH.idMateria),M.nombreMateria,M.cedulaDocente,D.nombreDocente,D.apellidoDocente
                                FROM Laboratorios_Horas LH
                                INNER JOIN Materias M ON LH.idMateria=M.idMateria
                                INNER JOIN Docentes D ON M.cedulaDocente=D.cedulaDocente
                                WHERE LH.idDia=@idDia AND LH.idLaboratorio=@idLaboratorio";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        connection.Open();
                        command.Parameters.AddWithValue("@idDia", idDia);
                        command.Parameters.AddWithValue("@idLaboratorio", idLaboratorio);
                        SqlDataReader reader = command.ExecuteReader(CommandBehavior.CloseConnection);

                        while (reader.Read())
                        {
                            MateriaCompleta materiaCompleta = new MateriaCompleta()
                            {
                                idMateria = reader["idMateria"].ToString(),
                                nombreMateria = reader["nombreMateria"].ToString(),
                                cedulaDocente = reader["cedulaDocente"].ToString(),
                                nombreDocente = reader["nombreDocente"].ToString(),
                                apellidoDocente = reader["apellidoDocente"].ToString(),
                                horarioMateria = obtenerHorario(reader["idMateria"].ToString(), idDia)
                            };
                            if (!materiaCompleta.horarioMateria.Equals(""))
                            {
                                lista.Add(materiaCompleta);
                            }
                            else
                            {
                                return new List<MateriaCompleta>
                                {
                                    new MateriaCompleta { mensajeError="Ha Ocurrido Un Error" }
                                };
                            }

                        }
                        reader.Close();
                    }
                }
                return lista;
            }
            catch (Exception ex)
            {
                return new List<MateriaCompleta>
                {
                    new MateriaCompleta
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