using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cine.Servicio
{
    abstract class factoryServicio
    {
        public abstract iServicioCine crearServicio();
    }
}
