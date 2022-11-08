using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using System.Runtime.Remoting;
using Cine.Dominio;
using Cine.Login2;

namespace Cine.Datos
{
    internal class DBHelper
    {
        private SqlConnection conn;
        private string CadenaConexion = @"Data Source=DESKTOP-L9CRCP4\SQLEXPRESS;Initial Catalog=cineNov6_Nuevo;Integrated Security=True";
        private static DBHelper instancia;

        public DBHelper()
        {
            conn = new SqlConnection(CadenaConexion);
        }

        public static DBHelper ObtenerInstancia()
        {
            if (instancia == null)

                instancia = new DBHelper();
            return instancia;

        }

        public DataTable ConsultarDB(string NomProc)
        {
            DataTable tabla = new DataTable();
            SqlCommand cmd = new SqlCommand();
            conn.Open();
            cmd.Connection = conn;
            cmd.CommandText = NomProc;
            cmd.CommandType = CommandType.StoredProcedure;
            tabla.Load(cmd.ExecuteReader());
            conn.Close();
            return tabla;
        }

        public bool EliminarFuncion(int idFuncion)
        {
            bool ok = true;
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SP_BAJA_FUNCION";
            cmd.Parameters.AddWithValue("@idFuncion", idFuncion);
            cmd.ExecuteNonQuery();
            conn.Close();
            return ok;
        }

        public int ProximoTicket()
        {

            conn.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "proxTicket";
            SqlParameter param = new SqlParameter("@prox", SqlDbType.Int);
            param.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(param);
            cmd.ExecuteNonQuery();
            int proximoId;
            if (param.Value == DBNull.Value)
            {
                proximoId = 1;
            }
            else
            {
                proximoId = Convert.ToInt32(param.Value);
            }
            conn.Close();

            return proximoId;
        }

        public DataTable ConsultarFunciones()
        {
            DataTable tabla = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SP_CONSULTAR_FUNCIONES2";
            tabla.Load(cmd.ExecuteReader());
            conn.Close();
            return tabla;
        }

        public bool GrabarCliente(Cliente oCliente)
        {
            bool ok = true;
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SP_GRABAR_CLIENTE";
            cmd.Parameters.AddWithValue("@nombre", oCliente.Nombre);
            cmd.Parameters.AddWithValue("@apellido", oCliente.Apellido);
            cmd.Parameters.AddWithValue("@dni", oCliente.Dni);
            cmd.Parameters.AddWithValue("@calle", oCliente.Calle);
            cmd.Parameters.AddWithValue("@altura", oCliente.Altura);
            cmd.Parameters.AddWithValue("@email", oCliente.Email);
            cmd.Parameters.AddWithValue("@telefono", oCliente.Telefono);
            cmd.ExecuteNonQuery();
            conn.Close();
            return ok;
        }

        public bool GrabarFuncion(Funcion oFuncion)
        {
            bool ok = true;
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SP_GRABAR_FUNCION";
            cmd.Parameters.AddWithValue("@idPelicula", oFuncion.Pelicula);
            cmd.Parameters.AddWithValue("@fecha", oFuncion.Fecha);
            cmd.Parameters.AddWithValue("@precio", oFuncion.Precio);
            cmd.Parameters.AddWithValue("@idSala", oFuncion.Sala);
            cmd.ExecuteNonQuery();
            conn.Close();
            return ok;

        }
        public bool insertarUsuario(Usuario oUsuario)
        {
            bool ok = true;
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "insertarUsuarios";
            cmd.Parameters.AddWithValue("@usuario", oUsuario.nombre);
            cmd.Parameters.AddWithValue("@contra", oUsuario.contraseña);
            cmd.ExecuteNonQuery();
            conn.Close();
            return ok;
        }

        public DataTable ConsultarFuncionesFiltro(DateTime fecha)
        {
            DataTable tabla = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SP_CONSULTAR_FUNCIONES_FILTRO";
            SqlParameter param = new SqlParameter();
            param.ParameterName = "@fecha";
            param.Value = fecha;
            param.Direction = ParameterDirection.Input;
            param.SqlDbType = SqlDbType.DateTime;
            cmd.Parameters.Add(param);
            tabla.Load(cmd.ExecuteReader());
            conn.Close();
            return tabla;
        }

        public DataTable consultarClientes()
        {
            DataTable tabla = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SP_CONSULTAR_CLIENTES_ACTIVOS2";
            tabla.Load(cmd.ExecuteReader());
            conn.Close();
            return tabla;
        }
        public DataTable consultarTipoPago()
        {
            DataTable tabla = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "spConsultarTiposPagos";
            tabla.Load(cmd.ExecuteReader());
            conn.Close();
            return tabla;
        }

