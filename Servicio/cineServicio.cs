using Cine.Datos;
using Cine.Dominio;
using Cine.Login2;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cine.Servicio
{
    internal class cineServicio : iServicioCine
    {
        iCineDAO dao;

        public cineServicio()
        {
            dao = new gestorDB();
        }

        public DataTable ConsultarDB(string NomProc)
        {
            return dao.getConsultarDB(NomProc);
        }
        public bool EliminarFuncion(int idFuncion)
        {
            return dao.getEliminarFuncion(idFuncion);
        }
        public int ProximoTicket()
        {
            return dao.getProximoTicket();
        }
        public DataTable ConsultarFunciones()
        {
            return dao.getConsultarFunciones();
        }
        public bool GrabarCliente(Cliente oCliente)
        {
            return dao.getGrabarCliente(oCliente);
        }
        public bool GrabarFuncion(Funcion oFuncion)
        {
            return dao.getGrabarFuncion(oFuncion);
        }
        public DataTable ConsultarFuncionesFiltro(DateTime fecha)
        {
            return dao.getConsultarFuncionesFiltro(fecha);
        }
        public DataTable consultarClientes()
        {
            return dao.getconsultarClientes();
        }
        public DataTable consultarTipoPago()
        {
            return dao.getconsultarTipoPago();
        }
        public bool EliminarCliente(int idCliente)
        {
            return dao.getEliminarCliente(idCliente);
        }
        public bool ConfirmarTicket(Ticket oTicket)
        {
            return dao.getConfirmarTicket(oTicket);
        }
        public DataTable filtrarClientes(int filtro, string opcion)
        {
            return dao.getfiltrarClientes(filtro, opcion);
        }
        public DataTable consultarUsuarios()
        {
            return dao.getConsultarUsuarios();
        }
        public bool insertarUsuarios(Usuario oUsuario)
        {
            return dao.getInsertarUsuarios(oUsuario);
        }
    }
}
