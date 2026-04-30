<%@ Page Title="Compare Products" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="compare.aspx.cs" Inherits="compare" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>

<style>
    :root {
        --primary: #6d28d9;
        --primary-dark: #4c1d95;
        --primary-light: #a78bfa;
        --secondary: #f59e0b;
        --accent: #10b981;
        --dark: #1e1b4b;
        --light: #f9fafb;
        --gradient-primary: linear-gradient(135deg, #6d28d9 0%, #8b5cf6 100%);
        --gradient-secondary: linear-gradient(135deg, #f59e0b 0%, #fbbf24 100%);
        --gradient-accent: linear-gradient(135deg, #10b981 0%, #34d399 100%);
        --card-shadow: 0 12px 30px -5px rgba(0,0,0,0.15);
        --hover-shadow: 0 18px 35px rgba(109,40,217,0.25);
    }

    body {
        background: radial-gradient(circle at top left, #ede9fe, #e0f2fe, #f0f9ff);
        font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: #1e293b;
        min-height: 100vh;

    }

    /* Header Section */
    .page-header {
        text-align: center;
        padding: 2rem 0 1rem;
        background: linear-gradient(135deg, rgba(109,40,217,0.05) 0%, rgba(16,185,129,0.05) 100%);
        margin-bottom: 2rem;
        border-radius: 0 0 30px 30px;
    }

    .page-title {
        font-weight: 800;
        color: var(--primary);
        margin: 0;
        font-size: 2.5rem;
        letter-spacing: -0.5px;
        background: var(--gradient-primary);
        -webkit-background-clip: text;
        background-clip: text;
        color: transparent;
        text-shadow: 0 4px 8px rgba(109,40,217,0.1);
    }

    .page-subtitle {
        color: #6b7280;
        font-size: 1.1rem;
        margin-top: 0.5rem;
        font-weight: 500;
    }

 /* Controls Section - Reduced Height */
.controls-container {
    background: rgba(255,255,255,0.9);
    backdrop-filter: blur(15px);
    border-radius: 16px;
    padding: 1.2rem 1.5rem;
    margin: 0 auto 1.5rem;
    width: 95%;
    box-shadow: var(--card-shadow);
    border: 1px solid rgba(255,255,255,0.6);
    min-height: auto;
}

/* Price Slider - Compact */
.price-slider-container {
    background: rgba(255,255,255,0.8);
    border-radius: 12px;
    padding: 1rem;
    margin-bottom: 0;
    border: 1px solid rgba(109,40,217,0.1);
}

.price-label {
    font-weight: 600;
    color: var(--dark);
    margin-bottom: 0.8rem;
    display: block;
    font-size: 1rem;
}

#amount {
    font-weight: 700;
    color: var(--primary);
    font-size: 1rem;
    text-align: center;
    background: rgba(109,40,217,0.1);
    padding: 0.4rem 0.8rem;
    border-radius: 8px;
    border: 2px solid rgba(109,40,217,0.2);
    display: inline-block;
    margin-bottom: 0.8rem;
}

#slider-range {
    margin: 0.8rem 0;
    height: 6px;
    border-radius: 8px;
    border: none;
    background: #e5e7eb;
}

.ui-slider-range {
    background: var(--gradient-primary);
    border-radius: 8px;
}

.ui-slider-handle {
    width: 20px;
    height: 20px;
    border-radius: 50%;
    background: white;
    border: 2px solid var(--primary);
    box-shadow: 0 3px 8px rgba(109,40,217,0.3);
    top: -7px;
    cursor: pointer;
}

/* Sort Dropdown - Compact */
.sort-container {
    text-align: right;
}

#sortBy {
    padding: 0.6rem 1rem;
    border-radius: 10px;
    border: 2px solid #e5e7eb;
    background: white;
    font-weight: 500;
    color: var(--dark);
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 3px 8px rgba(0,0,0,0.05);
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%236d28d9'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 10px center;
    background-size: 14px;
    padding-right: 2rem;
    font-size: 0.9rem;
}

#sortBy:focus {
    outline: none;
    border-color: var(--primary);
    box-shadow: 0 0 0 3px rgba(109,40,217,0.1);
}

