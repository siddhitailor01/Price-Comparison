using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class wishlist : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }
            BindWishlist();
        }
    }

    void BindWishlist()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand(@"
                SELECT W.ProductID, P.ProductName, P.Brand, P.Price, P.ImageURL
                FROM Wishlist W
                INNER JOIN Products P ON W.ProductID = P.ProductID
                WHERE W.UserID=@uid", con);

            cmd.Parameters.AddWithValue("@uid", Session["UserID"]);

            con.Open();
            rptWishlist.DataSource = cmd.ExecuteReader();
            rptWishlist.DataBind();
        }
    }

    protected void btnRemove_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        int pid = Convert.ToInt32(btn.CommandArgument);

        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand(
                "DELETE FROM Wishlist WHERE UserID=@u AND ProductID=@p", con);

            cmd.Parameters.AddWithValue("@u", Session["UserID"]);
            cmd.Parameters.AddWithValue("@p", pid);

            con.Open();
            cmd.ExecuteNonQuery();
        }

        BindWishlist();
    }
}
