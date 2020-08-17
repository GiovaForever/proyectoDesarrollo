using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Servicios_Rest.Models
{
    public class HorariosDAL
    {

        public HorariosDAL() { }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["LaboratoriosConnectionString"].ConnectionString;
        }


        public Horario PostHorario(Horario horarioInsert)
        {

            try
            {
                Horario horario = new Horario();
                horario = DeleteHorario(horarioInsert.idLaboratorio);

                if (String.IsNullOrEmpty(horario.mensajeError))
                {
                    string sql = @"INSERT INTO Laboratorios_Horas
                               VALUES (@idLaboratorio, @idDia, @idHora,@idMateria)";

                    using (SqlConnection connection = new SqlConnection(GetConnectionString()))
                    {
                        connection.Open();

                        int cont = 1;

                        foreach (var item in horarioInsert.lstHorarios)
                        {
                            int contHora = 1;
                            for (int i = 0; i < item.Count; i++)
                            {
                                using (SqlCommand command = new SqlCommand(sql, connection))
                                {
                                    command.Parameters.AddWithValue("@idLaboratorio", horarioInsert.idLaboratorio);
                                    var idDia = obtenerDia(cont);
                                    command.Parameters.AddWithValue("@idDia", idDia);
                                    var idHora = Convert.ToString(contHora);
                                    command.Parameters.AddWithValue("@idHora", idHora);
                                    var idMateria = item[i];
                                    command.Parameters.AddWithValue("@idMateria", item[i]);
                                    command.ExecuteNonQuery();
                                }
                                contHora++;
                            }

                            cont++;

                        }
                        connection.Close();
                    }
                }

                return horario;

            }
            catch (Exception ex)
            {
                return new Horario
                {
                    mensajeError = ex.Message
                };
            }
        }

        private object obtenerDia(int cont)
        {
            string codDia = "";

            switch (cont)
            {
                case 1:
                    codDia = "L";
                    break;
                case 2:
                    codDia = "M";
                    break;
                case 3:
                    codDia = "X";
                    break;
                case 4:
                    codDia = "J";
                    break;
                case 5:
                    codDia = "V";
                    break;
            }

            return codDia;

        }

        public Horario DeleteHorario(string idLaboratorio)
        {
            try
            {

                Horario Horario = new Horario();

                string sql = @"DELETE FROM Laboratorios_Horas
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
                return Horario;

            }
            catch (Exception ex)
            {

                return new Horario
                {
                    mensajeError = ex.Message
                };

            }
        }

    }
}