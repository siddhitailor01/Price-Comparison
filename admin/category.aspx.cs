using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class category : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtcategory.Text = "";
            ddlParent.ClearSelection();
            BindParentCategories();
            BindCategories();
            ddlParent.SelectedValue = "0"; // DEFAULT always main category
            Button1.Visible = false;
        }
    }

    // ------------------------------------------
    // BIND ONLY MAIN CATEGORIES AS PARENT
    private void BindParentCategories()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string q = "SELECT CatID, CategoryName FROM Category ORDER BY CategoryName";

            SqlDataAdapter da = new SqlDataAdapter(q, con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlParent.DataSource = dt;
            ddlParent.DataTextField = "CategoryName";
            ddlParent.DataValueField = "CatID";
            ddlParent.DataBind();

            ddlParent.Items.Insert(0, new System.Web.UI.WebControls.ListItem("— No Parent — (Main Category)", "0"));
        }
    }


    // ------------------------------------------
    // SHOW ALL CATEGORIES + THEIR PARENT NAME
    // ------------------------------------------
    private void BindCategories()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string q = @"
                SELECT c.CatID, 
                       c.CategoryName,
                       ISNULL(p.CategoryName, '—') AS ParentCategory
                FROM Category c
                LEFT JOIN Category p ON c.ParentID = p.CatID
                ORDER BY c.CatID DESC";

            SqlDataAdapter da = new SqlDataAdapter(q, con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            lstview.DataSource = dt;
            lstview.DataBind();
        }
    }

    // ------------------------------------------
    // INSERT CATEGORY
    // ------------------------------------------
    protected void btnsave_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = "INSERT INTO Category (CategoryName, ParentID) VALUES (@Name, @ParentID)";
            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@Name", txtcategory.Text.Trim());

            int? parentId = ddlParent.SelectedValue == "0" ? (int?)null : Convert.ToInt32(ddlParent.SelectedValue);
            cmd.Parameters.AddWithValue("@ParentID", (object)parentId ?? DBNull.Value);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            txtcategory.Text = "";
            ddlParent.SelectedIndex = 0;

            BindCategories();
            BindParentCategories();
        }
    }

    // ------------------------------------------
    // LISTVIEW COMMANDS (EDIT + DELETE)
    // ------------------------------------------
    protected void lstview_ItemCommand(object sender, System.Web.UI.WebControls.ListViewCommandEventArgs e)
    {
        int id = Convert.ToInt32(e.CommandArgument);

        // DELETE --------------------------
        if (e.CommandName == "delete")
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                // FIRST CHECK IF SUBCATEGORIES EXIST
                SqlCommand chk = new SqlCommand("SELECT COUNT(*) FROM Category WHERE ParentID = @id", con);
                chk.Parameters.AddWithValue("@id", id);

                con.Open();
                int count = Convert.ToInt32(chk.ExecuteScalar());

                if (count > 0)
                {
                    // Cannot delete main category having sub-categories
                    Response.Write("<script>alert('⚠ Cannot delete this category. It has sub-categories under it.');</script>");
                    con.Close();
                    return;
                }

                SqlCommand cmd = new SqlCommand("DELETE FROM Category WHERE CatID=@id", con);
                cmd.Parameters.AddWithValue("@id", id);

                cmd.ExecuteNonQuery();
                con.Close();
            }

            BindCategories();
            BindParentCategories();
        }

        // EDIT ------------------------------
        if (e.CommandName == "edit")
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT CategoryName, ParentID FROM Category WHERE CatID=@id", con);
                cmd.Parameters.AddWithValue("@id", id);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtcategory.Text = dr["CategoryName"].ToString();
                    lbledit.Text = id.ToString();

                    ddlParent.SelectedValue = dr["ParentID"] == DBNull.Value ? "0" : dr["ParentID"].ToString();

                    btnsave.Visible = false;
                    Button1.Visible = true;
                }
                con.Close();
            }
        }
    }

    // ------------------------------------------
    // UPDATE CATEGORY
    // ------------------------------------------
    protected void Button1_Click(object sender, EventArgs e)
    {
        int id = Convert.ToInt32(lbledit.Text);

        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlCommand cmd = new SqlCommand(
                "UPDATE Category SET CategoryName=@name, ParentID=@parent WHERE CatID=@id", con);

            cmd.Parameters.AddWithValue("@name", txtcategory.Text.Trim());

            int? parentId = ddlParent.SelectedValue == "0" ? (int?)null : Convert.ToInt32(ddlParent.SelectedValue);
            cmd.Parameters.AddWithValue("@parent", (object)parentId ?? DBNull.Value);

            cmd.Parameters.AddWithValue("@id", id);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }

        txtcategory.Text = "";
        ddlParent.SelectedIndex = 0;
        Button1.Visible = false;
        btnsave.Visible = true;

        BindCategories();
        BindParentCategories();
    }

    protected void lstview_ItemDeleting(object sender, System.Web.UI.WebControls.ListViewDeleteEventArgs e)
    {
        // Not used – handled in ItemCommand
    }
}
