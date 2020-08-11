using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class MateriasDAL
    {

        public MateriasDAL() { }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }

        public List<Materia> GetMaterias()
        {
            try
            {
                List<Materia> lista = new List<Materia>();

                string sql = @"SELECT * 
                                FROM Materias M
                                INNER JOIN Docentes D ON M.cedulaDocente=D.cedulaDocente
                                INNER JOIN Carreras C ON M.idCarrera=C.idCarrera";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader(CommandBehavior.CloseConnection);

                        while (reader.Read())
                        {
                            Materia materia = new Materia()
                            {
                                idMateria = reader["idMateria"].ToString(),
                                nombreMateria = reader["nombreMateria"].ToString(),
                                cedulaDocente = reader["cedulaDocente"].ToString(),
                                nombreDocente = reader["nombreDocente"].ToString(),
                                apellidoDocente = reader["apellidoDocente"].ToString(),
                                idCarrera = reader["idCarrera"].ToString(),
                                nombreCarrera = reader["nombreCarrera"].ToString(),
                                nivelMateria = reader["nivelMateria"].ToString()
                            };
                            lista.Add(materia);
                        }
                        reader.Close();
                    }
                }
                return lista;
            }
            catch (Exception ex)
            {
                return new List<Materia>
                {
                    new Materia
                    {
                        mensajeError=ex.Message
                    }
                };
            }
        }

        public Materia PostMateria(Materia materia)
        {

            try
            {
                Materia materiaR = new Materia();

                string sql = @"INSERT INTO Materias(nombreMateria,cedulaDocente,idCarrera,nivelMateria)
                                           VALUES(@nombre,@cedula,@idCarrera,@nivel);";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@nombre", materia.nombreMateria);
                        command.Parameters.AddWithValue("@cedula", materia.cedulaDocente);
                        command.Parameters.AddWithValue("@idCarrera", materia.idCarrera);
                        command.Parameters.AddWithValue("@nivel", materia.nivelMateria);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }

                return materiaR;

            }
            catch (Exception ex)
            {
                return new Materia
                {
                    mensajeError = ex.Message
                };
            }
        }

        public Materia DeleteMateria(string id)
        {
            try
            {

                Materia materia = new Materia();

                string sql = @"DELETE From Materias 
                               WHERE idMateria=@id;";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@id", id);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
                return materia;

            }
            catch (Exception ex)
            {

                return new Materia
                {
                    mensajeError = ex.Message
                };

            }
        }

        public Materia UpdateMateria(Materia materia)
        {

            try
            {
                Materia materiaR = new Materia();

                string sql = @"UPDATE Materias
                                SET nombreMateria=@nombre,
	                                cedulaDocente=@cedula,
	                                idCarrera=@idCarrera,
	                                nivelMateria=@nivel
                                WHERE idMateria=@id;";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@nombre", materia.nombreMateria);
                        command.Parameters.AddWithValue("@cedula", materia.cedulaDocente);
                        command.Parameters.AddWithValue("@idCarrera", materia.idCarrera);
                        command.Parameters.AddWithValue("@nivel", materia.nivelMateria);
                        command.Parameters.AddWithValue("@id", materia.idMateria);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
                return materiaR;
            }
            catch (Exception ex)
            {
                return new Materia
                {
                    mensajeError = ex.Message
                };
            }

        }

    }
}