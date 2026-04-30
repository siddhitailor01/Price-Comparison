using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

public partial class admin_login : Page
{
    string connStr = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblError.Text = "";
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string username = txtusername.Text.Trim();
        string password = txtpassword.Text.Trim();

        if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
        {
            lblError.Text = "Please enter both username and password.";
            return;
        }

        try
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT COUNT(*) FROM admin WHERE username=@username AND password=@password";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@username", username);
                    cmd.Parameters.AddWithValue("@password", password);

                    con.Open();
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    con.Close();

                    if (count > 0)
                    {
                        Session["adminUser"] = username;

                        string returnUrl = Request.QueryString["ReturnUrl"];
                        if (!string.IsNullOrEmpty(returnUrl))
                            Response.Redirect(returnUrl);
                        else
                            Response.Redirect("~/admin/dashboard.aspx");
                    }
                    else
                    {
                        lblError.Text = "Invalid username or password.";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblError.Text = "Error: " + ex.Message;
        }
    }
}
