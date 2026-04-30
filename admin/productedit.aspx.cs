using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.UI.WebControls;

public partial class productedit : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindCategory();

            if (Request.QueryString["id"] != null)
            {
                LoadProduct();
            }
            else
            {
                Response.Redirect("productshow.aspx");
            }
        }
    }

    private void BindCategory()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            SqlDataAdapter da = new SqlDataAdapter("SELECT CatID, CategoryName FROM Category", con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "CategoryName";
            ddlCategory.DataValueField = "CatID";
            ddlCategory.DataBind();
            ddlCategory.Items.Insert(0, new ListItem("-- Select Category --", "0"));
        }
    }

    private void LoadProduct()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string id = Request.QueryString["id"];
            SqlCommand cmd = new SqlCommand("SELECT * FROM Products WHERE ProductID=@id", con);
            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                // Category
                if (ddlCategory.Items.FindByValue(dr["CatID"].ToString()) != null)
                    ddlCategory.SelectedValue = dr["CatID"].ToString();

                txtProductName.Text = dr["ProductName"].ToString();
                txtBrand.Text = dr["Brand"].ToString();
                txtPrice.Text = dr["Price"].ToString();
                txtFeatures.Text = dr["Features"].ToString();

                // Affiliate Prices
                txtAmazonPrice.Text = dr["AmazonPrice"].ToString();
                txtFlipkartPrice.Text = dr["FlipkartPrice"].ToString();
                txtMyntraPrice.Text = dr["MyntraPrice"].ToString();
                txtAjioPrice.Text = dr["AjioPrice"].ToString();
                txtCromaPrice.Text = dr["CromaPrice"].ToString();
                txtReliancePrice.Text = dr["ReliancePrice"].ToString();
                txtMeeshoPrice.Text = dr["MeeshoPrice"].ToString();
                txtShopsyPrice.Text = dr["ShopsyPrice"].ToString();

                // Image
                imgPreview.ImageUrl = dr["ImageUrl"].ToString();

                // Affiliate Links
                txtAmazon.Text = dr["AmazonLink"].ToString();
                txtFlipkart.Text = dr["FlipkartLink"].ToString();
                txtMyntra.Text = dr["MyntraLink"].ToString();
                txtAjioLink.Text = dr["AjioLink"].ToString();
                txtCromaLink.Text = dr["CromaLink"].ToString();
                txtRelianceLink.Text = dr["RelianceLink"].ToString();
                txtMeeshoLink.Text = dr["MeeshoLink"].ToString();
                txtShopsyLink.Text = dr["ShopsyLink"].ToString();
            }
        }
    }

    protected void btnupdate_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            string imagePath = imgPreview != null ? imgPreview.ImageUrl : ""; // keep old if not updated
            string imgName = "";

            // New image uploaded
            if (FileUpload1.HasFile && FileUpload1.PostedFile.ContentLength > 0)
            {
                if (FileUpload1.PostedFile.ContentType.StartsWith("image"))
                {
                    SqlCommand countCmd = new SqlCommand("SELECT COUNT(*) FROM Products", con);
                    int count = Convert.ToInt32(countCmd.ExecuteScalar());
                    imgName = "product_" + (count + 1).ToString() + Path.GetExtension(FileUpload1.FileName);

                    string folder = Server.MapPath("~/admin/images/");
                    if (!Directory.Exists(folder))
                        Directory.CreateDirectory(folder);

                    string savePath = Path.Combine(folder, imgName);
                    FileUpload1.SaveAs(savePath);

                    imagePath = imgName; // only file name stored in DB
                }
            }

            SqlCommand cmd = new SqlCommand(@"
UPDATE Products 
SET CatID=@cat,
    ProductName=@name,
    Brand=@brand,
    Price=@price,
    Features=@features,
    ImageUrl=@img,
    AmazonPrice=@amazon,
    FlipkartPrice=@flipkart,
    MyntraPrice=@myntra,
    AjioPrice=@ajio,
    CromaPrice=@croma,
    ReliancePrice=@reliance,
    MeeshoPrice=@meesho,
    ShopsyPrice=@shopsy,
    AmazonLink=@amazonlink,
    FlipkartLink=@flipkartlink,
    MyntraLink=@myntralink,
    AjioLink=@ajiolink,
    CromaLink=@cromalink,
    RelianceLink=@reliancelink,
    MeeshoLink=@meesholink,
    ShopsyLink=@shopsylink
WHERE ProductID=@id", con);

            // Parse decimal prices
            decimal amazonPrice = 0, flipkartPrice = 0, myntraPrice = 0, ajioPrice = 0, cromaPrice = 0, reliancePrice = 0, meeshoPrice = 0, shopsyPrice = 0;
            decimal.TryParse(txtAmazonPrice.Text, out amazonPrice);
            decimal.TryParse(txtFlipkartPrice.Text, out flipkartPrice);
            decimal.TryParse(txtMyntraPrice.Text, out myntraPrice);
            decimal.TryParse(txtAjioPrice.Text, out ajioPrice);
            decimal.TryParse(txtCromaPrice.Text, out cromaPrice);
            decimal.TryParse(txtReliancePrice.Text, out reliancePrice);
            decimal.TryParse(txtMeeshoPrice.Text, out meeshoPrice);
            decimal.TryParse(txtShopsyPrice.Text, out shopsyPrice);

            cmd.Parameters.AddWithValue("@cat", ddlCategory.SelectedValue);
            cmd.Parameters.AddWithValue("@name", txtProductName.Text);
            cmd.Parameters.AddWithValue("@brand", txtBrand.Text);
            cmd.Parameters.AddWithValue("@price", txtPrice.Text);
            cmd.Parameters.AddWithValue("@features", txtFeatures.Text);
            cmd.Parameters.AddWithValue("@img", imagePath);
            cmd.Parameters.AddWithValue("@amazon", amazonPrice);
            cmd.Parameters.AddWithValue("@flipkart", flipkartPrice);
            cmd.Parameters.AddWithValue("@myntra", myntraPrice);
            cmd.Parameters.AddWithValue("@ajio", ajioPrice);
            cmd.Parameters.AddWithValue("@croma", cromaPrice);
            cmd.Parameters.AddWithValue("@reliance", reliancePrice);
            cmd.Parameters.AddWithValue("@meesho", meeshoPrice);
            cmd.Parameters.AddWithValue("@shopsy", shopsyPrice);

            cmd.Parameters.AddWithValue("@amazonlink", string.IsNullOrWhiteSpace(txtAmazon.Text) ? (object)DBNull.Value : txtAmazon.Text.Trim());
            cmd.Parameters.AddWithValue("@flipkartlink", string.IsNullOrWhiteSpace(txtFlipkart.Text) ? (object)DBNull.Value : txtFlipkart.Text.Trim());
            cmd.Parameters.AddWithValue("@myntralink", string.IsNullOrWhiteSpace(txtMyntra.Text) ? (object)DBNull.Value : txtMyntra.Text.Trim());
            cmd.Parameters.AddWithValue("@ajiolink", string.IsNullOrWhiteSpace(txtAjioLink.Text) ? (object)DBNull.Value : txtAjioLink.Text.Trim());
            cmd.Parameters.AddWithValue("@cromalink", string.IsNullOrWhiteSpace(txtCromaLink.Text) ? (object)DBNull.Value : txtCromaLink.Text.Trim());
            cmd.Parameters.AddWithValue("@reliancelink", string.IsNullOrWhiteSpace(txtRelianceLink.Text) ? (object)DBNull.Value : txtRelianceLink.Text.Trim());
            cmd.Parameters.AddWithValue("@meesholink", string.IsNullOrWhiteSpace(txtMeeshoLink.Text) ? (object)DBNull.Value : txtMeeshoLink.Text.Trim());
            cmd.Parameters.AddWithValue("@shopsylink", string.IsNullOrWhiteSpace(txtShopsyLink.Text) ? (object)DBNull.Value : txtShopsyLink.Text.Trim());

            cmd.Parameters.AddWithValue("@id", Request.QueryString["id"]);

            cmd.ExecuteNonQuery();

            lblMsg.Text = "✅ Product updated successfully!";
            lblMsg.CssClass = "text-success";

            Response.AddHeader("REFRESH", "2;URL=productshow.aspx");
        }
    }
}
