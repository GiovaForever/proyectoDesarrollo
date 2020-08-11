using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class InventariosDAL
    {

        public InventariosDAL() { }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }

        public List<Inventario> GetInventarios()
        {
            try
            {
                List<Inventario> lista = new List<Inventario>();

                string sql = @"SELECT * 
                                FROM Inventarios I 
                                INNER JOIN Categorias C ON I.idCategoria=C.idCategoria";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader(CommandBehavior.CloseConnection);

                        while (reader.Read())
                        {
                            Inventario Inventario = new Inventario()
                            {
                                idInventario = reader["idInventario"].ToString(),
                                nombreInventario = reader["nombreInventario"].ToString(),
                                cantidadInventario= reader["cantidadInventario"].ToString(),
                                idCategoria = reader["idCategoria"].ToString(),
                                nombreCategoria = reader["nombreCategoria"].ToString()
                            };
                            lista.Add(Inventario);
                        }
                        reader.Close();
                    }
                }
                return lista;
            }
            catch (Exception ex)
            {
                return new List<Inventario>
                {
                    new Inventario
                    {
                        mensajeError=ex.Message
                    }
                };
            }
        }

        public Inventario PostInventario(Inventario inventario)
        {

            try
            {
                Inventario inventarioR = new Inventario();

                string sql = @"INSERT INTO Inventarios(nombreInventario,cantidadInventario,idCategoria)
                                           VALUES(@nombre,@cantidad,@idCategoria);";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@nombre", inventario.nombreInventario);
                        command.Parameters.AddWithValue("@cantidad", inventario.cantidadInventario);
                        command.Parameters.AddWithValue("@idCategoria", inventario.idCategoria);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }

                return inventarioR;

            }
            catch (Exception ex)
            {
                return new Inventario
                {
                    mensajeError = ex.Message
                };
            }
        }

        public Inventario DeleteInventario(string id)
        {
            try
            {

                Inventario Inventario = new Inventario();

                string sql = @"DELETE From Inventarios 
                               WHERE idInventario=@id;";

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
                return Inventario;

            }
            catch (Exception ex)
            {

                return new Inventario
                {
                    mensajeError = ex.Message
                };

            }
        }

        public Inventario UpdateInventario(Inventario inventario)
        {

            try
            {
                Inventario inventarioR = new Inventario();

                string sql = @"UPDATE Inventarios
                                SET nombreInventario=@nombre,
	                                cantidadInventario=@cantidad,
	                                idCategoria=@idCategoria
                                WHERE idInventario=@id;";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@nombre", inventario.nombreInventario);
                        command.Parameters.AddWithValue("@cantidad", inventario.cantidadInventario);
                        command.Parameters.AddWithValue("@idCategoria", inventario.idCategoria);
                        command.Parameters.AddWithValue("@id", inventario.idInventario);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
                return inventarioR;
            }
            catch (Exception ex)
            {
                return new Inventario
                {
                    mensajeError = ex.Message
                };
            }

        }

    }
}