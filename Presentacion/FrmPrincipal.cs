using Cine.Datos;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Cine.Dominio;
using Cine.Presentacion;
using System.Security.Cryptography.X509Certificates;
using Cine.Servicio;

namespace Cine
{
    public partial class FrmPrincipal : Form
    {
        //DBHelper oDatos;
        Ticket oTicket;
        private iServicioCine servicio;

        public FrmPrincipal()
        {
            InitializeComponent();
            //oDatos = new DBHelper();
            oTicket = new Ticket();
            servicio = new implementFactoryServicio().crearServicio();
        }

        private void FrmPrincipal_Load(object sender, EventArgs e)
        {
            this.dgvDetalles.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            cargarClientescbo();
            cargarTiposPago();
            CargarCboFunciones();

            lblProximoTicket.Text = "TICKET N°: " + servicio.ProximoTicket().ToString();
        }

        private void cargarTiposPago()
        {
            DataTable tabla = servicio.consultarTipoPago();
            cboTipoPagos.DataSource = tabla;
            cboTipoPagos.ValueMember = tabla.Columns[0].ColumnName;
            cboTipoPagos.DisplayMember = tabla.Columns[1].ColumnName;
            cboTipoPagos.DropDownStyle = ComboBoxStyle.DropDownList;
        }

        private void cargarClientescbo()
        {
            DataTable tabla = servicio.consultarClientes();
            cboClientes.DataSource = tabla;
            cboClientes.ValueMember = tabla.Columns[0].ColumnName;
            cboClientes.DisplayMember = tabla.Columns[5].ColumnName;
            cboClientes.DropDownStyle = ComboBoxStyle.DropDownList;
        }

        private void CargarCboFunciones()
        {
            DataTable tabla = servicio.ConsultarFunciones();
            cboFuncion.DataSource = tabla;
            cboFuncion.ValueMember = tabla.Columns[0].ColumnName;
            cboFuncion.DisplayMember = tabla.Columns[1].ColumnName;
            cboFuncion.DropDownStyle = ComboBoxStyle.DropDownList;
        }

        private void salirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("¿Desea Salir?", "Salir", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) == System.Windows.Forms.DialogResult.Yes)
            {
                this.Close();
            }
        }


        private void btnCargar_Click(object sender, EventArgs e)
        {
            
        }

        private void clienteToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FrmAltaCliente frm = new FrmAltaCliente();
            frm.Show();
        }

        private void funciónToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FrmAltaFuncion frm = new FrmAltaFuncion();
            frm.Show();
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {
            if(Validar())
            {
                DataRowView item = (DataRowView)cboFuncion.SelectedItem;
                int numbutaca = Convert.ToInt32(cboButaca.SelectedItem);
                string funcion = item.Row.ItemArray[1].ToString();
                double costo = Convert.ToDouble(item.Row.ItemArray[2]);
                double descuento = Convert.ToDouble(txtDescuento.Text);

                dgvDetalles.Rows.Add(new object[] { item.Row.ItemArray[0], numbutaca, funcion, costo, descuento });

                TipoPago tp = new TipoPago();
                tp.idTipoPago = Convert.ToInt32(cboTipoPagos.SelectedValue);
                DetalleTicket dt = new DetalleTicket();
                Butaca oButaca = new Butaca();
                Funcion oFuncion = new Funcion();
                oButaca.Numero = numbutaca;
                dt.Costo = costo;
                dt.Descuento = descuento;
                dt.Butaca = oButaca;
                dt.Funcion = (int)cboFuncion.SelectedValue;

                DataRowView item1 = (DataRowView)cboClientes.SelectedItem;
                int IdCliente = Convert.ToInt32(item1.Row.ItemArray[0]);
                string Nombre = item1.Row.ItemArray[6].ToString();
                string Apellido = item1.Row.ItemArray[7].ToString();
                long Dni = Convert.ToInt64(item1.Row.ItemArray[1]);
                string Email = item1.Row.ItemArray[2].ToString();
                string Calle = item1.Row.ItemArray[3].ToString();
                int Altura = Convert.ToInt32(item1.Row.ItemArray[4]);
                long Telefono = Convert.ToInt64(item1.Row.ItemArray[5]);

                Cliente c = new Cliente(IdCliente, Nombre, Apellido, Dni, Email, Calle, Altura, Telefono);

                oTicket.Fecha = DateTime.Today;
                oTicket.Pago = tp;
                oTicket.Cliente = c;
                oTicket.AgregarDetalle(dt);

                txtCosto.Text = Convert.ToString(oTicket.CalcularSubTotal());
                CalcularTotal();
            }
        }
        private void dgvDetalles_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvDetalles.CurrentCell.ColumnIndex == 5)
            {
                oTicket.QuitarDetalle(dgvDetalles.CurrentRow.Index);
                dgvDetalles.Rows.Remove(dgvDetalles.CurrentRow);
                txtCosto.Text = Convert.ToString(oTicket.CalcularSubTotal());
                CalcularTotal();
            }
        }

        private bool Validar()
        {
            bool ok = true;

            if(cboButaca.SelectedIndex==-1)
            {
                MessageBox.Show("Seleccione butaca");
                cboButaca.Focus();
                ok = false;
            }
            if(cboFuncion.SelectedIndex==-1)
            {
                MessageBox.Show("Seleccione función");
                cboFuncion.Focus();
                ok = false;
            }
            foreach (DataGridViewRow row in dgvDetalles.Rows)
            {
                if (row.Cells["id_pelicula"].Value.ToString().Equals(cboFuncion.Text) && row.Cells["id_butaca"].Value.ToString().Equals(cboButaca.Text))
                {
                    MessageBox.Show("Butaca ya reservada");
                    ok = false;
                }
            }
            if(txtDescuento.Text == "")
            {
                MessageBox.Show("Seleccionar descuento");
                txtDescuento.Focus();
                ok = false;
            }
            else
            {
                try
                {
                    Convert.ToInt32(txtDescuento.Text);
                }
                catch (Exception)
                {
                    MessageBox.Show("Solo números");
                    txtDescuento.Focus();
                    ok = false;
                }
            }
            return ok;
        }

        private void limpiar()
        {
            cboFuncion.SelectedValue = -1;
            cboButaca.SelectedValue = -1;
            cboClientes.SelectedValue = -1;
            cboTipoPagos.SelectedValue = -1;
            txtDescuento.Text = Convert.ToString(0);
            dgvDetalles.Rows.Clear();
            oTicket.CalcularSubTotal();
            CalcularTotal();
        }

        private void btnAceptar_Click(object sender, EventArgs e)
        {
            if (servicio.ConfirmarTicket(oTicket))
            {
                MessageBox.Show("Ticket guardado");
                limpiar();
            }
            else
            {
                MessageBox.Show("Ticket NO guardado");
            }

            lblProximoTicket.Text = "TICKET N°: " + servicio.ProximoTicket().ToString();

        }
        private void CalcularTotal()
        {
            double total = oTicket.CalcularSubTotal();
            //txtTotal.Text = total.ToString();

            if (txtDescuento.Text != "")
            {
                double dto = (total * Convert.ToDouble(txtDescuento.Text)) / 100;
                txtTotal.Text = (total - dto).ToString();
            }
        }

        private void clientesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FrmClientes frm = new FrmClientes();
            frm.Show();
        }

        private void funcionesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FrmFunciones frm = new FrmFunciones();
            frm.Show();
        }

       
    }
}
