using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Collections.Generic;
using System.Web;

public partial class index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string catId = Request.QueryString["CatID"];

            if (!string.IsNullOrEmpty(catId))
            {
                sidebarPanel.Visible = true;
                productPanel.CssClass = "col-md-9";
            }
            else
            {
                sidebarPanel.Visible = false;
                productPanel.CssClass = "col-md-12";
            }

            if (Request.QueryString["CatID"] != null)
            {
                int id = Convert.ToInt32(Request.QueryString["CatID"]);

                LoadSingleCategory(id);

                BindSidebarSubCategories(id);
            }

            else
            {
                LoadCategorySections();
            }

            string search = Request.QueryString["search"];
            if (!string.IsNullOrEmpty(search))
            {
                TextBox txtSearch = (TextBox)Master.FindControl("txtSearch");
                if (txtSearch != null) txtSearch.Text = search;

                LoadSearchResults(search);
            }
        }

        if (Session["ShowWishlistAlert"] != null)
        {
            if (Session["ShowWishlistAlert"].ToString() == "added")
                ClientScript.RegisterStartupScript(this.GetType(), "wishOK", "alert('Added to Wishlist!');", true);

            if (Session["ShowWishlistAlert"].ToString() == "exists")
                ClientScript.RegisterStartupScript(this.GetType(), "wishExists", "alert('This product is already in your wishlist!');", true);

            Session.Remove("ShowWishlistAlert");
        }
    }

    private void BindSidebarSubCategories(int parentID)
    {
        string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            string q = "SELECT CatID, CategoryName FROM Category WHERE ParentID = @p";

            SqlCommand cmd = new SqlCommand(q, con);
            cmd.Parameters.AddWithValue("@p", parentID);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptSideCategories.DataSource = dt;
            rptSideCategories.DataBind();
        }
    }

    private bool HasChildCategories(int catId)
    {
        string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand(
                "SELECT COUNT(*) FROM Category WHERE ParentID=@id", con);
            cmd.Parameters.AddWithValue("@id", catId);
            con.Open();

            return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
        }
    }




  
    private List<int> GetAllSubCategories(int catId)
    {
        List<int> list = new List<int>();
        list.Add(catId);

        string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand(
                "SELECT CatID FROM Category WHERE ParentID = @id", con);
            cmd.Parameters.AddWithValue("@id", catId);

            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                int subId = Convert.ToInt32(dr["CatID"]);
                list.AddRange(GetAllSubCategories(subId));  
            }
        }
        return list;
    }

   
    private void LoadCategorySections()
    {
        string connStr = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        using (SqlConnection con = new SqlConnection(connStr))
        {
            con.Open();

            string catQuery = "SELECT CatID, CategoryName FROM Category WHERE ParentID IS NULL ORDER BY CategoryName";
            SqlDataAdapter daCat = new SqlDataAdapter(catQuery, con);
            DataTable dtCat = new DataTable();
            daCat.Fill(dtCat);

            List<CategorySection> categories = new List<CategorySection>();

            foreach (DataRow cat in dtCat.Rows)
            {
                int mainCatID = Convert.ToInt32(cat["CatID"]);

                List<int> allCats = GetAllSubCategories(mainCatID);
                string ids = string.Join(",", allCats);

                string prodQuery = "SELECT * FROM Products WHERE CatID IN (" + ids + ") ORDER BY CreatedAt DESC";

                SqlDataAdapter daProd = new SqlDataAdapter(prodQuery, con);
                DataTable dtProd = new DataTable();
                daProd.Fill(dtProd);

                if (dtProd.Rows.Count == 0) continue;

                categories.Add(new CategorySection
                {
                    CatID = mainCatID,
                    CategoryName = cat["CategoryName"].ToString(),
                    Products = dtProd
                });
            }

            rptMainCategory.DataSource = categories;
            rptMainCategory.DataBind();
        }
    }

 
    private void LoadSearchResults(string keyword)
    {
        string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            string q = @"
                SELECT * FROM Products 
                WHERE ProductName LIKE '%' + @k + '%'
                   OR Brand LIKE '%' + @k + '%'
                   OR Features LIKE '%' + @k + '%'
            ";

            SqlCommand cmd = new SqlCommand(q, con);
            cmd.Parameters.AddWithValue("@k", keyword);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            var list = new List<CategorySection>();
            list.Add(new CategorySection
            {
                CatID = 0,
                CategoryName = "Search Results",
                Products = dt
            });

            rptMainCategory.DataSource = list;
            rptMainCategory.DataBind();
        }
    }

   
    private void LoadSingleCategory(int catId)
    {
        string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        bool hasChild = HasChildCategories(catId);

        sidebarPanel.Visible = hasChild;   
        if (hasChild)
        {
            productPanel.CssClass = "col-md-9";
        }
        else
        {
            productPanel.CssClass = "col-md-12";
        }


        if (hasChild)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT CatID, CategoryName FROM Category WHERE ParentID=@id", con);
                da.SelectCommand.Parameters.AddWithValue("@id", catId);

                DataTable dt = new DataTable();
                da.Fill(dt);

                rptSideCategories.DataSource = dt;
                rptSideCategories.DataBind();
            }
        }

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            SqlCommand cmdCat = new SqlCommand("SELECT CategoryName FROM Category WHERE CatID=@id", con);
            cmdCat.Parameters.AddWithValue("@id", catId);

            string catName = (cmdCat.ExecuteScalar() ?? "Products").ToString();

            List<int> allCats = GetAllSubCategories(catId);
            string ids = string.Join(",", allCats);

            SqlDataAdapter daProd = new SqlDataAdapter(
                "SELECT * FROM Products WHERE CatID IN (" + ids + ")", con);

            DataTable dtProd = new DataTable();
            daProd.Fill(dtProd);

            var list = new List<CategorySection>();
            list.Add(new CategorySection
            {
                CatID = catId,
                CategoryName = catName,
                Products = dtProd
            });

            rptMainCategory.DataSource = list;
            rptMainCategory.DataBind();
        }
    }


    [WebMethod]
    public static List<string> GetSearchSuggestions(string prefix)
    {
        List<string> list = new List<string>();
        string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            string q = "SELECT TOP 10 ProductName FROM Products WHERE ProductName LIKE @p + '%'";
            SqlCommand cmd = new SqlCommand(q, con);
            cmd.Parameters.AddWithValue("@p", prefix);
            con.Open();

            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
                list.Add(dr["ProductName"].ToString());
        }
        return list;
    }


    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("login.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl));
            return;
        }

        LinkButton btn = (LinkButton)sender;
        int productId = Convert.ToInt32(btn.CommandArgument);
        int userId = Convert.ToInt32(Session["UserID"]);

        string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            SqlCommand checkCmd = new SqlCommand(
                "SELECT COUNT(*) FROM Wishlist WHERE UserID=@u AND ProductID=@p", con);

            checkCmd.Parameters.AddWithValue("@u", userId);
            checkCmd.Parameters.AddWithValue("@p", productId);

            int already = Convert.ToInt32(checkCmd.ExecuteScalar());

            if (already > 0)
            {
                Session["ShowWishlistAlert"] = "exists";
                Response.Redirect(Request.RawUrl);
                return;
            }

            SqlCommand priceCmd = new SqlCommand(
                "SELECT Price FROM Products WHERE ProductID=@id", con);
            priceCmd.Parameters.AddWithValue("@id", productId);

            decimal currentPrice = Convert.ToDecimal(priceCmd.ExecuteScalar());

            SqlCommand insertCmd = new SqlCommand(@"
                INSERT INTO Wishlist (UserID, ProductID, OldPrice, AddedDate)
                VALUES (@u, @p, @old, GETDATE())", con);

            insertCmd.Parameters.AddWithValue("@u", userId);
            insertCmd.Parameters.AddWithValue("@p", productId);
            insertCmd.Parameters.AddWithValue("@old", currentPrice);

            insertCmd.ExecuteNonQuery();
        }

        Session["ShowWishlistAlert"] = "added";
        Response.Redirect(Request.RawUrl);
    }


    public class CategorySection
    {
        public int CatID { get; set; }
        public string CategoryName { get; set; }
        public DataTable Products { get; set; }
    }



    
