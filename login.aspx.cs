using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class login : System.Web.UI.Page
{
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        string pass = txtPassword.Text.Trim();

        string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "SELECT UserID, Name FROM Users WHERE Email=@e AND Password=@p", con);

            cmd.Parameters.AddWithValue("@e", email);
            cmd.Parameters.AddWithValue("@p", pass);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                // STORE LOGIN DATA IN SESSION
                Session["UserID"] = dr["UserID"];
                Session["UserName"] = dr["Name"];

                // GET RETURN URL (if exists)
                string returnUrl = Request.QueryString["returnUrl"];

                if (!string.IsNullOrEmpty(returnUrl))
                {
                    Response.Redirect(returnUrl);
                }
                else
                {
                    Response.Redirect("index.aspx");
                }
            }
            else
            {
                lblMsg.Text = "Invalid email or password!";
            }
        }
    }
}
