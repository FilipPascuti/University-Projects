using System;
using System.Data;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Xml;

namespace Assignment2
{
    public partial class Form1 : Form
    {
        SqlConnection dbConn;
        DataSet ds;
        SqlDataAdapter daParent, daChild;
        SqlCommandBuilder cbChild;
        BindingSource bsParent, bsChild;
        string connectionString, parent, parentQuery, parentPK, child, childQuery, childFK;

        private void btnUpdateViews_Click(object sender, EventArgs e)
        {
            ds.Clear();
            daParent.Fill(ds, parent);
            daChild.Fill(ds, child);
        }

        private void btnUpdateDb_Click(object sender, EventArgs e)
        {
            daChild.Update(ds, child);
        }

        private void ConfigProperties()
        {
            XmlTextReader reader = new XmlTextReader("D:\\Facultate\\Anul_2\\Semestrul2\\DBMS\\Assignments\\Assignment2\\Assignment2\\Assignment2\\config.xml");
            
            reader.ReadToFollowing("parent");
            parent = reader.ReadElementContentAsString();

            //reader.ReadToFollowing("parent-query");
            //parentQuery = reader.ReadElementContentAsString();

            parentQuery = "select * from " + parent;

            reader.ReadToFollowing("parentPK");
            parentPK = reader.ReadElementContentAsString();

            reader.ReadToFollowing("child");
            child = reader.ReadElementContentAsString();

            //reader.ReadToFollowing("child-query");
            //childQuery = reader.ReadElementContentAsString();

            childQuery = "select * from " + child;

            reader.ReadToFollowing("childFK");
            childFK = reader.ReadElementContentAsString();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            ConfigProperties();
            dbConn = new SqlConnection("Data Source = YORKSHIRE\\SQLEXPRESS; " +
                  " Initial Catalog = Regional_District; Integrated Security = SSPI");
            
            ds = new DataSet();
            
            daParent = new SqlDataAdapter(parentQuery, dbConn);
            daChild = new SqlDataAdapter(childQuery, dbConn);

            cbChild = new SqlCommandBuilder(daChild);

            daParent.Fill(ds, parent);
            daChild.Fill(ds, child);

            DataRelation dr = new DataRelation("FK_Children_Parent",
                ds.Tables[parent].Columns[parentPK],
                ds.Tables[child].Columns[childFK]);
            ds.Relations.Add(dr);

            bsParent = new BindingSource();
            bsParent.DataSource = ds;
            bsParent.DataMember = parent;

            dgvParent.DataSource = bsParent;

            bsChild = new BindingSource();
            bsChild.DataSource = bsParent;
            bsChild.DataMember = "FK_Children_Parent";

            dgvChild.DataSource = bsChild;




        }

        public Form1()
        {
            InitializeComponent();
        }




    }
}
