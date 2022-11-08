using Cine.Login2;
using Cine.Servicio;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Cine.Presentacion
{
    public partial class FrmRegistro : Form
    {
        private iServicioCine servicio;
        public FrmRegistro()
        {
            InitializeComponent();
            servicio = new implementFactoryServicio().crearServicio();
        }

        private void FrmRegistro_Load(object sender, EventArgs e)
        {

        }

        private void btnRegistro_Click(object sender, EventArgs e)
        {
            Usuario u1 = new Usuario();
            u1.nombre = txtNombreUsuario.Text;
            u1.contraseña = txtContra.Text;
            if (validaOk())
            {
                //string insertSql = ("INSERT INTO usuarios2 VALUES ('" + u1.pnombre + "', '" + u1.pcontraseña + "') ");
                if (servicio.insertarUsuarios(u1))
                {
                    MessageBox.Show("Se insertó usuario.");

                }
                else
                {
                    MessageBox.Show("No se pudo insertar el usuario.");
                }

            }
        }
        private bool validaOk()
        {
            if (txtContra.Text != txtConfContra.Text)
            {
                MessageBox.Show("debe coincidir la contraseña con la confirmacion");
                return false;
            }
            if (txtContra.Text == null || txtNombreUsuario.Text == null || txtConfContra.Text == null)
            {
                MessageBox.Show("debe ingresar todos los datos");
                return false;
            }
            return true;

        }
    }
}
