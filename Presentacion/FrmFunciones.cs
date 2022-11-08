using Cine.Datos;
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
    public partial class FrmFunciones : Form
    {
        //BHelper oDatos;
        private iServicioCine servicio;
        public FrmFunciones()
        {
            InitializeComponent();
            //oDatos = new DBHelper();
            servicio = new implementFactoryServicio().crearServicio();
        }

        private void nuevoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
            FrmAltaFuncion frm = new FrmAltaFuncion();
            frm.Show();
        }

        private void FrmFunciones_Load(object sender, EventArgs e)
        {
            CargarGrilla();
        }

        private void CargarGrilla()
        {
            DataTable tabla = new DataTable();
            tabla = servicio.ConsultarDB("SP_CONSULTAR_FUNCIONES3");

            foreach (DataRow dr in tabla.Rows)
            {
                int id = Convert.ToInt32(dr["id_funcion"]);
                string titulo = Convert.ToString(dr["titulo"]);
                DateTime fecha = Convert.ToDateTime(dr["fecha"]);
                int sala = Convert.ToInt32(dr["id_sala"]);
                double precio = Convert.ToDouble(dr["pre_unitario"]);

                dgvFunciones.Rows.Add(new object[] { id, titulo, fecha, sala, precio });
            }
        }

        private void dgvFunciones_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvFunciones.CurrentCell.ColumnIndex == 5)
            {
                servicio.EliminarFuncion(Convert.ToInt32(dgvFunciones.CurrentRow.Cells[0].Value));
                dgvFunciones.Rows.RemoveAt(dgvFunciones.CurrentCell.RowIndex);

            }
        }

        private void salirToolStripMenuItem_Click(object sender, EventArgs e)
        {

                this.Close();

        }
    }
}
