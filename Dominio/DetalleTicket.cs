using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cine.Dominio
{
    internal class DetalleTicket
    {
        public double Costo { get; set; }
        public Butaca Butaca { get; set; }
        public int Funcion { get; set; }
        public double Descuento { get; set; }


        public DetalleTicket(double costo,Butaca butaca, int funcion, double descuento)
        {
            Costo = costo;
            Funcion = funcion;
            Butaca = butaca;
            Descuento = descuento;
        }

        public DetalleTicket()
        {
            Costo = 0;
            Funcion = 0;
            Butaca = null;
            Descuento = 0;
        }
    }
}