[WebMethod(EnableSession = true)]
public static List<int> AddToCompare(int productId)
{
    var ctx = HttpContext.Current;
    List<int> list = ctx.Session["CompareList"] as List<int>;
    if (list == null) list = new List<int>();

    if (!list.Contains(productId))
    {
        list.Add(productId);

    }

    ctx.Session["CompareList"] = list;
    return list;
}

[WebMethod(EnableSession = true)]
public static List<int> RemoveFromCompare(int productId)
{
    var ctx = HttpContext.Current;
    List<int> list = ctx.Session["CompareList"] as List<int>;
    if (list == null) list = new List<int>();

    if (list.Contains(productId))
        list.Remove(productId);

    ctx.Session["CompareList"] = list;
    return list;
}

[WebMethod(EnableSession = true)]
public static List<int> GetCompareList()
{
    var ctx = HttpContext.Current;
    List<int> list = ctx.Session["CompareList"] as List<int>;
    if (list == null) list = new List<int>();
    return list;
}

[WebMethod(EnableSession = true)]
public static List<ProductSummary> GetProductsSummary(List<int> ids)
{
    var ctx = HttpContext.Current;
    List<ProductSummary> outList = new List<ProductSummary>();
    if (ids == null || ids.Count == 0) return outList;

    string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;
    using (SqlConnection con = new SqlConnection(cs))
    {
        con.Open();
        string inClause = "";
        for (int i = 0; i < ids.Count; i++)
        {
            if (i > 0) inClause += ",";
            inClause += "@p" + i;
        } 
        string q = "SELECT ProductID, ProductName, ImageURL FROM Products WHERE ProductID IN (" + inClause + ")";
        SqlCommand cmd = new SqlCommand(q, con);
        for (int i = 0; i < ids.Count; i++) cmd.Parameters.AddWithValue("@p" + i, ids[i]);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            outList.Add(new ProductSummary
            {
                ProductID = Convert.ToInt32(dr["ProductID"]),
                ProductName = dr["ProductName"].ToString(),
                ImageUrl = ResolveImageUrl(dr["ImageURL"].ToString())
            });
        }
    }
    return outList;
}

public class ProductSummary
{
    public int ProductID { get; set; }
    public string ProductName { get; set; }
    public string ImageUrl { get; set; }
}

private static string ResolveImageUrl(string img)
{
    if (string.IsNullOrEmpty(img)) return "~/images/noimage.png";
    return VirtualPathUtility.ToAbsolute("~/admin/images/" + img);
}


[WebMethod(EnableSession = true)]
public static string ClearCompare()
{
    HttpContext.Current.Session["CompareList"] = new List<int>();
    return "cleared";
}



}
