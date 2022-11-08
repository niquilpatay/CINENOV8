using Cine.Datos;
using Cine.Dominio;
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
    public partial class FrmClientes : Form
    {
        //DBHelper oDatos;
        private iServicioCine servicio;
        public FrmClientes()
        {
            InitializeComponent();
            //oDatos = new DBHelper();
            servicio = new implementFactoryServicio().crearServicio();
        }

        private void FrmClientes_Load(object sender, EventArgs e)
        {
            CargarGrilla();
            this.dgvClientes.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
        }

        public  void CargarGrilla()
        {
            DataTable tabla=new DataTable();
            tabla = servicio.ConsultarDB("SP_CONSULTAR_CLIENTES_ACTIVOS");

            foreach (DataRow dr in tabla.Rows)
            {
                int id= Convert.ToInt32(dr["id_cliente"]);
                long dni = Convert.ToInt64(dr["dni_cliente"]);
                string nombre = Convert.ToString(dr["nom_cliente"]);
                string apellido = Convert.ToString(dr["ape_cliente"]);
                string email = Convert.ToString(dr["email"]);

                dgvClientes.Rows.Add(new object[] { id, dni, nombre, apellido, email });
            }
        }

        private void dgvClientes_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvClientes.CurrentCell.ColumnIndex == 5)
            {
                servicio.EliminarCliente(Convert.ToInt32(dgvClientes.CurrentRow.Cells[0].Value));
                dgvClientes.Rows.RemoveAt(dgvClientes.CurrentCell.RowIndex);

            }
            if(dgvClientes.CurrentCell.ColumnIndex==5)
            {
               
            }
            
        }

        private void nuevoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
            FrmAltaCliente frmAlta = new FrmAltaCliente();
            frmAlta.Show();
           

            
        }

        

        private void salirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            dgvClientes.Rows.Clear();
            int filtro = Convert.ToInt32(cboFiltros.SelectedIndex);
            string opcion = txtFiltro.Text;
            DataTable tabla = servicio.filtrarClientes(filtro, opcion);

            foreach (DataRow item in tabla.Rows)
            {
                int id = Convert.ToInt32(item["id_cliente"]);
                long dni = Convert.ToInt64(item["dni_cliente"]);
                string nombre = Convert.ToString(item["nom_cliente"]);
                string apellido = Convert.ToString(item["ape_cliente"]);
                string email = Convert.ToString(item["email"]);

                dgvClientes.Rows.Add(new object[] { id, dni, nombre, apellido, email });
            }
        }
    }
}