/* Responsive adjustments for mobile */
@media (max-width: 768px) {
    .controls-container {
        padding: 1rem;
        margin-bottom: 1rem;
    }
    
    .price-slider-container {
        padding: 0.8rem;
    }
    
    .price-label {
        font-size: 0.9rem;
        margin-bottom: 0.6rem;
    }
    
    #amount {
        font-size: 0.9rem;
        padding: 0.3rem 0.6rem;
        margin-bottom: 0.6rem;
    }
    
    #sortBy {
        padding: 0.5rem 0.8rem;
        font-size: 0.85rem;
    }
}
    /* Message */
    .msg {
        text-align: center;
        color: var(--primary);
        font-weight: 500;
        padding: 1rem;
        background: rgba(109,40,217,0.1);
        border-radius: 12px;
        margin: 1rem auto;
        width: 90%;
        display: block;
    }

    /* Comparison Table */
    .table-container {
        width: 95%;
        margin: 0 auto 3rem;
        background: rgba(255,255,255,0.9);
        backdrop-filter: blur(15px);
        border-radius: 20px;
        overflow: hidden;
        box-shadow: var(--card-shadow);
        border: 1px solid rgba(255,255,255,0.6);
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin: 0;
    }

    th {
        background: var(--gradient-primary);
        color: white;
        padding: 1.2rem 1rem;
        font-weight: 600;
        font-size: 0.95rem;
        text-align: center;
        position: relative;
        overflow: hidden;
    }

    th::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 10%;
        width: 80%;
        height: 1px;
        background: rgba(255,255,255,0.3);
    }

    td {
        padding: 1.2rem 1rem;
        border-bottom: 1px solid rgba(0,0,0,0.05);
        text-align: center;
        transition: all 0.3s ease;
        background: white;
    }

    tr:hover td {
        background: rgba(109,40,217,0.03);
        transform: translateY(-1px);
    }

    /* Product Image */
    td img {
        width: 100px;
        height: 100px;
        object-fit: cover;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        transition: all 0.3s ease;
    }

    tr:hover td img {
        transform: scale(1.05);
        box-shadow: 0 6px 20px rgba(0,0,0,0.15);
    }

    /* Product Details */
    .product-name {
        font-weight: 600;
        color: var(--dark);
        font-size: 1.1rem;
    }

    .brand-name {
        color: #6b7280;
        font-weight: 500;
    }

    .price {
        font-weight: 700;
        color: var(--primary);
        font-size: 1.2rem;
    }

    .rating {
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        background: rgba(245,158,11,0.1);
        padding: 0.5rem 1rem;
        border-radius: 20px;
        color: #b45309;
        font-weight: 600;
    }

    .rating::before {
        content: '★';
        color: #f59e0b;
    }

    .features {
        max-width: 200px;
        text-align: left;
        color: #4b5563;
        line-height: 1.5;
    }

    /* Wishlist Button */
    .wishlist-btn {
        background: none;
        border: none;
        color: #e11d48;
        font-size: 1.5rem;
        cursor: pointer;
        transition: all 0.3s ease;
        padding: 0.5rem;
        border-radius: 50%;
    }

    .wishlist-btn:hover {
        color: #be123c;
        background: rgba(225,29,72,0.1);
        transform: scale(1.2);
    }

    /* Score System */
    .score-box {
        font-weight: 700;
        padding: 0.6rem 1rem;
        border-radius: 10px;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        min-width: 60px;
        justify-content: center;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

  

    .low { 
        background: linear-gradient(135deg, #fee2e2, #fecaca);
        color: #b91c1c;
        border: 1px solid #fecaca;
    }

    .mid { 
        background: linear-gradient(135deg, #fef3c7, #fde68a);
        color: #b45309;
        border: 1px solid #fde68a;
    }

    .high { 
        background: linear-gradient(135deg, #dcfce7, #bbf7d0);
        color: #166534;
        border: 1px solid #bbf7d0;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .controls-container {
            padding: 1.5rem;
        }
        
        .page-title {
            font-size: 2rem;
        }
        
        .table-container {
            overflow-x: auto;
        }
        
        table {
            min-width: 800px;
        }
        
        .sort-container {
            text-align: center;
            margin-top: 1rem;
        }
    }

    /* Animation */
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .fade-in-up {
        animation: fadeInUp 0.6s ease forwards;
    }

    /* Loading State */
    .loading {
        opacity: 0.6;
        pointer-events: none;
    }
    #searchCompare {
    border-radius: 10px;
    padding: 0.6rem 1rem;
    box-shadow: 0 3px 8px rgba(0,0,0,0.05);
}

#searchSuggest a {
    cursor: pointer;
}

        .compare-container { display:flex; gap:20px; overflow-x:auto; padding:20px; }
        .compare-box {
            width:250px; min-height:300px; background:#fff;
            border:1px solid #ddd; border-radius:10px; padding:10px;
            text-align:center;
        }
        .compare-box img { width:180px; height:180px; object-fit:contain; }
        .company-box { width:200px; padding:10px; border:1px solid #ddd; border-radius:8px; margin:10px; float:left; }
        .msg { padding:10px; background:#ffe7e7; border:1px solid #ffb3b3; color:#d00; margin:10px 0; }

     .lowest-price {
    background-color: #e6ffe6;      /* light pastel green */
    font-weight: 600;
    padding: 6px 8px;
    border-radius: 8px;
    text-align: center;
}


.not-available {
    background-color: #f8f9fa;      /* soft light gray */
    color: #6c757d;                 /* muted text */
    font-style: italic;
    padding: 6px 8px;
    border-radius: 8px;
    text-align: center;
}

</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="page-header fade-in-up">
    <h1 class="page-title">Product Price Comparison</h1>
    <p class="page-subtitle">Compare products across multiple stores</p>
</div>

<div class="table-container fade-in-up mt-4">
    <table class="table table-bordered" style="width:95%; margin:auto; text-align:center;">
        <thead style="background: var(--gradient-primary); color:white;">
            <tr>
                <th>Image</th>
                <th>Product Name</th>
                <th>Features</th>
               <th id="thAmazon" runat="server">Amazon</th>
<th id="thFlipkart" runat="server">Flipkart</th>
<th id="thMyntra" runat="server">Myntra</th>
<th id="thAjio" runat="server">Ajio</th>
<th id="thCroma" runat="server">Croma</th>
<th id="thReliance" runat="server">Reliance</th>
<th id="thMeesho" runat="server">Meesho</th>
<th id="thShopsy" runat="server">Shopsy</th>

            </tr>
        </thead>
        <tbody>
            <asp:Repeater ID="rptCompareMatrix" runat="server" OnItemDataBound="rptCompareMatrix_ItemDataBound">
                <ItemTemplate>
                    <tr>
                        <td>
                <a href='#'>
                    <img src='<%# ResolveUrl("~/admin/images/" + 
                        (string.IsNullOrEmpty(Eval("ImageURL").ToString()) 
                        ? "noimage.png" 
                        : Eval("ImageURL").ToString())) %>' 
                        alt='<%# Eval("ProductName") %>'
                        onerror="this.src='https://via.placeholder.com/100?text=No+Image'">
                     </a>  </td>
                        <td><%# Eval("ProductName") %></td>
                        <td><%# Eval("features") %></td>
                    <td id="tdAmazon" runat="server"><%# Eval("AmazonPrice") %></td>
    <td id="tdFlipkart" runat="server"><%# Eval("FlipkartPrice") %></td>
    <td id="tdMyntra" runat="server"><%# Eval("MyntraPrice") %></td>
    <td id="tdAjio" runat="server"><%# Eval("AjioPrice") %></td>
    <td id="tdCroma" runat="server"><%# Eval("CromaPrice") %></td>
    <td id="tdReliance" runat="server"><%# Eval("ReliancePrice") %></td>
    <td id="tdMeesho" runat="server"><%# Eval("MeeshoPrice") %></td>
    <td id="tdShopsy" runat="server"><%# Eval("ShopsyPrice") %></td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tbody>
    </table>
</div>

 <script>
     function addToCompare(pid) {
         $.ajax({
             type: "POST",
             url: "compare.aspx/AddToCompare",
             contentType: "application/json; charset=utf-8",
             data: JSON.stringify({ productId: pid }),
             success: function (res) {
                 window.location.href = "compare.aspx";
             },
             error: function (err) {
                 console.log("Error adding to compare:", err);
             }
         });
     }
</script>

</asp:Content>



