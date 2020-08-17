using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class MasPrestInvitadoDAL
    {

        public MasPrestInvitadoDAL() { }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }

        public PrestamoUsuario PostPrestamo(PrestamoUsuario maestro)
        {

            try
            {
                PrestamoUsuario prestamo = new PrestamoUsuario();

                string sql = @"INSERT INTO Prestamos_Invitados(cedulaInvitado,cedulaLaboratorista,fechaPrestamo,estadoPrestamo)
                               VALUES (@cedulaInvitado, @cedulaLaboratorista, @fecha,@estado)";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@cedulaInvitado", maestro.cedulaUsuario);
                        command.Parameters.AddWithValue("@cedulaLaboratorista", maestro.cedulaLaboratorista);
                        command.Parameters.AddWithValue("@fecha", Convert.ToDateTime(maestro.fechaPrestamo));
                        command.Parameters.AddWithValue("@estado", maestro.estadoPrestamo);
                        connection.Open();
                        command.ExecuteNonQuery();
                        //Agregar Detalle
                        DetPrestInvitadoDAL detPrestamoDAL = new DetPrestInvitadoDAL();
                        DetallePrestamo detalle = detPrestamoDAL.PostDetallePrestamo(maestro.lstDetalle, maestro.idPrestamo);

                        if (!String.IsNullOrEmpty(detalle.mensajeError))
                        {
                            prestamo.mensajeError = detalle.mensajeError;
                        }

                        connection.Close();

                    }
                }

                return prestamo;

            }
            catch (Exception ex)
            {
                return new PrestamoUsuario
                {
                    mensajeError = ex.Message
                };
            }
        }

        public List<DatosPrestamoEstudiante> GetDatosPrestamo()
        {
            try
            {
                List<DatosPrestamoEstudiante> lista = new List<DatosPrestamoEstudiante>();

                string sql = @"SELECT * 
                                FROM vstDatosPrestamoInvitado
                                ORDER BY idPrestamo ASC";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader(CommandBehavior.CloseConnection);

                        while (reader.Read())
                        {
                            DatosPrestamoEstudiante datosPrestamoEstudiante = new DatosPrestamoEstudiante()
                            {
                                idPrestamo = reader["idPrestamo"].ToString(),
                                fechaPrestamo = Convert.ToDateTime(reader["fechaPrestamo"].ToString()).ToShortDateString(),
                                cedulaEstudiante = reader["cedulaInvitado"].ToString(),
                                nombreEstudiante = reader["nombreInvitado"].ToString(),
                                apellidoEstudiante = reader["apellidoInvitado"].ToString(),
                                cedulaLaboratorista = reader["cedulaLaboratorista"].ToString(),
                                nombreLaboratorista = reader["nombreLaboratorista"].ToString(),
                                apellidoLaboratorista = reader["apellidoLaboratorista"].ToString()
                            };

                            lista.Add(datosPrestamoEstudiante);
                        }
                        reader.Close();
                    }
                }
                return lista;
            }
            catch (Exception ex)
            {
                return new List<DatosPrestamoEstudiante>
                {
                    new DatosPrestamoEstudiante
                    {
                        mensajeError=ex.Message
                    }
                };
            }
        }

        public List<DatosDetallePrestamosEst> GetDetallePrestamo(string idPrestamo)
        {
            try
            {
                List<DatosDetallePrestamosEst> lista = new List<DatosDetallePrestamosEst>();

                string sql = @"SELECT * 
                                FROM vstDetallePrestamosInv
                                WHERE idPrestamo=@idPrestamo";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@idPrestamo", idPrestamo);
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader(CommandBehavior.CloseConnection);

                        while (reader.Read())
                        {
                            DatosDetallePrestamosEst datosPrestamoEstudiante = new DatosDetallePrestamosEst()
                            {
                                idInventario = reader["idInventario"].ToString(),
                                nombreInventario = reader["nombreInventario"].ToString(),
                                nombreCategoria = reader["nombreCategoria"].ToString(),
                                cantidadPrestamo = reader["cantidadPrestamo"].ToString()
                            };

                            lista.Add(datosPrestamoEstudiante);
                        }
                        reader.Close();
                    }
                }
                return lista;
            }
            catch (Exception ex)
            {
                return new List<DatosDetallePrestamosEst>
                {
                    new DatosDetallePrestamosEst
                    {
                        mensajeError=ex.Message
                    }
                };
            }
        }

        public PrestamoUsuario PutPrestamo(PrestamoUsuario maestro)
        {

            try
            {
                PrestamoUsuario prestamo = new PrestamoUsuario();

                string sql = @"UPDATE Prestamos_Invitados
                                SET estadoPrestamo=1
                                WHERE idPrestamo=@id";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@id", maestro.idPrestamo);
                        connection.Open();
                        command.ExecuteNonQuery();
                        //Agregar Detalle
                        DetPrestInvitadoDAL detPrestamoDAL = new DetPrestInvitadoDAL();
                        DetallePrestamo detalle = detPrestamoDAL.PutDetallePrestamo(maestro.lstDetalle, maestro.idPrestamo);

                        if (!String.IsNullOrEmpty(detalle.mensajeError))
                        {
                            prestamo.mensajeError = detalle.mensajeError;
                        }

                        connection.Close();

                    }
                }

                return prestamo;

            }
            catch (Exception ex)
            {
                return new PrestamoUsuario
                {
                    mensajeError = ex.Message
                };
            }
        }


    }
}