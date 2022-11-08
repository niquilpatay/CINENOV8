using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cine.Login2
{
    internal class Usuario
    {
        //private string nombre, contraseña;

        public string nombre { get; set; }
        public string contraseña { get; set; }


        public Usuario()
        {
            nombre = contraseña = "";
        }

        public Usuario(string contraseña, string nombres)
        {
            this.nombre = nombres;
            this.contraseña = contraseña;
        }

        public string pnombre
        {
            set { nombre = value; }
            get { return nombre; }
        }

        public string pcontraseña
        {
            set { contraseña = value; }
            get { return contraseña; }
        }

        override public string ToString()
        {
            return contraseña + ", " + nombre;
        }

    }
}
