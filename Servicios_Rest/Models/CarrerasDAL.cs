using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class CarrerasDAL
    {

        public CarrerasDAL() { }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }

        public List<Carrera> GetCarreras()
        {
            try
            {
                List<Carrera> lista = new List<Carrera>();

                string sql = @"SELECT * FROM Carreras ORDER BY nombreCarrera ASC";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader(CommandBehavior.CloseConnection);

                        while (reader.Read())
                        {
                            Carrera carrera = new Carrera();
                            carrera.idCarrera= reader["idCarrera"].ToString();
                            carrera.nombreCarrera = reader["nombreCarrera"].ToString();
                            lista.Add(carrera);
                        }
                        reader.Close();
                    }
                }
                return lista;
            }
            catch (Exception ex)
            {
                return new List<Carrera>
                {
                    new Carrera
                    {
                        mensajeError=ex.Message
                    }
                };
            }
        }

    }
}