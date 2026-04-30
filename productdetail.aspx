<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="productdetail.aspx.cs" Inherits="productdetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
        font-family: 'Inter', 'Segoe UI', Tahoma, sans-serif;
    }

    /* Product Main Section */
    .product-main {
        background: rgba(255,255,255,0.9);
        backdrop-filter: blur(15px);
        border-radius: 24px;
        box-shadow: var(--card-shadow);
        border: 1px solid rgba(255,255,255,0.6);
        overflow: hidden;
        margin: 2rem auto;
    }

    /* Product Image */
    .product-image-container {
        position: relative;
        padding: 2rem;
        background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
        border-radius: 20px;
        margin: 1rem;
    }

    .product-image {
        width: 100%;
        height: 400px;
        object-fit: contain;
        border-radius: 16px;
        transition: transform 0.3s ease;
    }

    .product-image:hover {
        transform: scale(1.02);
    }

    /* Product Details */
    .product-details {
        padding: 2.5rem;
    }

    .product-title {
        font-weight: 800;
        font-size: 2.2rem;
        color: var(--dark);
        margin-bottom: 1rem;
        line-height: 1.2;
        background: var(--gradient-primary);
        -webkit-background-clip: text;
        background-clip: text;
        color: transparent;
    }

    .product-price {
        font-weight: 800;
        font-size: 2rem;
        color: var(--primary);
        margin-bottom: 1.5rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .product-price::before {
        content: '₹';
        font-size: 1.8rem;
    }

    /* Detail Items */
    .detail-item {
        display: flex;
        align-items: center;
        margin-bottom: 1.2rem;
        padding: 1rem;
        background: rgba(109,40,217,0.05);
        border-radius: 12px;
        transition: all 0.3s ease;
    }

    .detail-item:hover {
        background: rgba(109,40,217,0.1);
        transform: translateX(5px);
    }

    .detail-label {
        font-weight: 700;
        color: var(--primary);
        min-width: 100px;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .detail-label::before {
        font-size: 1.1rem;
    }

    .detail-label.brand::before { content: '🏷️'; }
    .detail-label.category::before { content: '📁'; }
    .detail-label.features::before { content: '✨'; }

    .detail-text {
        font-size: 1.1rem;
        color: var(--dark);
        font-weight: 500;
        flex: 1;
    }

    .product-features {
        line-height: 1.6;
        color: #4b5563;
        background: rgba(255,255,255,0.8);
        padding: 1.2rem;
        border-radius: 12px;
        border-left: 4px solid var(--primary);
        max-height: 120px;
        overflow-y: auto;
    }

    /* Action Buttons */
    .action-buttons {
        display: flex;
        gap: 1rem;
        margin-top: 2rem;
        flex-wrap: wrap;
    }

    .btn-compare {
        background: var(--gradient-primary);
        color: white;
        border: none;
        padding: 1rem 1.5rem;
        border-radius: 12px;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        box-shadow: 0 4px 15px rgba(109,40,217,0.3);
        flex: 1;
        min-width: 160px;
        justify-content: center;
    }

    .btn-compare:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(109,40,217,0.4);
        color: white;
        text-decoration: none;
    }

    .btn-wish {
        background: var(--gradient-secondary);
        color: white;
        border: none;
        padding: 1rem 1.5rem;
        border-radius: 12px;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        box-shadow: 0 4px 15px rgba(245,158,11,0.3);
        flex: 1;
        min-width: 160px;
        justify-content: center;
    }

    .btn-wish:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(245,158,11,0.4);
        color: white;
        text-decoration: none;
    }

    /* Related Products */
    .related-section {
        margin-top: 4rem;
    }

    .section-title {
        font-weight: 800;
        font-size: 2rem;
        color: var(--dark);
        margin-bottom: 2rem;
        text-align: center;
        background: var(--gradient-primary);
        -webkit-background-clip: text;
        background-clip: text;
        color: transparent;
    }

    .related-card {
        background: rgba(255,255,255,0.9);
        backdrop-filter: blur(15px);
        border-radius: 20px;
        box-shadow: var(--card-shadow);
        border: 1px solid rgba(255,255,255,0.6);
        transition: all 0.3s ease;
        overflow: hidden;
        height: 100%;
    }

    .related-card:hover {
        transform: translateY(-8px);
        box-shadow: var(--hover-shadow);
    }

    .related-image {
        height: 200px;
        object-fit: contain;
        width: 100%;
        padding: 1.5rem;
        background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
    }

    .related-body {
        padding: 1.5rem;
    }

    .related-title {
        font-weight: 700;
        color: var(--dark);
        font-size: 1.1rem;
        margin-bottom: 0.8rem;
        line-height: 1.4;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .related-price {
        font-weight: 800;
        color: var(--primary);
        font-size: 1.3rem;
        margin-bottom: 1rem;
        display: flex;
        align-items: center;
        gap: 0.3rem;
    }

    .related-price::before {
        content: '₹';
        font-size: 1.1rem;
    }

    .btn-view {
        background: var(--gradient-primary);
        color: white;
        border: none;
        padding: 0.8rem 1.2rem;
        border-radius: 10px;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        box-shadow: 0 4px 12px rgba(109,40,217,0.3);
        width: 100%;
    }

    .btn-view:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 16px rgba(109,40,217,0.4);
        color: white;
        text-decoration: none;
    }

    /* Animation */
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .fade-in-up {
        animation: fadeInUp 0.6s ease forwards;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .product-title {
            font-size: 1.8rem;
        }
        
        .product-price {
            font-size: 1.6rem;
        }
        
        .action-buttons {
            flex-direction: column;
        }
        
        .btn-compare,
        .btn-wish {
            min-width: 100%;
        }
        
        .product-image {
            height: 300px;
        }
        
        .section-title {
            font-size: 1.6rem;
        }
    }

    @media (max-width: 576px) {
        .product-details {
            padding: 1.5rem;
        }
        
        .product-image-container {
            padding: 1rem;
            margin: 0.5rem;
        }
        
        .detail-item {
            flex-direction: column;
            align-items: flex-start;
            gap: 0.5rem;
        }
        
        .detail-label {
            min-width: auto;
        }
    }
      .affiliate-icons img {
        height:40px; /* desired height */
        width: auto;  /* width auto to maintain aspect ratio */
        object-fit: contain; /* ensures image fits well */
        margin: 0 10px; /* spacing between icons */
    }

    .affiliate-icons {
        display: flex;
        justify-content: center;
        align-items: center;
      

    }
    .estimated {
      font-weight: 600;
        color: var(--primary);
        min-width: 100px;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        font-size:16px;
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="container mt-4">

    <!-- PRODUCT MAIN SECTION -->
    <div class="product-main fade-in-up">
        <div class="row align-items-center">

            <!-- LEFT : IMAGE -->
            <div class="col-lg-6">
                <div class="product-image-container">
                    <asp:Image ID="imgProduct" runat="server" CssClass="product-image" />
                </div>
         <div class="affiliate-icons mt-3 text-center">
    <a id="amazonIcon" runat="server" target="_blank" class="affiliate-icon">
        <img src="icons/amazon.png" />
    </a>

    <a id="flipkartIcon" runat="server" target="_blank" class="affiliate-icon">
        <img src="icons/flipkart.png" alt="Flipkart" />
    </a>

    <a id="myntraIcon" runat="server" target="_blank" class="affiliate-icon">
        <img src="icons/myntra.png" alt="Myntra" />
    </a>

    <a id="ajioIcon" runat="server" target="_blank" class="affiliate-icon">
        <img src="icons/ajio.png" alt="Ajio" />
    </a>

    <a id="cromaIcon" runat="server" target="_blank" class="affiliate-icon">
        <img src="icons/croma.png" alt="Croma" />
    </a>

    <a id="relianceIcon" runat="server" target="_blank" class="affiliate-icon">
        <img src="icons/reliance.png" alt="Reliance" />
    </a>

    <a id="meeshoIcon" runat="server" target="_blank" class="affiliate-icon">
        <img src="icons/meesho.png" alt="Meesho" />
    </a>

    <a id="shopsyIcon" runat="server" target="_blank" class="affiliate-icon">
        <img src="icons/shopsy.png" alt="Shopsy" />
    </a>
</div>


            </div>

            <!-- RIGHT : DETAILS -->
            <div class="col-lg-6">
                <div class="product-details">
                    <h1 class="product-title">
                        <asp:Label ID="lblName" runat="server"></asp:Label>
                    </h1>
             <span class="estimated brand">Estimated Price :- </span>
                    <div class="product-price">
                        <asp:Label ID="lblPrice" runat="server"></asp:Label>
                    </div>


                    <!-- Product Details -->
                    <div class="detail-item">
                        <span class="detail-label brand">Brand :- </span>
                        <span class="detail-text">
                            <asp:Label ID="lblBrand" runat="server"></asp:Label>
                        </span>
                    </div>

                    <div class="detail-item">
                        <span class="detail-label category">Category :- </span>
                        <span class="detail-text">
                            <asp:Label ID="lblCategory" runat="server"></asp:Label>
                        </span>
                    </div>

                    <div class="detail-item">
                        <span class="detail-label features">Features :-</span>
                    </div>
                    
                    <div class="product-features">
                        <asp:Label ID="lblDescription" runat="server"></asp:Label>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-buttons">
                        <!-- COMPARE BUTTON -->
                 <asp:LinkButton ID="btnCompare" runat="server" 
    CssClass="btn-compare"
    OnClick="btnCompare_Click">
    <i class="fas fa-balance-scale"></i> Compare Product
</asp:LinkButton>




                        <!-- WISHLIST BUTTON -->
                        <asp:LinkButton ID="LinkButton1" runat="server"
                            CssClass="btn-wish"
                            OnClick="LinkButton1_Click">
                            <i class="fas fa-heart"></i>
                            Add to Wishlist
                        </asp:LinkButton>
                    </div>

                </div>
            </div>

        </div>
    </div>

    <!-- RELATED PRODUCTS -->
    <div class="related-section">
        <h2 class="section-title">Related Products</h2>
        
        <div class="row g-4">
            <asp:Repeater ID="rptRelated" runat="server">
                <ItemTemplate>
                    <div class="col-xl-3 col-lg-4 col-md-6 fade-in-up">
                        <div class="related-card">
                            <!-- Product Image -->
                            <img src='<%# ResolveUrl("~/admin/images/") + Eval("ImageURL") %>' 
                                 class="related-image"
                                 alt='<%# Eval("ProductName") %>'
                                 onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'" />
                            
                            <!-- Product Details -->
                            <div class="related-body">
                                <h5 class="related-title"><%# Eval("ProductName") %></h5>
                                
                                <div class="related-price"><%# Eval("Price") %></div>
                                
                                <a href='productdetail.aspx?id=<%# Eval("ProductID") %>' 
                                   class="btn-view">
                                    <i class="fas fa-eye"></i>
                                    View Details
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Add animation delays to related products
        const relatedCards = document.querySelectorAll('.related-card');
        relatedCards.forEach((card, index) => {
            card.style.animationDelay = `${index * 0.1}s`;
    });

    // Smooth scroll to top when clicking view details
        const viewButtons = document.querySelectorAll('.btn-view');
    viewButtons.forEach(button => {
        button.addEventListener('click', function () {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
    });
    });
</script>

</asp:Content>