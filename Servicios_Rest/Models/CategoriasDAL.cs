using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class CategoriasDAL
    {

        public CategoriasDAL() { }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }

        public List<Categoria> GetCategorias()
        {
            try
            {
                List<Categoria> lista = new List<Categoria>();

                string sql = @"SELECT * FROM Categorias ORDER BY nombreCategoria ASC";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader(CommandBehavior.CloseConnection);

                        while (reader.Read())
                        {
                            Categoria Categoria = new Categoria();
                            Categoria.idCategoria = reader["idCategoria"].ToString();
                            Categoria.nombreCategoria = reader["nombreCategoria"].ToString();
                            lista.Add(Categoria);
                        }
                        reader.Close();
                    }
                }
                return lista;
            }
            catch (Exception ex)
            {
                return new List<Categoria>
                {
                    new Categoria
                    {
                        mensajeError=ex.Message
                    }
                };
            }
        }

    }
}