using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class valuesDAL
    {

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }

        public List<string> GetIdPrestEstudiantes()
        {

            List<string> lstResultado = new List<string>();

            try
            {

                string numeroFactura = "";

                SqlConnection conexion = new SqlConnection(GetConnectionString());
                conexion.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conexion;
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"SELECT ISNULL(MAX(idPrestamo),0) as numPrestamo
                                        FROM Prestamos_Estudiantes";
                using (var dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        numeroFactura = dr["numPrestamo"].ToString();
                    }
                }

                conexion.Close();
                lstResultado.Add("OK");
                lstResultado.Add(numeroFactura);

                return lstResultado;
            }
            catch (Exception ex)
            {
                lstResultado.Add("Error");
                lstResultado.Add(ex.Message);
                return lstResultado;
            }
        }

        internal List<string> GetFechaPrestamo()
        {

            List<string> lstResultado = new List<string>();

            try
            {

                string numeroFactura = "";

                SqlConnection conexion = new SqlConnection(GetConnectionString());
                conexion.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conexion;
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"SELECT GETDATE() as fecha";
                using (var dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        DateTime fecha = Convert.ToDateTime(dr["fecha"].ToString());
                        numeroFactura = fecha.ToShortDateString();
                    }
                }

                conexion.Close();
                lstResultado.Add("OK");
                lstResultado.Add(numeroFactura);

                return lstResultado;
            }
            catch (Exception ex)
            {
                lstResultado.Add("Error");
                lstResultado.Add(ex.Message);
                return lstResultado;
            }

        }
    }
}