        public DataTable consultarUsuarios()
        {
            DataTable tabla = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "consultarUsuarios";
            tabla.Load(cmd.ExecuteReader());
            conn.Close();
            return tabla;
        }

        public bool EliminarCliente(int idCliente)
        {
            bool ok = true;
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SP_BAJA_CLIENTES";
            cmd.Parameters.AddWithValue("@idCliente",idCliente);
            cmd.ExecuteNonQuery();
            conn.Close();
            return ok;
        }

        public bool ConfirmarTicket(Ticket oTicket)
        {
            bool resultado = true;
            SqlTransaction trans = null;

            try
            {
            conn.Open();
            trans = conn.BeginTransaction();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            cmd.Transaction = trans;
            cmd.CommandText = "SP_GRABAR_TICKET";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id_tipo_pago", oTicket.Pago.idTipoPago);
            cmd.Parameters.AddWithValue("@id_cliente", oTicket.Cliente.Id_Cliente);
            cmd.Parameters.AddWithValue("@fecha_compra", oTicket.Fecha);
            SqlParameter pOut = new SqlParameter();
            pOut.SqlDbType = SqlDbType.Int;
            pOut.ParameterName = "@id_ticket";
            pOut.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(pOut);
            cmd.ExecuteNonQuery();
            
            int nroTicket = Convert.ToInt32(pOut.Value);

            foreach (DetalleTicket item in oTicket.Detalles)
            {
                SqlCommand cmdDet = new SqlCommand();
                cmdDet.Transaction = trans;
                cmdDet.Connection = conn;
                cmdDet.CommandText = "SP_INSERTAR_DETALLES";
                cmdDet.CommandType = CommandType.StoredProcedure;
                cmdDet.Parameters.AddWithValue("@descuento", item.Descuento);
                cmdDet.Parameters.AddWithValue("@id_ticket", nroTicket);
                cmdDet.Parameters.AddWithValue("@costo", item.Costo);
                cmdDet.Parameters.AddWithValue("@id_butaca", item.Butaca.Numero);
                cmdDet.Parameters.AddWithValue("@id_funcion", item.Funcion);

                cmdDet.ExecuteNonQuery();
            }

            trans.Commit();

        }
        catch (Exception ex)
        {
            trans.Rollback();
        }
            finally
            {
                if (conn != null && conn.State == ConnectionState.Open)
                    conn.Close();
            }

            return resultado;
        }

        public DataTable FiltrarClientes(int filtro, string opcion)
        {
            DataTable tabla = new DataTable();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = string.Empty;
            SqlParameter param = new SqlParameter();
            param.Direction = ParameterDirection.Input;
            param.Value = null;
            param.ParameterName = string.Empty;

            if (filtro == 0)
            {
                cmd.CommandText = "SP_BUSCAR_CLIENTES_DNI";
                param.ParameterName = "@dni";
                try
                {
                    param.Value = Convert.ToInt64(opcion);
                }
                catch (FormatException)
                {
                    System.Windows.Forms.MessageBox.Show("Ingrese sólo números");
                    param.Value = 0;

                }
            }
            else
            {
                if (filtro == 1)
                {
                    cmd.CommandText = "SP_BUSCAR_CLIENTES_NOMBRE";
                    param.ParameterName = "@nombre";
                    param.Value = Convert.ToString(opcion);

                }
                else
                {
                    if (filtro == 2)
                    {
                        cmd.CommandText = "SP_BUSCAR_CLIENTES_APELLIDO";
                        param.ParameterName = "@apellido";
                        param.Value = Convert.ToString(opcion);
                    }
                    else
                    {
                        if (filtro == 3)
                        {
                            cmd.CommandText = "SP_BUSCAR_CLIENTES_EMAIL";
                            param.ParameterName = "@email";
                            param.Value = Convert.ToString(opcion);
                        }
                        else
                        {
                            if (filtro == 4)
                            {
                                cmd.CommandText = "SP_BUSCAR_CLIENTES_TELEFONO";
                                param.ParameterName = "@telefono";
                                try
                                {
                                    param.Value = Convert.ToInt64(opcion);
                                }
                                catch (FormatException)
                                {
                                    System.Windows.Forms.MessageBox.Show("Ingrese sólo números");
                                    param.Value = 0;
                                }
                            }
                            else
                            {
                                System.Windows.Forms.MessageBox.Show("Seleccionar filtro");
                                cmd.CommandText = "SP_CONSULTAR_CLIENTES_ACTIVOS2";
                                param.ParameterName = "@param";
                                param.Value = 0;
                            }
                        }
                    }
                }
            }
            cmd.Parameters.Add(param);
            tabla.Load(cmd.ExecuteReader());
            conn.Close();
            return tabla;
        }
    }
}
