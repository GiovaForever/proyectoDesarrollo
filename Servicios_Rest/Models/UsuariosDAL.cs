using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class UsuariosDAL
    {

        public UsuariosDAL() { }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }

        public List<string> GetRolUsuario(Usuario usuario)
        {

            List<string> lstResultado = new List<string>();

            try
            {

                string nombreRol = "";

                SqlConnection conexion = new SqlConnection(GetConnectionString());
                conexion.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conexion;
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"SELECT R.nombreRol
                                    FROM Usuario_Roles UR
                                    INNER JOIN Usuarios U ON UR.idUsuario=U.idUsuario AND U.correoUsuario=@correo AND U.passwordUsuario=@password
                                    INNER JOIN Roles R ON UR.idRol=R.idRol";
                cmd.Parameters.AddWithValue("@correo", usuario.correoUsuario);
                cmd.Parameters.AddWithValue("@password", usuario.passwordUsuario);
                using (var dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        nombreRol = dr["nombreRol"].ToString();
                    }
                }

                if (String.IsNullOrEmpty(nombreRol))
                {
                    nombreRol = "Invitado";
                }

                conexion.Close();
                lstResultado.Add("OK");
                lstResultado.Add(nombreRol);

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