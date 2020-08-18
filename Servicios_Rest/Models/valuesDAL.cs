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

        public List<string> GetIdPrestDocentes()
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
                                        FROM Prestamos_Docentes";
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

        public List<string> GetIdPrestInvitados()
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
                                        FROM Prestamos_Invitados";
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

        public List<string> GetIdLaboratorioDocente()
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
                cmd.CommandText = @"SELECT ISNULL(MAX(idLabDocente),0) as numPrestamo
                                        FROM Laboratorios_Docentes";
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

        public List<string> GetIdDia()
        {

            List<string> lstResultado = new List<string>();

            try
            {

                string dia = "";

                SqlConnection conexion = new SqlConnection(GetConnectionString());
                conexion.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conexion;
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"SELECT DATENAME(dw,GETDATE()) as Dia";
                using (var dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        dia = dr["Dia"].ToString();
                    }
                }

                conexion.Close();
                lstResultado.Add("OK");
                dia = obtenerDia(dia);
                lstResultado.Add(dia);

                return lstResultado;
            }
            catch (Exception ex)
            {
                lstResultado.Add("Error");
                lstResultado.Add(ex.Message);
                return lstResultado;
            }
        }

        private string obtenerDia(string dia)
        {
            string codigo = "";
            switch (dia)
            {
                case "Monday":
                    codigo = "L";
                    break;
                case "Tuesday":
                    codigo = "M";
                    break;
                case "Wednesday":
                    codigo = "X";
                    break;
                case "Thursday":
                    codigo = "J";
                    break;
                case "Friday":
                    codigo = "V";
                    break;
            }
            return codigo;
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