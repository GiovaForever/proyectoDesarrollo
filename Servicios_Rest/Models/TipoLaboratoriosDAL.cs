using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class TipoLaboratoriosDAL
    {

        public TipoLaboratoriosDAL() { }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }

        public List<TipoLaboratorio> GetTipoLaboratorios()
        {
            try
            {
                List<TipoLaboratorio> lista = new List<TipoLaboratorio>();

                string sql = @"SELECT * FROM Tipo_Laboratorios ORDER BY nombreTipoLaboratorio ASC";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader(CommandBehavior.CloseConnection);

                        while (reader.Read())
                        {
                            TipoLaboratorio tipoLaboratorio = new TipoLaboratorio();
                            tipoLaboratorio.idTipoLaboratorio = reader["idTipoLaboratorio"].ToString();
                            tipoLaboratorio.nombreTipoLaboratorio = reader["nombreTipoLaboratorio"].ToString();
                            lista.Add(tipoLaboratorio);
                        }
                        reader.Close();
                    }
                }
                return lista;
            }
            catch (Exception ex)
            {
                return new List<TipoLaboratorio>
                {
                    new TipoLaboratorio
                    {
                        mensajeError=ex.Message
                    }
                };
            }
        }

    }
}