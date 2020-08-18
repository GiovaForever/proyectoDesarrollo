using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class LaboratoriosDocentesDAL
    {

        public LaboratoriosDocentesDAL() { }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }

        public LaboratorioDocente PostLabDocente(LaboratorioDocente laboratorio)
        {

            try
            {
                LaboratorioDocente laboratorioDocente = new LaboratorioDocente();

                string sql = @"INSERT INTO Laboratorios_Docentes(fechaPrestamo,idLaboratorio,cedulaLaboratorista,idMateria,estadoPrestamo)
                               VALUES (@fechaPrestamos, @idLaboratorio, @cedulaLaboratorista,@idMateria,@estadoPrestamo)";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@fechaPrestamos", Convert.ToDateTime(laboratorio.fechaPrestamo));
                        command.Parameters.AddWithValue("@idLaboratorio", laboratorio.idLaboratorio);
                        command.Parameters.AddWithValue("@cedulaLaboratorista", laboratorio.cedulaLaboratorista);
                        command.Parameters.AddWithValue("@idMateria", laboratorio.idMateria);
                        command.Parameters.AddWithValue("@estadoPrestamo", laboratorio.estadoPrestamo);
                        command.ExecuteNonQuery();
                    }

                    connection.Close();
                }

                return laboratorioDocente;

            }
            catch (Exception ex)
            {
                return new LaboratorioDocente
                {
                    mensajeError = ex.Message
                };
            }
        }

        public LaboratorioDocente PutLabDocente(string idPrestamo)
        {

            try
            {
                LaboratorioDocente laboratorioDocente = new LaboratorioDocente();

                string sql = @"UPDATE Laboratorios_Docentes SET estadoPrestamo=@estadoPrestamo WHERE idLabDocente=@id";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@id", idPrestamo);
                        command.Parameters.AddWithValue("@estadoPrestamo", "1");
                        command.ExecuteNonQuery();
                    }

                    connection.Close();
                }

                return laboratorioDocente;

            }
            catch (Exception ex)
            {
                return new LaboratorioDocente
                {
                    mensajeError = ex.Message
                };
            }
        }

    }
}