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
    internal interface iServicioCine
    {
        DataTable ConsultarDB(string NomProc);
        bool EliminarFuncion(int idFuncion);
        int ProximoTicket();
        DataTable ConsultarFunciones();
        bool GrabarCliente(Cliente oCliente);
        bool GrabarFuncion(Funcion oFuncion);
        DataTable ConsultarFuncionesFiltro(DateTime fecha);
        DataTable consultarClientes();
        DataTable consultarTipoPago();
        bool EliminarCliente(int idCliente);
        bool ConfirmarTicket(Ticket oTicket);
        DataTable filtrarClientes(int filtro, string opcion);
        DataTable consultarUsuarios();
        bool insertarUsuarios(Usuario oUsuario);
    }
}
