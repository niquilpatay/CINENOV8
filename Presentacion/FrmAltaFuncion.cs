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
using Cine.Servicio;

namespace Cine.Presentacion
{
    public partial class FrmAltaFuncion : Form
    {
        //DBHelper oDatos;
        private iServicioCine servicio;
        List<Funcion> funciones;
        
        public FrmAltaFuncion()
        {
            InitializeComponent();
            //oDatos = new DBHelper();
            servicio = new implementFactoryServicio().crearServicio();
            funciones = new List<Funcion>();
        }

        private void FrmAltaFuncion_Load(object sender, EventArgs e)
        {
            CargarCboPeliculas();
            this.dgvFunciones.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
        }

        private void CargarCboPeliculas()
        {
            cboPeliculas.DataSource = servicio.ConsultarDB("SP_CONSULTAR_PELICULAS");
            cboPeliculas.DisplayMember = "titulo";
            cboPeliculas.ValueMember = "id_pelicula";
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnAgregar_Click(object sender, EventArgs e)
        {
            if (ValidarFuncion())
            {
                DataRowView item = (DataRowView)cboPeliculas.SelectedItem;

                int idPelicula = Convert.ToInt32(item.Row.ItemArray[0]);
                string titulo = item.Row.ItemArray[1].ToString();
                double precio = Convert.ToDouble(txtPrecio.Text);
                DateTime fecha = dtpFecha.Value;
                int sala = Convert.ToInt32(cboSalas.Text);

                dgvFunciones.Rows.Add(new object[] { item.Row.ItemArray[0], item.Row.ItemArray[1], fecha, sala, precio });

                Funcion func = new Funcion(idPelicula,fecha,precio,sala);

                funciones.Add(func);
                LimpiarCampos();


            }

        }

        private bool ValidarFuncion()
        {
            bool ok = true;
            if(cboPeliculas.SelectedIndex==-1)
            {
                MessageBox.Show("Seleccione película");
                cboPeliculas.Focus();
                ok = false;
            }
            if(cboSalas.SelectedIndex==-1)
            {
                MessageBox.Show("Seleccione sala");
                cboSalas.Focus();
                ok = false;
            }
            if(txtPrecio.Text=="")
            {
                MessageBox.Show("Ingrese Precio");
                txtPrecio.Focus();
                ok=false;
            }
            else
            {
                try
                {
                    Convert.ToDouble(txtPrecio.Text);
                }
                catch(FormatException)
                {
                    MessageBox.Show("Ingrese un número válido");
                    txtPrecio.Clear();
                    ok = false;
                }
            }

            return ok;
        }

        private void btnAceptar_Click(object sender, EventArgs e)
        {
            if(GrabarFunciones())
            {
                MessageBox.Show("Funciones Cargadas");
                dgvFunciones.Rows.Clear();
                LimpiarCampos();
            }
            else
            {
                MessageBox.Show("Error al cargar funciones");
            }
        }

        private bool GrabarFunciones()
        {
            bool ok = true;
            foreach(Funcion item in funciones)
            {
                if(servicio.GrabarFuncion(item))
                {
                    ok = true;
                }
                else
                {
                    ok = false;
                }
                
            }

            return ok;
        }

        private void LimpiarCampos()
        {
            txtPrecio.Clear();
            cboSalas.Text = "";
            cboPeliculas.Text = "";
        }

        private void dgvFunciones_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
           if(dgvFunciones.CurrentCell.ColumnIndex==5)
           {
                funciones.RemoveAt(dgvFunciones.CurrentRow.Index);
                dgvFunciones.Rows.Remove(dgvFunciones.CurrentRow);
           }
        }

        private void salirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("¿Desea Regresar?", "Regresar", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) == System.Windows.Forms.DialogResult.Yes)
            {
                this.Close();
                FrmFunciones frm = new FrmFunciones();
                frm.Show();

            }
        }
    }
}
