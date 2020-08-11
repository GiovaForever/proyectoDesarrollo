using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class EstudiantesDAL
    {

        public EstudiantesDAL() { }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }

        public List<Estudiante> GetEstudiantes()
        {
            try
            {
                List<Estudiante> lista = new List<Estudiante>();

                string sql = @"SELECT * FROM Estudiantes ORDER BY apellidoEstudiante ASC";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader(CommandBehavior.CloseConnection);

                        while (reader.Read())
                        {
                            Estudiante estudiante = new Estudiante();
                            estudiante.cedulaEstudiante = reader["cedulaEstudiante"].ToString();
                            estudiante.nombreEstudiante = reader["nombreEstudiante"].ToString();
                            estudiante.apellidoEstudiante = reader["apellidoEstudiante"].ToString();
                            estudiante.telefonoEstudiante = reader["telefonoEstudiante"].ToString();
                            lista.Add(estudiante);
                        }
                        reader.Close();
                    }
                }
                return lista;
            }
            catch (Exception ex)
            {
                return new List<Estudiante>
                {
                    new Estudiante
                    {
                        mensajeError=ex.Message
                    }
                };
            }
        }

        public Estudiante PostEstudiante(Estudiante estudiante)
        {

            try
            {
                Estudiante estudianteR = new Estudiante();

                string sql = @"INSERT INTO Estudiantes 
                               VALUES (@cedula, @nombre, @apellido,@telefono)";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@cedula", estudiante.cedulaEstudiante);
                        command.Parameters.AddWithValue("@nombre", estudiante.nombreEstudiante);
                        command.Parameters.AddWithValue("@apellido", estudiante.apellidoEstudiante);
                        command.Parameters.AddWithValue("@telefono", estudiante.telefonoEstudiante);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }

                return estudianteR;

            }
            catch (Exception ex)
            {
                return new Estudiante
                {
                    mensajeError = ex.Message
                };
            }
        }

        public Estudiante DeleteEstudiante(string cedula)
        {
            try
            {

                Estudiante estudiante = new Estudiante();

                string sql = @"DELETE FROM Estudiantes
                         WHERE cedulaEstudiante = @cedula";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@cedula", cedula);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
                return estudiante;

            }
            catch (Exception ex)
            {

                return new Estudiante
                {
                    mensajeError = ex.Message
                };

            }
        }

        public Estudiante UpdateEstudiante(Estudiante estudiante)
        {

            try
            {
                Estudiante estudianteR = new Estudiante();

                string sql = @"UPDATE Estudiantes
                           SET nombreEstudiante = @nombre, 
                               apellidoEstudiante = @apellido, 
                               telefonoEstudiante=@telefono
                           WHERE cedulaEstudiante = @cedula";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@cedula", estudiante.cedulaEstudiante);
                        command.Parameters.AddWithValue("@nombre", estudiante.nombreEstudiante);
                        command.Parameters.AddWithValue("@apellido", estudiante.apellidoEstudiante);
                        command.Parameters.AddWithValue("@telefono", estudiante.telefonoEstudiante);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
                return estudianteR;
            }
            catch (Exception ex)
            {
                return new Estudiante
                {
                    mensajeError = ex.Message
                };
            }

        }

    }
}