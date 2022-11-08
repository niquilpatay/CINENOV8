using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Cine.Dominio;
using Cine.Login2;

namespace Cine.Datos
{
    internal interface iCineDAO
    {
        DataTable getConsultarDB(string NomProc);
        bool getEliminarFuncion(int idFuncion);
        int getProximoTicket();
        DataTable getConsultarFunciones();
        bool getGrabarCliente(Cliente oCliente);
        bool getGrabarFuncion(Funcion oFuncion);
        DataTable getConsultarFuncionesFiltro(DateTime fecha);
        DataTable getconsultarClientes();
        DataTable getconsultarTipoPago();
        bool getEliminarCliente(int idCliente);
        bool getConfirmarTicket(Ticket oTicket);
        DataTable getfiltrarClientes(int filtro, string opcion);
        DataTable getConsultarUsuarios();
        bool getInsertarUsuarios(Usuario oUsuario);

    }
}
