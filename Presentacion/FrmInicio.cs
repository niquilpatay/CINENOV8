﻿using System;
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
    public partial class FrmInicio : Form
    {
        public FrmInicio()
        {
            InitializeComponent();
        }

        private void btnIniciarSesion_Click(object sender, EventArgs e)
        {
            FrmLogin l = new FrmLogin();
            l.Show();
        }

        private void btnRegistro_Click(object sender, EventArgs e)
        {
            FrmRegistro r  = new FrmRegistro();
            r.Show();
        }
    }
}
