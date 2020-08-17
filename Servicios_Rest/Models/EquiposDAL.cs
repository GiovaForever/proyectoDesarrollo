using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class EquiposDAL
    {

        public EquiposDAL() { }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }


        public Equipo PostEquipo(Equipo equipoInsert)
        {

            try
            {
                Equipo Equipo = new Equipo();
                Equipo = DeleteEquipo(equipoInsert.idLaboratorio);

                if (String.IsNullOrEmpty(Equipo.mensajeError))
                {
                    string sql = @"INSERT INTO Laboratorios_Equipos
                               VALUES (@idLaboratorio, @idEquipo, @descripcion)";

                    using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                    {
                        connection.Open();

                        foreach (var item in equipoInsert.lstEquipos)
                        {

                            using (SqlCommand command = new SqlCommand(sql, connection))
                            {
                                command.Parameters.AddWithValue("@idLaboratorio", equipoInsert.idLaboratorio);
                                var idEquipo = item[0];
                                command.Parameters.AddWithValue("@idEquipo", idEquipo);
                                var descripcion = item[1];
                                command.Parameters.AddWithValue("@descripcion", descripcion);
                                command.ExecuteNonQuery();
                            }

                        }
                        connection.Close();
                    }
                }

                return Equipo;

            }
            catch (Exception ex)
            {
                return new Equipo
                {
                    mensajeError = ex.Message
                };
            }
        }

        public Equipo DeleteEquipo(string idLaboratorio)
        {
            try
            {

                Equipo Equipo = new Equipo();

                string sql = @"DELETE FROM Laboratorios_Equipos
                         WHERE idLaboratorio = @idLaboratorio";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@idLaboratorio", idLaboratorio);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }
                return Equipo;

            }
            catch (Exception ex)
            {

                return new Equipo
                {
                    mensajeError = ex.Message
                };

            }
        }

    }
}