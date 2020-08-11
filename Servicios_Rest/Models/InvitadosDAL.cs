using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class InvitadosDAL
    {

        public InvitadosDAL() { }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }

        public List<Invitado> GetInvitados()
        {
            try
            {
                List<Invitado> lista = new List<Invitado>();

                string sql = @"SELECT * FROM Invitados ORDER BY apellidoInvitado ASC";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader(CommandBehavior.CloseConnection);

                        while (reader.Read())
                        {
                            Invitado Invitado = new Invitado();
                            Invitado.cedulaInvitado = reader["cedulaInvitado"].ToString();
                            Invitado.nombreInvitado = reader["nombreInvitado"].ToString();
                            Invitado.apellidoInvitado = reader["apellidoInvitado"].ToString();
                            Invitado.telefonoInvitado = reader["telefonoInvitado"].ToString();
                            lista.Add(Invitado);
                        }
                        reader.Close();
                    }
                }
                return lista;
            }
            catch (Exception ex)
            {
                return new List<Invitado>
                {
                    new Invitado
                    {
                        mensajeError=ex.Message
                    }
                };
            }
        }

        public Invitado PostInvitado(Invitado Invitado)
        {

            try
            {
                Invitado InvitadoR = new Invitado();

                string sql = @"INSERT INTO Invitados 
                               VALUES (@cedula, @nombre, @apellido,@telefono)";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@cedula", Invitado.cedulaInvitado);
                        command.Parameters.AddWithValue("@nombre", Invitado.nombreInvitado);
                        command.Parameters.AddWithValue("@apellido", Invitado.apellidoInvitado);
                        command.Parameters.AddWithValue("@telefono", Invitado.telefonoInvitado);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }

                return InvitadoR;

            }
            catch (Exception ex)
            {
                return new Invitado
                {
                    mensajeError = ex.Message
                };
            }
        }

        public Invitado DeleteInvitado(string cedula)
        {
            try
            {

                Invitado Invitado = new Invitado();

                string sql = @"DELETE FROM Invitados
                         WHERE cedulaInvitado = @cedula";

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
                return Invitado;

            }
            catch (Exception ex)
            {

                return new Invitado
                {
                    mensajeError = ex.Message
                };

            }
        }

        public Invitado UpdateInvitado(Invitado Invitado)
        {

            try
            {
                Invitado InvitadoR = new Invitado();

                string sql = @"UPDATE Invitados
                           SET nombreInvitado = @nombre, 
                               apellidoInvitado = @apellido, 
                               telefonoInvitado=@telefono
                           WHERE cedulaInvitado = @cedula";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@cedula", Invitado.cedulaInvitado);
                        command.Parameters.AddWithValue("@nombre", Invitado.nombreInvitado);
                        command.Parameters.AddWithValue("@apellido", Invitado.apellidoInvitado);
                        command.Parameters.AddWithValue("@telefono", Invitado.telefonoInvitado);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
                return InvitadoR;
            }
            catch (Exception ex)
            {
                return new Invitado
                {
                    mensajeError = ex.Message
                };
            }

        }

    }
}