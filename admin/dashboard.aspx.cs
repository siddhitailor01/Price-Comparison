using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class dashboard : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["mycon"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDashboardData();
        }
    }

    private void LoadDashboardData()
    {
        con.Open();

        SqlCommand cmd1 = new SqlCommand("SELECT COUNT(*) FROM Products", con);
        lblTotalProducts.Text = cmd1.ExecuteScalar().ToString();

        SqlCommand cmd2 = new SqlCommand("SELECT COUNT(*) FROM Category", con);
        lblTotalCategories.Text = cmd2.ExecuteScalar().ToString();

      

        con.Close();
    }
}
