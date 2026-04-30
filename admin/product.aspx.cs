using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class product : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            BindCategory();
        }
    }

    private void BindCategory()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        { 
        SqlCommand cmd = new SqlCommand("Select CatID , CategoryName From Category",con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            ddlCategory.DataSource = dr;
            ddlCategory.DataTextField = "CategoryName";
            ddlCategory.DataValueField = "CatID";
            ddlCategory.DataBind();

            ddlCategory.Items.Insert(0,"-- Select Category --");
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string imgName = "";

        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            // 🧮 Count total products
            SqlCommand countCmd = new SqlCommand("SELECT COUNT(*) FROM Products", con);
            int count = Convert.ToInt32(countCmd.ExecuteScalar());

            // 🖼️ agar file upload hui hai
            if (FileUpload1.HasFile && FileUpload1.PostedFile.ContentLength > 0)
            {
                if (FileUpload1.PostedFile.ContentType.StartsWith("image"))
                {
                    // image name generate karo
                    imgName = "product_" + (count + 1).ToString() + Path.GetExtension(FileUpload1.FileName);

                    // folder path set
                    string folder = Server.MapPath("~/admin/images/");
                    if (!Directory.Exists(folder))
                        Directory.CreateDirectory(folder);

                    string savePath = Path.Combine(folder, imgName);
                    FileUpload1.SaveAs(savePath);
                }
            }

            // 💾 Insert query (sirf filename save hoga)
            string query = @"INSERT INTO Products
(CatID, ProductName, Brand, Price, Features, AmazonPrice, FlipkartPrice, MyntraPrice, AjioPrice, CromaPrice, ReliancePrice,MeeshoPrice,ShopsyPrice, ImageURL,
 AmazonLink, FlipkartLink, MyntraLink, AjioLink, CromaLink, RelianceLink,MeeshoLink,ShopsyLink)
VALUES
(@CatID, @ProductName, @Brand, @Price, @Features, @amazon, @flipkart, @myntra, @ajio, @croma, @reliance,@meesho,@shopsy, @ImageURL,
 @AmazonLink, @FlipkartLink, @MyntraLink, @AjioLink, @CromaLink, @RelianceLink,@MeeshoLink,@ShopsyLink)";



            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@CatID", ddlCategory.SelectedValue);
            cmd.Parameters.AddWithValue("@ProductName", txtProductName.Text.Trim());
            cmd.Parameters.AddWithValue("@Brand", txtBrand.Text.Trim());
            cmd.Parameters.AddWithValue("@Price", Convert.ToDecimal(txtPrice.Text.Trim()));
            cmd.Parameters.AddWithValue("@Features", txtFeatures.Text.Trim());
            cmd.Parameters.AddWithValue("@amazon", Convert.ToDecimal(txtamazonprice.Text.Trim()));
            cmd.Parameters.AddWithValue("@flipkart", Convert.ToDecimal(txtflipkartprice.Text.Trim()));
            cmd.Parameters.AddWithValue("@myntra", Convert.ToDecimal(txtmyntraprice.Text.Trim()));
            cmd.Parameters.AddWithValue("@ajio", Convert.ToDecimal(txtajioprice.Text.Trim()));
            cmd.Parameters.AddWithValue("@croma", Convert.ToDecimal(txtcromaprice.Text.Trim()));
            cmd.Parameters.AddWithValue("@reliance", Convert.ToDecimal(txtrelianceprice.Text.Trim()));
            cmd.Parameters.AddWithValue("@meesho", Convert.ToDecimal(txtmeeshoprice.Text.Trim()));
            cmd.Parameters.AddWithValue("@shopsy", Convert.ToDecimal(txtshopsyprice.Text.Trim()));

            cmd.Parameters.AddWithValue("@ImageURL", imgName); // only file name
            cmd.Parameters.AddWithValue("@AmazonLink",
    string.IsNullOrWhiteSpace(txtAmazon.Text) ? (object)DBNull.Value : txtAmazon.Text.Trim());

            cmd.Parameters.AddWithValue("@FlipkartLink",
                string.IsNullOrWhiteSpace(txtFlipkart.Text) ? (object)DBNull.Value : txtFlipkart.Text.Trim());

            cmd.Parameters.AddWithValue("@MyntraLink",
                string.IsNullOrWhiteSpace(txtMyntra.Text) ? (object)DBNull.Value : txtMyntra.Text.Trim());

            cmd.Parameters.AddWithValue("@AjioLink",
    string.IsNullOrWhiteSpace(txtAjioLink.Text) ? (object)DBNull.Value : txtAjioLink.Text.Trim());

            cmd.Parameters.AddWithValue("@CromaLink",
                string.IsNullOrWhiteSpace(txtCromaLink.Text) ? (object)DBNull.Value : txtCromaLink.Text.Trim());

            cmd.Parameters.AddWithValue("@RelianceLink",
                string.IsNullOrWhiteSpace(txtRelianceLink.Text) ? (object)DBNull.Value : txtRelianceLink.Text.Trim());

            cmd.Parameters.AddWithValue("@MeeshoLink",
                string.IsNullOrWhiteSpace(txtAjioLink.Text) ? (object)DBNull.Value : txtAjioLink.Text.Trim());

            cmd.Parameters.AddWithValue("@ShopsyLink",
                string.IsNullOrWhiteSpace(txtCromaLink.Text) ? (object)DBNull.Value : txtCromaLink.Text.Trim());


            cmd.ExecuteNonQuery();
            con.Close();

            lblMsg.Text = "✅ Product added successfully!";
            ClearFields();
        }
    }

    private void ClearFields()
    {
        txtProductName.Text = "";
        txtBrand.Text = "";
        txtPrice.Text = "";
        txtFeatures.Text = "";
        txtamazonprice.Text = "";
        txtflipkartprice.Text = "";
        txtmyntraprice.Text = "";
        txtajioprice.Text = "";
        txtcromaprice.Text = "";
        txtrelianceprice.Text = "";
        txtmeeshoprice.Text = "";
        txtshopsyprice.Text = "";

        ddlCategory.SelectedIndex = 0;
        txtAmazon.Text = "";
        txtFlipkart.Text = "";
        txtMyntra.Text = "";
        txtAjioLink.Text = "";
        txtCromaLink.Text = "";
        txtRelianceLink.Text = "";
        txtMesshoLink.Text = "";
        txtShopsyLink.Text = "";

    }
}