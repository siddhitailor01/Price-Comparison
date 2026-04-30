<%@ Page Title="About – Price Comparison Website" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="about.aspx.cs" Inherits="about" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style>

    body {
        margin: 0;
        padding: 0;
        background: linear-gradient(120deg, #f5f7ff, #e8eeff);
        font-family: 'Inter', sans-serif;
        color: #0f172a;
    }

    /* --- HERO SECTION --- */
    .hero {
        text-align: center;
        padding: 80px 20px;
    }

    .hero h1 {
        font-size: 3rem;
        font-weight: 800;
        color: #1d4ed8;
        text-shadow: 0 3px 20px rgba(0,0,0,0.08);
    }

    .hero p {
        font-size: 1.15rem;
        max-width: 750px;
        margin: 15px auto;
        color: #475569;
        line-height: 1.7;
    }

    /* --- GLASS CARD SECTIONS --- */
    .section {
        max-width: 900px;
        margin: 25px auto;
        background: rgba(255, 255, 255, 0.7);
        backdrop-filter: blur(18px);
        padding: 40px 55px;
        border-radius: 28px;
        box-shadow: 0 10px 40px rgba(0,0,0,0.08);
        border: 1px solid rgba(255,255,255,0.5);
        transition: 0.3s ease;
    }

    .section:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 45px rgba(0,0,0,0.12);
    }

    .section h2 {
        font-size: 1.9rem;
        color: #1e3a8a;
        font-weight: 800;
        margin-bottom: 15px;
    }

    .section p {
        color: #475569;
        font-size: 1.07rem;
        line-height: 1.65;
    }

    /* --- BADGE LIST --- */
    .features {
        display: flex;
        flex-wrap: wrap;
        gap: 12px;
        margin-top: 18px;
    }

    .badge {
        padding: 10px 20px;
        background: linear-gradient(135deg, #2563eb, #1d4ed8);
        color: white;
        border-radius: 50px;
        font-weight: 600;
        font-size: 0.9rem;
        box-shadow: 0 4px 15px rgba(37,99,235,0.3);
    }

    /* --- HOW IT WORKS --- */
    .steps {
        margin-top: 25px;
    }

    .step-box {
        margin: 15px 0;
        padding: 18px 22px;
        border-radius: 18px;
        background: linear-gradient(135deg, #eef2ff, #e0e7ff);
        border-left: 6px solid #2563eb;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    }

    .step-box span {
        font-weight: 700;
        color: #1d4ed8;
        font-size: 1.05rem;
    }

    /* --- QUICK NAV BUTTONS UNDER HERO --- */
.quick-nav {
    margin-top: -20px;
    margin-bottom: 40px;
     position: relative;
    z-index: 9999;
}

.q-btn {
    display: inline-block;
    padding: 12px 22px;
    margin: 8px;
    background: linear-gradient(135deg, #2563eb, #1d4ed8);
    color: white;
    border-radius: 50px;
    font-weight: 600;
    font-size: 0.95rem;
    text-decoration: none;
    box-shadow: 0 5px 18px rgba(29,78,216,0.25);
    transition: 0.3s ease;
}

.q-btn:hover {
    transform: translateY(-4px);
    background: linear-gradient(135deg, #1d4ed8, #1e40af);
    box-shadow: 0 8px 25px rgba(29,78,216,0.35);
}
html {
    scroll-behavior: smooth;
}

</style>


    <!-- HERO SECTION -->
<div class="hero">
    <h1>Why We Built This Website</h1>
    <p>
        Finding the best price online is difficult — every website shows a different price,
        different offers, and confusing discounts. We built this platform to make online shopping
        simple, transparent, and fast by comparing real-time prices in one place.
    </p>
</div>
    <!-- QUICK NAV BUTTONS -->
<div class="quick-nav text-center">
    <a href="#problem" class="q-btn">The Problem</a>
    <a href="#solution" class="q-btn">Our Solution</a>
    <a href="#how" class="q-btn">How It Works</a>
    <a href="#vision" class="q-btn">Our Vision</a>
</div>


<div class="container-fluid">

    <!-- ROW 1 --- (Problem + Solution) -->
    <div class="row">

        <!-- PROBLEM -->
        <div class="col-md-12 ">
            <div class="section" id="problem">
                <h2>The Problem</h2>
                <p>
                    Online shoppers often visit multiple websites to check product prices. Websites show different 
                    discounts, hidden charges, misleading offers, and users waste a lot of time searching for the 
                    lowest price. There is no single clean platform that shows everything together.
                </p>
            </div>
        </div>

        <!-- SOLUTION -->
        <div class="col-md-12">
            <div class="section" id="solution"> 
                <h2>Our Solution</h2>
                <p>
                    Our price comparison engine collects real-time data from multiple trusted shopping websites
                    and displays all prices at one place. You instantly see the best deal without opening 
                    5–10 different tabs.
                </p>

                <div class="features">
                    <div class="badge">Real-time comparison</div>
                    <div class="badge">Multiple stores</div>
                    <div class="badge">Accurate results</div>
                    <div class="badge">Fast & simple</div>
                    <div class="badge">Clean interface</div>
                    <div class="badge">100% Free</div>
                </div>
            </div>
        </div>

    </div>


    <!-- ROW 2 --- (How it works + Vision) -->
    <div class="row">

        <!-- HOW IT WORKS -->
        <div class="col-md-12">
            <div class="section" id="how">
                <h2>How It Works</h2>

                <div class="steps">
                    <div class="step-box">
                        <span>1. Search any product</span> — Type the product name in the search bar.
                    </div>

                    <div class="step-box">
                        <span>2. Compare real-time prices</span> — We fetch prices from Amazon, Flipkart,
                        and other stores instantly.
                    </div>

                    <div class="step-box">
                        <span>3. Choose the best deal</span> — The lowest price is automatically highlighted.
                    </div>

                    <div class="step-box">
                        <span>4. Buy securely</span> — You are redirected to the official store’s product page.
                    </div>
                </div>
            </div>
        </div>

        <!-- VISION -->
        <div class="col-md-12">
            <div class="section" id="vision">
                <h2>Our Vision</h2>
                <p>
                    We want to make online shopping smarter and more transparent. Our goal is to help users save 
                    money, avoid fake discounts, and enjoy a smooth comparison experience. We will continue improving 
                    our system with more stores, better accuracy, and powerful tools.
                </p>
            </div>
        </div>

    </div>

</div>

</asp:Content>

