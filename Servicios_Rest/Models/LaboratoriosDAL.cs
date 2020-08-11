using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class LaboratoriosDAL
    {

        private enum estado { Libre, Ocupado };

        public LaboratoriosDAL() { }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }

        private string ObtenerCodigo(string nombre)
        {
            string codigo = "";

            switch (nombre)
            {
                case "Libre":
                    codigo = "0";
                    break;
                case "Ocupado":
                    codigo = "1";
                    break;
            }

            return codigo;
        }

        public List<Laboratorio> GetLaboratorios()
        {
            try
            {
                List<Laboratorio> lista = new List<Laboratorio>();

                string sql = @"SELECT *
                               FROM Laboratorios L 
                               INNER JOIN Tipo_Laboratorios TL ON L.idTipoLaboratorio=TL.idTipoLaboratorio";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader(CommandBehavior.CloseConnection);

                        while (reader.Read())
                        {
                            Laboratorio laboratorio = new Laboratorio();
                            laboratorio.idLaboratorio = reader["idLaboratorio"].ToString();
                            laboratorio.nombreLaboratorio = reader["nombreLaboratorio"].ToString();
                            laboratorio.ubicacionLaboratorio = reader["ubicacionLaboratorio"].ToString();
                            laboratorio.capacidadLaboratorio = reader["capacidadLaboratorio"].ToString();
                            laboratorio.tipoLaboratorio = reader["nombreTipoLaboratorio"].ToString();
                            laboratorio.estadoLaboratorio = reader["estadoLaboratorio"].ToString();
                            switch (laboratorio.estadoLaboratorio)
                            {
                                case "0":
                                    laboratorio.estadoLaboratorio = estado.Libre.ToString();
                                    break;
                                case "1":
                                    laboratorio.estadoLaboratorio = estado.Ocupado.ToString();
                                    break;
                            }
                            lista.Add(laboratorio);
                        }
                        reader.Close();
                    }
                }
                return lista;
            }
            catch (Exception ex)
            {
                return new List<Laboratorio>
                {
                    new Laboratorio
                    {
                        mensajeError=ex.Message
                    }
                };
            }
        }

        public Laboratorio PostLaboratorios(Laboratorio laboratorio)
        {

            try
            {
                Laboratorio laboratorioR = new Laboratorio();

                string sql = @"INSERT INTO Laboratorios(nombreLaboratorio,ubicacionLaboratorio,capacidadLaboratorio,
                                                        idTipoLaboratorio,estadoLaboratorio)
                               VALUES (@nombre, @ubicacion, @capacidad,@idTipo,@estado)";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@nombre", laboratorio.nombreLaboratorio);
                        command.Parameters.AddWithValue("@ubicacion", laboratorio.ubicacionLaboratorio);
                        command.Parameters.AddWithValue("@capacidad", laboratorio.capacidadLaboratorio);
                        command.Parameters.AddWithValue("@idTipo", laboratorio.tipoLaboratorio);
                        command.Parameters.AddWithValue("@estado", laboratorio.estadoLaboratorio);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }

                return laboratorioR;

            }
            catch (Exception ex)
            {
                return new Laboratorio
                {
                    mensajeError = ex.Message
                };
            }
        }

        public Laboratorio PutLaboratorios(Laboratorio laboratorio)
        {

            try
            {
                Laboratorio laboratorioR = new Laboratorio();

                string sql = @"UPDATE Laboratorios
                               SET nombreLaboratorio=@nombre,
                                   ubicacionLaboratorio= @ubicacion,
                                   capacidadLaboratorio=@capacidad,
                                   idTipoLaboratorio=@idTipo,
                                   estadoLaboratorio=@estado
                               WHERE idLaboratorio=@id";

                using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                {
                    using (SqlCommand command = new SqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@id", laboratorio.idLaboratorio);
                        command.Parameters.AddWithValue("@nombre", laboratorio.nombreLaboratorio);
                        command.Parameters.AddWithValue("@ubicacion", laboratorio.ubicacionLaboratorio);
                        command.Parameters.AddWithValue("@capacidad", laboratorio.capacidadLaboratorio);
                        command.Parameters.AddWithValue("@idTipo", laboratorio.tipoLaboratorio);
                        command.Parameters.AddWithValue("@estado", laboratorio.estadoLaboratorio);
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                }

                return laboratorioR;

            }
            catch (Exception ex)
            {
                return new Laboratorio
                {
                    mensajeError = ex.Message
                };
            }
        }

        public Laboratorio DeleteLaboratorios(string id)
        {
            try
            {

                Laboratorio laboratorio = new Laboratorio();

                string sql = @"DELETE FROM Laboratorios
                         WHERE idLaboratorio = @id";

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
                return laboratorio;

            }
            catch (Exception ex)
            {

                return new Laboratorio
                {
                    mensajeError = ex.Message
                };

            }
        }

    }

}