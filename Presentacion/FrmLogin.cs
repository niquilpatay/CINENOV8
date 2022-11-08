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
    public partial class FrmLogin : Form
    {
        List<Usuario> lstUsuarios;
        private iServicioCine servicio;
        //private accesodatos acceso;
        public FrmLogin()
        {
            InitializeComponent();
            lstUsuarios = new List<Usuario>();
            servicio = new implementFactoryServicio().crearServicio();
            //acceso = new accesodatos();
        }

        private void FrmLogin_Load(object sender, EventArgs e)
        {

        }

        private void btnVer_Click(object sender, EventArgs e)
        {
            if (txtContra.UseSystemPasswordChar == true)
            {
                txtContra.UseSystemPasswordChar = false;
            }
            else
                txtContra.UseSystemPasswordChar = true;
        }

        private void btnRegresar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void cargarUser()
        {
            lstUsuarios.Clear();
            DataTable T1 = servicio.consultarUsuarios();
            foreach (DataRow fila in T1.Rows)
            {
                Usuario u = new Usuario();
                u.pnombre = Convert.ToString(fila["usuario"]);
                u.pcontraseña = Convert.ToString(fila["contras"]);
                lstUsuarios.Add(u);
            }
        }

        private void btnIngresar_Click(object sender, EventArgs e)
        {
            Usuario u = new Usuario();
            u.pnombre = txtUsuario.Text;
            if (existe(u))
            {
                MessageBox.Show("datos incorrectos");
            }
            else
            {
              
                var fCine = new FrmPrincipal();
                fCine.Show();
            }
        }
        private bool existe(Usuario u)
        {

            for (int i = 0; i < lstUsuarios.Count; i++)
            {
                if (lstUsuarios[i].pnombre == u.pnombre)
                    return true;
            }
            return false;

        }
    }
}
