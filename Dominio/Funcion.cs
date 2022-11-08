using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cine.Dominio
{
    internal class Funcion
    {
        public int Id_Funcion { get; set; }
        public int Pelicula { get; set; }
        public DateTime Fecha { get; set; }
        public double Precio { get; set; }
        public int Sala { get; set; }

        public Funcion()
        {
            Id_Funcion = 0;
            Pelicula = 0;
            Fecha=DateTime.Today;
            Precio = 0;
            Sala = 0;
        }

        public Funcion(int pelicula, DateTime fecha, double precio, int sala)
        {         
            Pelicula = pelicula;
            Fecha = fecha;
            Precio = precio;
            Sala = sala;
        }
    }
}
