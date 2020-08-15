using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class DetPrestEstudianteDAL
    {

        public DetPrestEstudianteDAL() { }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }

        public DetallePrestamo PostDetallePrestamo(List<DetallePrestamo> detalle, string idPrestamo)
        {

            try
            {
                DetallePrestamo prestamo = new DetallePrestamo();

                string sql = @"INSERT INTO Detalle_Prestamos_Estudiantes
                               VALUES (@idPrestamo, @cantidadPrestamo, @idInventario,@observacion)";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    connection.Open();
                    foreach (var item in detalle)
                    {
                        using (SqlCommand command = new SqlCommand(sql, connection))
                        {
                            command.Parameters.AddWithValue("@idPrestamo", idPrestamo);
                            command.Parameters.AddWithValue("@cantidadPrestamo", item.cantidadPrestamo);
                            command.Parameters.AddWithValue("@idInventario", item.idInventario);
                            command.Parameters.AddWithValue("@observacion", "");
                            command.ExecuteNonQuery();
                        }
                    }
                    connection.Close();
                }

                return prestamo;

            }
            catch (Exception ex)
            {
                return new DetallePrestamo
                {
                    mensajeError = ex.Message
                };
            }
        }

        public DetallePrestamo PutDetallePrestamo(List<DetallePrestamo> detalle, string idPrestamo)
        {

            try
            {
                DetallePrestamo prestamo = new DetallePrestamo();

                string sql = @"UPDATE Detalle_Prestamos_Estudiantes
                                SET observacion='Ninguna'
                                WHERE idPrestamo=@idPrestamo
                                AND idInventario=@idInventario";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    connection.Open();
                    foreach (var item in detalle)
                    {
                        using (SqlCommand command = new SqlCommand(sql, connection))
                        {
                            command.Parameters.AddWithValue("@idPrestamo", idPrestamo);
                            command.Parameters.AddWithValue("@idInventario", item.idInventario);
                            command.ExecuteNonQuery();
                        }
                    }
                    connection.Close();
                }

                return prestamo;

            }
            catch (Exception ex)
            {
                return new DetallePrestamo
                {
                    mensajeError = ex.Message
                };
            }
        }

    }
}