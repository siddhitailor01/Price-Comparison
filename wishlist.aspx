<%@ Page Title="My Wishlist" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="wishlist.aspx.cs" Inherits="wishlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
            min-height: 100vh;
        }

        /* Page Header */
        .page-header {
            text-align: center;
            padding: 3rem 0 2rem;
            background: linear-gradient(135deg, rgba(109,40,217,0.05) 0%, rgba(16,185,129,0.05) 100%);
            margin-bottom: 2rem;
            border-radius: 0 0 30px 30px;
        }

        .page-title {
            font-weight: 800;
            color: var(--primary);
            margin: 0;
            font-size: 2.8rem;
            letter-spacing: -0.5px;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            text-shadow: 0 4px 8px rgba(109,40,217,0.1);
        }

        .page-subtitle {
            color: #6b7280;
            font-size: 1.2rem;
            margin-top: 0.8rem;
            font-weight: 500;
        }

        .wishlist-count {
            background: var(--gradient-primary);
            color: white;
            padding: 0.5rem 1.5rem;
            border-radius: 25px;
            font-weight: 600;
            display: inline-block;
            margin-top: 1rem;
            box-shadow: 0 4px 15px rgba(109,40,217,0.3);
        }

        /* Wishlist Cards */
        .wishlist-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 1rem;
        }

        .wishlist-card {
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(15px);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid rgba(255, 255, 255, 0.6);
            overflow: hidden;
            position: relative;
            height: 100%;
        }

        .wishlist-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--hover-shadow);
        }

        .wishlist-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-primary);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .wishlist-card:hover::before {
            transform: scaleX(1);
        }

        .product-img-container {
            position: relative;
            overflow: hidden;
            background: #f8fafc;
            padding: 1.5rem;
        }

        .product-img {
            height: 200px;
            object-fit: contain;
            width: 100%;
            transition: all 0.4s ease;
            border-radius: 12px;
        }

        .wishlist-card:hover .product-img {
            transform: scale(1.05);
        }

        .wishlist-badge {
            position: absolute;
            top: 12px;
            right: 12px;
            background: var(--gradient-secondary);
            color: white;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            box-shadow: 0 4px 12px rgba(245,158,11,0.3);
        }

        .card-content {
            padding: 1.5rem;
        }

        .product-name {
            font-weight: 700;
            color: var(--dark);
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .brand-name {
            color: #6b7280;
            font-weight: 500;
            margin-bottom: 0.8rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .brand-name::before {
            content: '🏷️';
            font-size: 0.9rem;
        }

        .price {
            font-weight: 800;
            color: var(--primary);
            font-size: 1.4rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .price::before {
            content: '₹';
            font-size: 1.2rem;
        }

        .card-actions {
            display: flex;
            gap: 0.8rem;
            margin-top: 1.2rem;
        }

        .btn-remove {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
            border: none;
            padding: 0.8rem 1.2rem;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            box-shadow: 0 4px 15px rgba(239,68,68,0.3);
            text-decoration: none;
            cursor: pointer;
        }

        .btn-remove:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(239,68,68,0.4);
            background: linear-gradient(135deg, #dc2626, #b91c1c);
            color: white;
            text-decoration: none;
        }

        .btn-view {
            background: var(--gradient-primary);
            color: white;
            border: none;
            padding: 0.8rem 1.2rem;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            text-decoration: none;
            box-shadow: 0 4px 15px rgba(109,40,217,0.3);
        }

        .btn-view:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(109,40,217,0.4);
            color: white;
            text-decoration: none;
        }

        /* Empty State */
        .empty-wishlist {
            text-align: center;
            padding: 4rem 2rem;
            background: rgba(255,255,255,0.8);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(255,255,255,0.6);
            margin: 2rem auto;
            max-width: 500px;
        }

        .empty-icon {
            font-size: 4rem;
            color: var(--primary-light);
            margin-bottom: 1.5rem;
        }

        .empty-title {
            font-weight: 700;
            color: var(--dark);
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }

        .empty-text {
            color: #6b7280;
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .btn-explore {
            background: var(--gradient-primary);
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: 0 4px 15px rgba(109,40,217,0.3);
        }

        .btn-explore:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(109,40,217,0.4);
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
            .page-title {
                font-size: 2.2rem;
            }
            
            .page-subtitle {
                font-size: 1.1rem;
            }
            
            .wishlist-container {
                padding: 0 0.5rem;
            }
            
            .product-img {
                height: 160px;
            }
            
            .card-actions {
                flex-direction: column;
            }
            
            .empty-wishlist {
                padding: 3rem 1.5rem;
                margin: 1rem;
            }
        }

        @media (max-width: 576px) {
            .page-header {
                padding: 2rem 0 1.5rem;
            }
            
            .page-title {
                font-size: 1.8rem;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <!-- Page Header -->
    <div class="page-header fade-in-up">
        <h1 class="page-title">My Wishlist</h1>
        <p class="page-subtitle">Your favorite products saved for later</p>
    
    </div>

    <!-- Wishlist Content -->
    <div class="wishlist-container">
        <div class="row g-4">
            <asp:Repeater ID="rptWishlist" runat="server">
                <ItemTemplate>
                    <div class="col-md-3 fade-in-up">
                        <div class="wishlist-card">
                            <!-- Product Image -->
                            <div class="product-img-container">
                              
                                <img src='<%# ResolveUrl("~/admin/images/") + Eval("ImageURL") %>'
                                     class="product-img" 
                                     alt='<%# Eval("ProductName") %>'
                                     onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'"/>
                            </div>

                            <!-- Product Details -->
                            <div class="card-content">
                                <h5 class="product-name"><%# Eval("ProductName") %></h5>
                                <p class="brand-name"><%# Eval("Brand") %></p>
                                <p class="price"><%# Eval("Price") %></p>

                                <!-- Action Buttons -->
                                <div class="card-actions">
                                    <a href='productdetail.aspx?id=<%# Eval("ProductID") %>' class="btn-view">
                                        <i class="fas fa-eye me-1"></i> 
                                    </a>
                                    <asp:LinkButton ID="btnRemove" runat="server"
                                        CommandArgument='<%# Eval("ProductID") %>'
                                        OnClick="btnRemove_Click"
                                        CssClass="btn-remove"
                                        OnClientClick="return confirm('Are you sure you want to remove this item from your wishlist?');">
                                        <i class="fas fa-trash me-1"></i>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Empty Wishlist State -->
        <asp:Panel ID="pnlEmptyWishlist" runat="server" CssClass="empty-wishlist fade-in-up" Visible="false">
            <div class="empty-icon">
                <i class="fas fa-heart-broken"></i>
            </div>
            <h3 class="empty-title">Your Wishlist is Empty</h3>
            <p class="empty-text">
                Start exploring our products and add your favorites to your wishlist. 
                They'll be saved here for you to revisit later.
            </p>
            <a href="index.aspx" class="btn-explore">
                <i class="fas fa-shopping-bag me-1"></i> Start Shopping
            </a>
        </asp:Panel>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Add loading animation to cards
            const cards = document.querySelectorAll('.wishlist-card');
            cards.forEach((card, index) => {
                card.style.animationDelay = `${index * 0.1}s`;
        });

        // Add confirmation for remove actions
            const removeButtons = document.querySelectorAll('.btn-remove');
        removeButtons.forEach(button => {
            button.addEventListener('click', function (e) {
                if (!confirm('Are you sure you want to remove this item from your wishlist?')) {
                    e.preventDefault();
                }
            });
        });
        });
    </script>

</asp:Content>