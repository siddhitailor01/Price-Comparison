using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Linq;
using System.Collections.Generic;
using System.Web.UI.HtmlControls;

public partial class compare : System.Web.UI.Page
{
    private static DataTable currentData;

   


    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!IsPostBack)
        {
            LoadComparisonMatrix();
        }
        this.PreRender += new EventHandler(Page_PreRender);

    }

  protected void Page_PreRender(object sender, EventArgs e)
{
    thAmazon.Visible = hasAmazon;
    thFlipkart.Visible = hasFlipkart;
    thMyntra.Visible = hasMyntra;
    thAjio.Visible = hasAjio;
    thCroma.Visible = hasCroma;
    thReliance.Visible = hasReliance;
    thMeesho.Visible = hasMeesho;
    thShopsy.Visible = hasShopsy;
}


    



 private void LoadComparisonMatrix()
{
    List<int> ids = Session["CompareList"] as List<int>;
    if (ids == null || ids.Count == 0)
    {
        //lblMessage.Text = "No products selected for comparison.";
        //lblMessage.Visible = true;
        rptCompareMatrix.Visible = false;
        return;
    }

    string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;
    using (SqlConnection con = new SqlConnection(cs))
    {
        con.Open();

        // Build parameterized IN clause
        string[] parameters = ids.Select((id, index) => "@p" + index).ToArray();
        string inClause = string.Join(",", parameters);

        string query = @"
    SELECT ProductName,ImageURL,features, AmazonPrice, FlipkartPrice, MyntraPrice, AjioPrice, CromaPrice, ReliancePrice,MeeshoPrice,ShopsyPrice
    FROM Products
    WHERE ProductID IN (" + inClause + ")";


        SqlCommand cmd = new SqlCommand(query, con);
        for (int i = 0; i < ids.Count; i++)
            cmd.Parameters.AddWithValue(parameters[i], ids[i]);

        DataTable dt = new DataTable();
        dt.Load(cmd.ExecuteReader());

        if (dt.Rows.Count > 0)
        {
            rptCompareMatrix.DataSource = dt;
            rptCompareMatrix.DataBind();
        }
        else
        {
            //lblMessage.Text = "No products found for comparison.";
            //lblMessage.Visible = true;
            rptCompareMatrix.Visible = false;
        }
    }
}

 protected void rptCompareMatrix_ItemDataBound(object sender, RepeaterItemEventArgs e)
 {
     if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
     {
         DataRowView row = (DataRowView)e.Item.DataItem;

         // Prices
         var priceList = new List<Tuple<string, decimal?, Action>>
        {
            Tuple.Create("tdAmazon", ToDecimal(row["AmazonPrice"]), new Action(() => hasAmazon = true)),
            Tuple.Create("tdFlipkart", ToDecimal(row["FlipkartPrice"]), new Action(() => hasFlipkart = true)),
            Tuple.Create("tdMyntra", ToDecimal(row["MyntraPrice"]), new Action(() => hasMyntra = true)),
            Tuple.Create("tdAjio", ToDecimal(row["AjioPrice"]), new Action(() => hasAjio = true)),
            Tuple.Create("tdCroma", ToDecimal(row["CromaPrice"]), new Action(() => hasCroma = true)),
            Tuple.Create("tdReliance", ToDecimal(row["ReliancePrice"]), new Action(() => hasReliance = true)),
            Tuple.Create("tdMeesho", ToDecimal(row["MeeshoPrice"]), new Action(() => hasMeesho = true)),
            Tuple.Create("tdShopsy", ToDecimal(row["ShopsyPrice"]), new Action(() => hasShopsy = true))
        };

         decimal? minPrice = priceList.Where(p => p.Item2.HasValue && p.Item2.Value > 0)
                                      .Select(p => p.Item2.Value)
                                      .DefaultIfEmpty()
                                      .Min();

         foreach (var p in priceList)
         {
             HtmlTableCell cell = (HtmlTableCell)e.Item.FindControl(p.Item1);

             if (p.Item2.HasValue && p.Item2.Value > 0)
             {
                 cell.InnerText = "₹" + p.Item2.Value.ToString("N2");
                 if (p.Item2.Value == minPrice)
                     cell.Attributes["class"] += " lowest-price";

                 // Mark that this column has at least one valid price
                 p.Item3.Invoke();
             }
             else
             {
                 cell.Visible = false;
             }
         }
     }
 }

 // Helper method
 private decimal? ToDecimal(object val)
 {
     if (val == null || val == DBNull.Value) return null;
     decimal d;
     if (decimal.TryParse(val.ToString(), out d)) return d;
     return null;
 }



 private bool hasAmazon = false;
 private bool hasFlipkart = false;
 private bool hasMyntra = false;
 private bool hasAjio = false;
 private bool hasCroma = false;
 private bool hasReliance = false;
 private bool hasMeesho = false;
 private bool hasShopsy = false;
}

