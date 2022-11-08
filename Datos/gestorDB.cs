using Cine.Dominio;
using Cine.Login2;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cine.Datos
{
    internal class gestorDB : iCineDAO
    {
        public DataTable getConsultarDB(string NomProc)
        {
            return DBHelper.ObtenerInstancia().ConsultarDB(NomProc);
        }
        public bool getEliminarFuncion(int idFuncion)
        {
            return DBHelper.ObtenerInstancia().EliminarFuncion(idFuncion);
        }
        public int getProximoTicket()
        {
            return DBHelper.ObtenerInstancia().ProximoTicket();
        }
        public DataTable getConsultarFunciones()
        {
            return DBHelper.ObtenerInstancia().ConsultarFunciones();
        }
        public bool getGrabarCliente(Cliente oCliente)
        {
            return DBHelper.ObtenerInstancia().GrabarCliente(oCliente);
        }
        public bool getGrabarFuncion(Funcion oFuncion)
        {
            return DBHelper.ObtenerInstancia().GrabarFuncion(oFuncion);
        }
        public DataTable getConsultarFuncionesFiltro(DateTime fecha)
        {
            return DBHelper.ObtenerInstancia().ConsultarFuncionesFiltro(fecha);
        }
        public DataTable getconsultarClientes()
        {
            return DBHelper.ObtenerInstancia().consultarClientes();
        }
        public DataTable getconsultarTipoPago()
        {
            return DBHelper.ObtenerInstancia().consultarTipoPago();
        }
        public bool getEliminarCliente(int idCliente)
        {
            return DBHelper.ObtenerInstancia().EliminarCliente(idCliente);
        }
        public bool getConfirmarTicket(Ticket oTicket)
        {
            return DBHelper.ObtenerInstancia().ConfirmarTicket(oTicket);
        }

        public DataTable getfiltrarClientes(int filtro, string opcion)
        {
            return DBHelper.ObtenerInstancia().FiltrarClientes(filtro, opcion);
        }

        public DataTable getConsultarUsuarios()
        {
            return DBHelper.ObtenerInstancia().consultarUsuarios();
        }

        public bool getInsertarUsuarios(Usuario oUsuario)
        {
            return DBHelper.ObtenerInstancia().insertarUsuario(oUsuario);
        }
    }
}
