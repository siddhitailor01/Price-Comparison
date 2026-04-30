using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        string name = txtName.Text.Trim();
        string email = txtEmail.Text.Trim();
        string pass = txtPassword.Text.Trim();

        string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            // Check email exists
            SqlCommand check = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Email=@e", con);
            check.Parameters.AddWithValue("@e", email);

            int exists = Convert.ToInt32(check.ExecuteScalar());
            if (exists > 0)
            {
                lblMsg.Text = "Email already exists!";
                return;
            }

            SqlCommand cmd = new SqlCommand(
                "INSERT INTO Users (Name, Email, Password) VALUES (@n,@e,@p)", con);

            cmd.Parameters.AddWithValue("@n", name);
            cmd.Parameters.AddWithValue("@e", email);
            cmd.Parameters.AddWithValue("@p", pass);

            cmd.ExecuteNonQuery();
        }

        lblMsg.ForeColor = System.Drawing.Color.Green;
        lblMsg.Text = "Registration successful! Redirecting...";

        Response.Redirect("login.aspx");
    }
}