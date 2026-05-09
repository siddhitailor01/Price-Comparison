using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Collections.Generic;

public partial class productdetail : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string idQuery = Request.QueryString["id"];

            if (idQuery != null)
            {
                int id = Convert.ToInt32(idQuery);

                LoadProduct(id);
                LoadRelatedProducts();

                string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("SELECT * FROM Products WHERE ProductID=@id", con);
                    cmd.Parameters.AddWithValue("@id", id);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        string amazon = dr["AmazonLink"].ToString();
                        string flipkart = dr["FlipkartLink"].ToString();
                        string myntra = dr["MyntraLink"].ToString();
                        string ajio = dr["AjioLink"].ToString();
                        string croma = dr["CromaLink"].ToString();
                        string reliance = dr["RelianceLink"].ToString();
                        string meesho = dr["MeeshoLink"].ToString();
                        string shopsy = dr["ShopsyLink"].ToString();

                        amazonIcon.Visible = !string.IsNullOrWhiteSpace(amazon);
                        if (amazonIcon.Visible) amazonIcon.HRef = amazon;

                        flipkartIcon.Visible = !string.IsNullOrWhiteSpace(flipkart);
                        if (flipkartIcon.Visible) flipkartIcon.HRef = flipkart;

                        myntraIcon.Visible = !string.IsNullOrWhiteSpace(myntra);
                        if (myntraIcon.Visible) myntraIcon.HRef = myntra;

                        ajioIcon.Visible = !string.IsNullOrWhiteSpace(ajio);
                        if (ajioIcon.Visible) ajioIcon.HRef = ajio;

                        // CROMA
                        cromaIcon.Visible = !string.IsNullOrWhiteSpace(croma);
                        if (cromaIcon.Visible) cromaIcon.HRef = croma;

                        // RELIANCE
                        relianceIcon.Visible = !string.IsNullOrWhiteSpace(reliance);
                        if (relianceIcon.Visible) relianceIcon.HRef = reliance;

                        // MEESHO
                        meeshoIcon.Visible = !string.IsNullOrWhiteSpace(meesho);
                        if (meeshoIcon.Visible) meeshoIcon.HRef = meesho;

                        // SHOPSY
                        shopsyIcon.Visible = !string.IsNullOrWhiteSpace(shopsy);
                        if (shopsyIcon.Visible) shopsyIcon.HRef = shopsy;
                    }

                }
            }
        }

        if (ViewState["ProductID"] != null)
            LinkButton1.CommandArgument = ViewState["ProductID"].ToString();
        if (Session["ShowWishlistAlert"] != null)
        {
            if (Session["ShowWishlistAlert"].ToString() == "added")
                ClientScript.RegisterStartupScript(this.GetType(), "wishOK", "alert('Added to Wishlist!');", true);

            if (Session["ShowWishlistAlert"].ToString() == "exists")
                ClientScript.RegisterStartupScript(this.GetType(), "wishExists", "alert('This product is already in your wishlist!');", true);

            Session.Remove("ShowWishlistAlert");
        }


      

    }

    void LoadProduct(int productId)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand(
                @"SELECT p.ProductID, p.ProductName, p.Price, p.Features, 
                 p.Brand, p.ImageURL, c.CategoryName, p.CatID
          FROM Products p 
          INNER JOIN Category c ON p.CatID = c.CatID
          WHERE p.ProductID = @id", con);

            cmd.Parameters.AddWithValue("@id", productId);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                imgProduct.ImageUrl = "~/admin/images/" + dr["ImageURL"].ToString();
                lblName.Text = dr["ProductName"].ToString();
                lblPrice.Text = dr["Price"].ToString();
                lblBrand.Text = dr["Brand"].ToString();
                lblDescription.Text = dr["Features"].ToString();
                lblCategory.Text = dr["CategoryName"].ToString();

                ViewState["CatID"] = dr["CatID"].ToString();

                // ✅ Save ProductID for compare button
                ViewState["ProductID"] = productId;
            }
        }
    }



    void LoadRelatedProducts()
    {
        if (ViewState["CatID"] == null) return;

        int catId = Convert.ToInt32(ViewState["CatID"]);

        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand(
                @"SELECT TOP 8 ProductID, ProductName, Price, ImageURL 
                  FROM Products 
                  WHERE CatID = @cid
                  ORDER BY NEWID()", con);

            cmd.Parameters.AddWithValue("@cid", catId);

            con.Open();
            rptRelated.DataSource = cmd.ExecuteReader();
            rptRelated.DataBind();
        }
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

            // CHECK IF ALREADY IN WISHLIST
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

            // GET CURRENT PRICE
            SqlCommand priceCmd = new SqlCommand(
                "SELECT Price FROM Products WHERE ProductID=@id", con);
            priceCmd.Parameters.AddWithValue("@id", productId);

            decimal currentPrice = Convert.ToDecimal(priceCmd.ExecuteScalar());

            // INSERT INTO WISHLIST
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

    protected void btnCompare_Click(object sender, EventArgs e)
    {
        int productId = Convert.ToInt32(ViewState["ProductID"]);

        List<int> list = Session["CompareList"] as List<int>;
        if (list == null)
            list = new List<int>();

        if (!list.Contains(productId))
            list.Add(productId);

        Session["CompareList"] = list;

        Response.Redirect("compare.aspx");
    }




}
