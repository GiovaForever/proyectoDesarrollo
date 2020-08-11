using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class LaboratoristasDAL
    {

        public LaboratoristasDAL() { }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }

        public List<Laboratorista> GetLaboratoristas()
        {
            try
            {
                List<Laboratorista> lista = new List<Laboratorista>();

                string sql = @"SELECT * FROM Laboratoristas ORDER BY apellidoLaboratorista ASC";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader(CommandBehavior.CloseConnection);

                        while (reader.Read())
                        {
                            Laboratorista Laboratorista = new Laboratorista();
                            Laboratorista.cedulaLaboratorista = reader["cedulaLaboratorista"].ToString();
                            Laboratorista.nombreLaboratorista = reader["nombreLaboratorista"].ToString();
                            Laboratorista.apellidoLaboratorista = reader["apellidoLaboratorista"].ToString();
                            Laboratorista.telefonoLaboratorista = reader["telefonoLaboratorista"].ToString();
                            lista.Add(Laboratorista);
                        }
                        reader.Close();
                    }
                }
                return lista;
            }
            catch (Exception ex)
            {
                return new List<Laboratorista>
                {
                    new Laboratorista
                    {
                        mensajeError=ex.Message
                    }
                };
            }
        }

        public Laboratorista PostLaboratorista(Laboratorista Laboratorista)
        {

            try
            {
                Laboratorista LaboratoristaR = new Laboratorista();

                string sql = @"INSERT INTO Laboratoristas 
                               VALUES (@cedula, @nombre, @apellido,@telefono)";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@cedula", Laboratorista.cedulaLaboratorista);
                        command.Parameters.AddWithValue("@nombre", Laboratorista.nombreLaboratorista);
                        command.Parameters.AddWithValue("@apellido", Laboratorista.apellidoLaboratorista);
                        command.Parameters.AddWithValue("@telefono", Laboratorista.telefonoLaboratorista);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }

                return LaboratoristaR;

            }
            catch (Exception ex)
            {
                return new Laboratorista
                {
                    mensajeError = ex.Message
                };
            }
        }

        public Laboratorista DeleteLaboratorista(string cedula)
        {
            try
            {

                Laboratorista Laboratorista = new Laboratorista();

                string sql = @"DELETE FROM Laboratoristas
                         WHERE cedulaLaboratorista = @cedula";

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
                return Laboratorista;

            }
            catch (Exception ex)
            {

                return new Laboratorista
                {
                    mensajeError = ex.Message
                };

            }
        }

        public Laboratorista UpdateLaboratorista(Laboratorista Laboratorista)
        {

            try
            {
                Laboratorista LaboratoristaR = new Laboratorista();

                string sql = @"UPDATE Laboratoristas
                           SET nombreLaboratorista = @nombre, 
                               apellidoLaboratorista = @apellido, 
                               telefonoLaboratorista=@telefono
                           WHERE cedulaLaboratorista = @cedula";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@cedula", Laboratorista.cedulaLaboratorista);
                        command.Parameters.AddWithValue("@nombre", Laboratorista.nombreLaboratorista);
                        command.Parameters.AddWithValue("@apellido", Laboratorista.apellidoLaboratorista);
                        command.Parameters.AddWithValue("@telefono", Laboratorista.telefonoLaboratorista);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
                return LaboratoristaR;
            }
            catch (Exception ex)
            {
                return new Laboratorista
                {
                    mensajeError = ex.Message
                };
            }

        }

    }
}