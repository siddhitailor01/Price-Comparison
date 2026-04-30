<%@ Page Title="Product Comparison" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css" />




    <style>
    body {
    background: linear-gradient(120deg, #f5f7ff, #eef5ff);
    font-family: 'Inter', sans-serif;
}

/* Heading */
h2 {
    font-weight: 800;
    letter-spacing: -1px;
    color:#1d4ed8;
    text-shadow: 0 2px 20px rgba(0,0,0,0.08);
}

/* ==== PRODUCT BOX SUPER PREMIUM ==== */

.animated-product-box {
    width: 100%;
    background: rgba(255, 255, 255, 0.65);
    backdrop-filter: blur(16px);
    border: 1px solid rgba(255,255,255,0.5);

    border-radius: 22px;
    overflow: hidden;

    box-shadow:
        0 6px 18px rgba(0,0,0,0.06),
        0 12px 35px rgba(0,0,0,0.08);

    transition: all 0.45s ease;
    cursor: pointer;
    position: relative;
}

/* Hover 3D lift */
.animated-product-box:hover {
    transform: translateY(-10px) scale(1.03);
    box-shadow:
        0 18px 40px rgba(0,0,0,0.12),
        0 12px 25px rgba(59,130,246,0.25);
}

/* Shine / shimmer animation */
.animated-product-box::after {
    content: "";
    position: absolute;
    top: -100%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: linear-gradient(
        120deg,
        transparent 0%,
        rgba(255,255,255,0.35) 50%,
        transparent 100%
    );
    transform: rotate(25deg);
    transition: 0.5s;
}
.animated-product-box:hover::after {
    top: 100%;
}

/* Product Image Section */
.product-img-container {
    height: 220px;
    padding: 10px;
    background: linear-gradient(135deg, #eef2ff, #e0e7ff);
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
}

/* Main image */
.product-img.main {
    width: 160px;
    z-index: 2;
    transition: 0.4s ease;
}

/* Hover fade image */
.product-img.hover {
    width: 160px;
    opacity: 0;
    position: absolute;
    transition: 0.4s ease;
}

/*.animated-product-box:hover .product-img.main {
    opacity: 0;
}
.animated-product-box:hover .product-img.hover {
    opacity: 1;
}*/

/* ===== Price Tag Badge ===== */
.price {
    position: relative;
    display: inline-block;
    background: linear-gradient(135deg, #2563eb, #1d4ed8);
    color: white;
    padding: 8px 18px;
    border-radius: 50px;
    font-size: 1.2rem;
    font-weight: 800;
    margin-top: 8px;

    box-shadow: 0 4px 18px rgba(37,99,235,0.3);
    transition: 0.3s ease;
}

/* Button hover pop */
.animated-product-box:hover .price {
    transform: scale(1.05);
}

/* ===== Details Section ===== */
.product-details {
    padding: 18px;
    text-align: center;
    background: rgba(255,255,255,0.7);
    backdrop-filter: blur(10px);
    border-top: 1px solid rgba(0,0,0,0.05);
}

.brand-name {
    font-weight: 700;
    color: #64748b;
}

.product-name {
    font-size: 1.05rem;
    font-weight: 600;
    color: #0f172a;
}

/* ==== Floating Buttons ==== */

.btn-compare, .btn-wish {
    position: absolute;
    right: 16px;
    width: 48px;
    height: 48px;
    background: #2563eb;
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;

    opacity: 0;
    transform: translateY(12px);
    transition: all 0.4s ease;
    pointer-events: none;
}

.btn-wish {
    bottom: 70px;
}
.btn-compare {
    bottom: 16px;
}

/* SHOW on hover */
.animated-product-box:hover .btn-wish,
.animated-product-box:hover .btn-compare {
    opacity: 1;
    pointer-events: auto;
    transform: translateY(0);
}

.btn-wish:hover, .btn-compare:hover {
    transform: scale(1.15) rotate(-8deg);
    background: #3b82f6;
}

/* ===== BEST PRICE Ribbon ===== */
.best-deal {
    position: absolute;
    top: 10px;
    left: -20px;
    background: linear-gradient(135deg, #22c55e, #16a34a);
    color: white;
    padding: 6px 30px;
    transform: rotate(-12deg);
    font-size: 0.85rem;
    font-weight: 700;
    border-radius: 6px;
    box-shadow: 0 4px 12px rgba(34,197,94,0.4);
}
.product-col {
    width: 25% !important;      /* col-3 width */
    padding: 10px;
    box-sizing: border-box;
}
.product-slider .owl-nav {
    position: absolute;
    top: 50%;
    width: 100%;
    transform: translateY(-50%);
    display: flex;
    justify-content: space-between;
    pointer-events: none; /* arrows ke around click allow */
}

.product-slider .owl-nav .nav-btn {
    background: #fff;
    width: 35px;
    height: 35px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 13px;
    box-shadow: 0 0 12px rgba(0,0,0,0.15);
    cursor: pointer;
    pointer-events: auto;
    transition: 0.3s ease;
}

.product-slider .owl-nav .nav-btn:hover {
    background: #007bff;
    color: #fff;
}
        /*.owl-carousel {
            background:#fff !important;
            border:2px solid red;
        }
        .owl-stage-outer {
        background-color:transparent;
            border:2px solid green;

        }
        .owl-stage {
            border:2px solid red;

        }*/
</style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<div class="container-fluid" >
    <div class="container py-1">
    <h2 class="mt-3">Explore Products</h2>
    <div class="row g-4 mt-2">
         <!-- LEFT SIDEBAR CATEGORIES -->
   <asp:Panel ID="sidebarPanel" runat="server" Visible="false" CssClass="col-md-3 mt-5 pt-5">

        <div class="card shadow-sm border-0 mt-5">
            <div class="card-header bg-primary text-white fw-bold">
               Sub Categories
            </div>

            <ul class="list-group list-group-flush" id="sidebarCats">
                <asp:Repeater ID="rptSideCategories" runat="server">
                    <ItemTemplate>
                        <li class="list-group-item">
                            <a href="index.aspx?CatID=<%# Eval("CatID") %>" class="text-dark text-decoration-none">
                                <%# Eval("CategoryName") %>
                            </a>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </div>

    </asp:Panel>

            <asp:Panel ID="productPanel" runat="server" CssClass="col-md-9">

        <asp:Repeater ID="rptMainCategory" runat="server">
<ItemTemplate>

    <!-- CATEGORY TITLE -->
    <div class="mt-5">
        <h2 class="mt-4"><%# Eval("CategoryName") %> -</h2>

        <!-- PRODUCT GRID -->
        <div class="owl-carousel product-slider mt-4">

            <asp:Repeater ID="rptProducts" runat="server" DataSource='<%# Eval("Products") %>'>
                <ItemTemplate>

                    <div class="item">
                        <div class="animated-product-box shadow-none">

                            <div class="product-img-container">
                                <a href='productdetail.aspx?id=<%# Eval("ProductID") %>'>
                                    <img src='<%# ResolveUrl("~/admin/images/") + Eval("ImageURL") %>' class="product-img main" />
                                    <img src='<%# ResolveUrl("~/admin/images/") + Eval("ImageURL") %>' class="product-img hover" />
                                </a>

                                <button type="button" class="btn-compare add-to-compare" data-productid='<%# Eval("ProductID") %>' title="Add to Compare">
                                    <i class="fas fa-balance-scale"></i>
                                </button>

                                <asp:LinkButton ID="btnWish" runat="server"
                                    CommandArgument='<%# Eval("ProductID") %>'
                                    OnClick="LinkButton1_Click"
                                    CssClass="btn btn-wish">
                                    <i class="fa fa-heart"></i>
                                </asp:LinkButton>
                            </div>

                            <a href='productdetail.aspx?id=<%# Eval("ProductID") %>' style="text-decoration:none;">
                                <div class="product-details">
                                    <div class="brand-name">Brand: <%# Eval("Brand") %></div>
                                    <div class="product-name"><%# Eval("ProductName") %></div>
                                    <div class="price">₹<%# Eval("Price") %></div>
                                </div>
                            </a>

                        </div>
                    </div>

                </ItemTemplate>
            </asp:Repeater>

        </div>
    </div>

</ItemTemplate>
</asp:Repeater>

                    </asp:Panel>

    </div>
</div>
</div>

    <!-- Compare Bar (floating at bottom) -->
<div id="compareBar" style="display:none; position:fixed; left:50%; transform:translateX(-50%); bottom:14px; z-index:9999; background:#ffffff; border-radius:10px; box-shadow:0 8px 30px rgba(0,0,0,0.12); padding:10px 14px;">
    <div style="display:flex; align-items:center; gap:12px;">
        <div><strong>Compare</strong> (<span id="compareCount">0</span>)</div>
        <div id="compareThumbs" style="display:flex; gap:8px; align-items:center;"></div>
        <div>
            <a id="goCompare" class="btn btn-primary btn-sm" href="compare.aspx" target="_self">Go to Compare</a>
            <button id="clearCompare" class="btn btn-outline-secondary btn-sm">Clear</button>
        </div>
    </div>
</div>


    <script>
        $(function () {

            $(".container").each(function () {

                let section = $(this);
                let prices = [];

                section.find(".price").each(function () {
                    let p = parseFloat($(this).text().replace("₹", ""));
                    if (!isNaN(p)) prices.push(p);
                });

                if (prices.length > 0) {

                    let minP = Math.min(...prices);
                    let maxP = Math.max(...prices);

                    let slider = section.find(".slider-range");

                    slider.slider({
                        range: true,
                        min: minP,
                        max: maxP,
                        values: [minP, maxP],
                        slide: function (e, ui) {

                            section.find(".amount").val(`₹${ui.values[0]} - ₹${ui.values[1]}`);

                section.find(".animated-product-box").each(function () {
                    let price = parseFloat($(this).find(".price").text().replace("₹", ""));
                    $(this).toggle(price >= ui.values[0] && price <= ui.values[1]);
                });
            }
            });

        section.find(".amount").val(`₹${minP} - ₹${maxP}`);
        }

        });

        });
</script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <script>
        var totalItems = $('.product-slider .item').length;

        $('.product-slider').owlCarousel({
            loop: totalItems > 1 ? true : false,  // 👈 Smart loop
            margin: 20,
            nav: true,
            dots: false,
            autoplay: true,
            autoplayTimeout: 3000,
            autoplayHoverPause: true ,

            navText: [
      '<span class="nav-btn nav-prev"><i class="fas fa-chevron-left"></i></span>',
      '<span class="nav-btn nav-next"><i class="fas fa-chevron-right"></i></span>'
            ],

            responsive: {
                0: {
                    items: 1
                },
                576: {
                    items: 2
                },
                768: {
                    items: 3
                },
                1200: {
                    items: 4
                }
            }
        });

</script>

    <script>
        // Helper: update compare bar UI
        function refreshCompareBar(list) {
            if (!list || list.length === 0) {
                $('#compareBar').hide();
                $('#compareCount').text('0');
                $('#compareThumbs').empty();
                $('#goCompare').attr('href', 'compare.aspx');
                return;
            }

            $('#compareBar').show();
            $('#compareCount').text(list.length);
            $('#compareThumbs').empty();

            // For each product id, request a small thumbnail + name from server via AJAX
            // We'll call a WebMethod that returns product summary for list of ids
            $.ajax({
                url: 'index.aspx/GetProductsSummary',
                method: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ ids: list }),
                success: function (res) {
                    var items = res.d || [];
                    items.forEach(function (p) {
                        var html = '<div style="text-align:center; width:70px;">' +
                            '<img src="' + p.ImageUrl + '" style="width:60px; height:40px; object-fit:cover; border-radius:6px;" />' +
                            '<div style="font-size:11px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">' + p.ProductName + '</div>' +
                            '<a href="javascript:void(0);" class="remove-compare" data-id="' + p.ProductID + '" style="font-size:12px; color:#dc3545;">✕</a>' +
                            '</div>';
                        $('#compareThumbs').append(html);
                    });

                    // Build link to compare page with multiple product ids (optional)
                    var qs = '?';
                    qs += 'ids=' + list.join(',');
                    $('#goCompare').attr('href', 'compare.aspx' + qs);
                },
                error: function () {
                    // fallback: just show count and generic link
                    $('#goCompare').attr('href', 'compare.aspx?ids=' + list.join(','));
                }
            });
        }

        // On document ready: bind click handlers
        $(function () {

            // Add to compare button click
            $(document).on('click', '.add-to-compare', function (e) {
                e.preventDefault();
                var id = $(this).data('productid');

                $.ajax({
                    url: 'index.aspx/AddToCompare',
                    method: 'POST',
                    data: JSON.stringify({ productId: parseInt(id) }),
                    contentType: 'application/json; charset=utf-8',
                    success: function (res) {
                        // res.d => list of ids currently in compare
                        refreshCompareBar(res.d);
                    }
                });
            });

            // Remove from compare (from the thumbs)
            $(document).on('click', '.remove-compare', function () {
                var id = $(this).data('id');
                $.ajax({
                    url: 'index.aspx/RemoveFromCompare',
                    method: 'POST',
                    data: JSON.stringify({ productId: parseInt(id) }),
                    contentType: 'application/json; charset=utf-8',
                    success: function (res) {
                        refreshCompareBar(res.d);
                    }
                });
            });

            // Clear compare
            $('#clearCompare').on('click', function () {
                $.ajax({
                    url: 'index.aspx/ClearCompare',
                    method: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    data: '{}',
                    success: function (res) {
                        refreshCompareBar([]);     // UI clear
                        console.log("Compare Cleared:", res.d);
                    }

                });
            });

            // On page load, fetch current compare list
            $.ajax({
                url: 'index.aspx/GetCompareList',
                method: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                success: function (res) {
                    refreshCompareBar(res.d);
                }
            });

        });
</script>



</asp:Content>
