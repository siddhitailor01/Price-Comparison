using System;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;

public partial class pricecheck : System.Web.UI.Page
{
    string cs = @"Data Source=DESKTOP-6D6SRJM;Initial Catalog=price;Integrated Security=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadWishlistProducts();
        }
    }

    // ================= SHOW WISHLIST PRODUCTS =====================
    void LoadWishlistProducts()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlDataAdapter da = new SqlDataAdapter(@"
                SELECT W.WishlistID, W.UserID, W.ProductID, W.OldPrice,
                       P.ProductName, P.Price,
                       U.Email
                FROM Wishlist W
                JOIN Products P ON W.ProductID = P.ProductID
                JOIN Users U ON W.UserID = U.UserID
                ORDER BY W.AddedDate DESC", con);

            DataTable dt = new DataTable();
            da.Fill(dt);

            lstFollowed.DataSource = dt;
            lstFollowed.DataBind();
        }
    }

    // ================= CHECK PRICE DROP =====================
    protected void btnCheckPrice_Click(object sender, EventArgs e)
    {
        int count = 0;

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            SqlDataAdapter da = new SqlDataAdapter(@"
                SELECT W.WishlistID, W.OldPrice, W.ProductID,
                       P.ProductName, P.Price,
                       U.Email
                FROM Wishlist W
                JOIN Products P ON W.ProductID = P.ProductID
                JOIN Users U ON W.UserID = U.UserID", con);

            DataTable dt = new DataTable();
            da.Fill(dt);

            foreach (DataRow r in dt.Rows)
            {
                decimal oldPrice = Convert.ToDecimal(r["OldPrice"]);
                decimal newPrice = Convert.ToDecimal(r["Price"]);

                if (newPrice < oldPrice) // PRICE DROPPED
                {
                    try
                    {
                        SendEmail(
                            r["Email"].ToString(),
                            r["ProductName"].ToString(),
                            oldPrice,
                            newPrice
                        );
                    }
                    catch { }

                    // update old price
                    SqlCommand update = new SqlCommand(
                        "UPDATE Wishlist SET OldPrice=@newPrice WHERE WishlistID=@id", con);

                    update.Parameters.AddWithValue("@newPrice", newPrice);
                    update.Parameters.AddWithValue("@id", r["WishlistID"]);
                    update.ExecuteNonQuery();

                    count++;
                }
            }
        }

        lblMsg.Text = count + " users notified!";
        LoadWishlistProducts();
    }

    // ================= SEND EMAIL =====================
    void SendEmail(string email, string productName, decimal oldPrice, decimal newPrice)
    {
        MailMessage msg = new MailMessage();
        msg.From = new MailAddress("siddhitailor91@gmail.com");
        msg.To.Add(email);
        msg.Subject = "Price Drop Alert!";
        msg.Body =
            "Good News!\n\n" +
            productName + " price dropped from ₹" + oldPrice +
            " to ₹" + newPrice + "\n\nCheck it now on website!";

        SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
        smtp.EnableSsl = true;
        smtp.Credentials = new NetworkCredential(
            "siddhitailor91@gmail.com",
            "qdybqjokzkdjfnai" // app password
        );

        smtp.Send(msg);
    }
}
