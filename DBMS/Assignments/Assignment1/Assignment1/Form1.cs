using System;
using System.Data;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace Assignment1
{
    public partial class Form1 : Form
    {

        SqlConnection dbConn;
        DataSet ds;
        SqlDataAdapter daChurches, daDeacons;
        SqlCommandBuilder cbDeacons;
        BindingSource bsChurches, bsDeacons;

        private void btnUpdateDb_Click(object sender, EventArgs e)
        {
            daDeacons.Update(ds, "deacons");
        }

        private void btnUpdateTable_Click(object sender, EventArgs e)
        {
            ds.Clear();
            daChurches.Fill(ds, "Churches");
            daDeacons.Fill(ds, "Deacons");
        }

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            dbConn = new SqlConnection("Data Source = YORKSHIRE\\SQLEXPRESS; " +
                  " Initial Catalog = Regional_District; Integrated Security = SSPI");
            ds = new DataSet();
            daChurches = new SqlDataAdapter("select * from Churches", dbConn);
            daDeacons = new SqlDataAdapter("select * from deacons", dbConn);

            cbDeacons = new SqlCommandBuilder(daDeacons);

            daChurches.Fill(ds, "Churches");
            daDeacons.Fill(ds, "Deacons");

            DataRelation dr = new DataRelation("FK_Deacons_Churches",
                ds.Tables["Churches"].Columns["ChurchID"],
                ds.Tables["deacons"].Columns["Church"]);
            ds.Relations.Add(dr);

            bsChurches = new BindingSource();
            bsChurches.DataSource = ds;
            bsChurches.DataMember = "Churches";

            dgvChurches.DataSource = bsChurches;

            //setting up binding source for the child table 
            bsDeacons = new BindingSource();
            bsDeacons.DataSource = bsChurches;
            bsDeacons.DataMember = "FK_Deacons_Churches";

            dgvDeacons.DataSource = bsDeacons;
        }
    }
}
