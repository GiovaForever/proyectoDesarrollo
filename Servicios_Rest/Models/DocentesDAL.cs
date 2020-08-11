using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class DocentesDAL
    {

        public DocentesDAL() { }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }

        public List<Docente> GetDocentes()
        {
            try
            {
                List<Docente> lista = new List<Docente>();

                string sql = @"SELECT * FROM Docentes ORDER BY apellidoDocente ASC";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader(CommandBehavior.CloseConnection);

                        while (reader.Read())
                        {
                            Docente Docente = new Docente();
                            Docente.cedulaDocente = reader["cedulaDocente"].ToString();
                            Docente.nombreDocente = reader["nombreDocente"].ToString();
                            Docente.apellidoDocente = reader["apellidoDocente"].ToString();
                            Docente.telefonoDocente = reader["telefonoDocente"].ToString();
                            lista.Add(Docente);
                        }
                        reader.Close();
                    }
                }
                return lista;
            }
            catch (Exception ex)
            {
                return new List<Docente>
                {
                    new Docente
                    {
                        mensajeError=ex.Message
                    }
                };
            }
        }

        public Docente PostDocente(Docente Docente)
        {

            try
            {
                Docente DocenteR = new Docente();

                string sql = @"INSERT INTO Docentes 
                               VALUES (@cedula, @nombre, @apellido,@telefono)";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@cedula", Docente.cedulaDocente);
                        command.Parameters.AddWithValue("@nombre", Docente.nombreDocente);
                        command.Parameters.AddWithValue("@apellido", Docente.apellidoDocente);
                        command.Parameters.AddWithValue("@telefono", Docente.telefonoDocente);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }

                return DocenteR;

            }
            catch (Exception ex)
            {
                return new Docente
                {
                    mensajeError = ex.Message
                };
            }
        }

        public Docente DeleteDocente(string cedula)
        {
            try
            {

                Docente Docente = new Docente();

                string sql = @"DELETE FROM Docentes
                         WHERE cedulaDocente = @cedula";

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
                return Docente;

            }
            catch (Exception ex)
            {

                return new Docente
                {
                    mensajeError = ex.Message
                };

            }
        }

        public Docente UpdateDocente(Docente Docente)
        {

            try
            {
                Docente DocenteR = new Docente();

                string sql = @"UPDATE Docentes
                           SET nombreDocente = @nombre, 
                               apellidoDocente = @apellido, 
                               telefonoDocente=@telefono
                           WHERE cedulaDocente = @cedula";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@cedula", Docente.cedulaDocente);
                        command.Parameters.AddWithValue("@nombre", Docente.nombreDocente);
                        command.Parameters.AddWithValue("@apellido", Docente.apellidoDocente);
                        command.Parameters.AddWithValue("@telefono", Docente.telefonoDocente);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
                return DocenteR;
            }
            catch (Exception ex)
            {
                return new Docente
                {
                    mensajeError = ex.Message
                };
            }

        }

    }
}