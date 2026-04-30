using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class productshow : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        BindProducts();
    }

    private void BindProducts()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"
            SELECT ProductID, CatID, ProductName, Brand, Price, Features, ImageURL,
                   AmazonLink, FlipkartLink, MyntraLink,
                   AmazonPrice, FlipkartPrice, MyntraPrice, AjioPrice, CromaPrice, ReliancePrice
            FROM Products";

            SqlCommand cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            lstshow.DataSource = dt;
            lstshow.DataBind();
        }
    }



    protected void lstshow_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "delete") {
            int productid = Convert.ToInt32(e.CommandArgument);
            using (SqlConnection con = new SqlConnection(conStr)) {
                SqlCommand cmd = new SqlCommand("Delete from Products where ProductID=@id", con);
                cmd.Parameters.AddWithValue("@id", productid);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            BindProducts();
        }

        if (e.CommandName == "edit") {
            string id = e.CommandArgument.ToString();
            Response.Redirect("productedit.aspx?id=" + id);
        }


    }
    protected void lstshow_ItemDeleting(object sender, ListViewDeleteEventArgs e)
    {

    }
}