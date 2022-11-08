using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cine.Servicio
{
    internal class implementFactoryServicio : factoryServicio
    {
        public override iServicioCine crearServicio()
        {
            return new cineServicio();
        }
    }
}
