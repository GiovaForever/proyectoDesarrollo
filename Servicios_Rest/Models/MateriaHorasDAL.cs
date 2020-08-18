using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class MateriaHorasDAL
    {

        public MateriaHorasDAL() { }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }

        public List<MateriaHoras> GetHoras(string idMateria, string idDia)
        {
            try
            {
                List<MateriaHoras> lista = new List<MateriaHoras>();

                string sql = @"SELECT H.idHora,H.horaInicio,H.horaFin 
                                FROM Laboratorios_Horas LH
                                INNER JOIN Horas H ON LH.idHora=H.idHora
                                WHERE LH.idMateria=@idMateria and LH.idDia=@idDia
                                ORDER BY H.idHora ASC";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        connection.Open();
                        command.Parameters.AddWithValue("@idMateria", idMateria);
                        command.Parameters.AddWithValue("@idDia", idDia);
                        SqlDataReader reader = command.ExecuteReader(CommandBehavior.CloseConnection);

                        while (reader.Read())
                        {
                            MateriaHoras horas = new MateriaHoras()
                            {
                                horaInicio = reader["horaInicio"].ToString(),
                                horaFin = reader["horaFin"].ToString()
                            };
                            lista.Add(horas);
                        }
                        reader.Close();
                    }
                }
                return lista;
            }
            catch (Exception ex)
            {
                return new List<MateriaHoras>
                {
                    new MateriaHoras
                    {
                        mensajeError=ex.Message
                    }
                };
            }
        }

    }
}