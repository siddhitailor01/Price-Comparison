using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.Services;
using System.Data;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindNavCategories();
            BindCategories();

        }
    }

    private void BindCategories()
    {
        string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("SELECT CatID, CategoryName FROM Category WHERE ParentID IS NULL ORDER BY CategoryName", con);
            con.Open();

            ddlCompareCategory.DataSource = cmd.ExecuteReader();
            ddlCompareCategory.DataTextField = "CategoryName";
            ddlCompareCategory.DataValueField = "CatID";
            ddlCompareCategory.DataBind();

            ddlCompareCategory.Items.Insert(0, new ListItem("-- Select Category --", "0"));
        }
    }




    private void BindNavCategories()
    {
        string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"
            SELECT CatID, CategoryName, ParentID
            FROM Category
            ORDER BY ParentID, CategoryName";

            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            // MAIN CATEGORIES
            DataView dvMain = new DataView(dt);
            dvMain.RowFilter = "ParentID IS NULL";

            rptMenuCategory.DataSource = dvMain;
            rptMenuCategory.DataBind();
        }
    }

    protected void ddlCompareCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCompareCategory.SelectedValue == "0")
            return;

        int catId = Convert.ToInt32(ddlCompareCategory.SelectedValue);
        List<int> ids = new List<int>();

        string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            string q = @"
        WITH CatTree AS (
            SELECT CatID FROM Category WHERE CatID = @CatID
            UNION ALL
            SELECT c.CatID
            FROM Category c
            INNER JOIN CatTree ct ON c.ParentID = ct.CatID
        )
        SELECT ProductID
        FROM Products
        WHERE CatID IN (SELECT CatID FROM CatTree)";

            using (SqlCommand cmd = new SqlCommand(q, con))
            {
                cmd.Parameters.AddWithValue("@CatID", catId);

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                        ids.Add(Convert.ToInt32(dr["ProductID"]));
                }
            }
        }

        // 👇 MOST IMPORTANT LINE
        Session["CompareList"] = ids;

        // Redirect
        Response.Redirect("compare.aspx");
    }


    private List<int> GetProductIdsByCategory(int catId)
    {
        List<int> ids = new List<int>();
        string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        using (SqlCommand cmd = new SqlCommand(@"
        SELECT ProductID
        FROM Products
        WHERE CatID=@CatID
           OR CatID IN (SELECT CatID FROM Category WHERE ParentID=@CatID)
    ", con))
        {
            cmd.Parameters.AddWithValue("@CatID", catId);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
                ids.Add(Convert.ToInt32(dr["ProductID"]));
        }

        return ids;
    }





    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);

        if (currentPage.ToLower() == "compare.aspx")
        {
            Response.Redirect("compare.aspx?search=" + txtSearch.Text);
        }
        else
        {
            Response.Redirect("index.aspx?search=" + txtSearch.Text);
        }

    }

   

    protected void rptMenuCategory_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item ||
            e.Item.ItemType == ListItemType.AlternatingItem)
        {
            int mainCatId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "CatID"));

            Repeater rptSub = (Repeater)e.Item.FindControl("rptSubCategory");

            string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT CatID, CategoryName FROM Category WHERE ParentID=@p", con);

                da.SelectCommand.Parameters.AddWithValue("@p", mainCatId);

                DataTable dt = new DataTable();
                da.Fill(dt);

                rptSub.DataSource = dt;
                rptSub.DataBind();
            }
        }
    }



  
}
