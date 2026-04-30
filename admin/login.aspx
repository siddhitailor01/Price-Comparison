<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="admin_login" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>PriceCompare - Admin Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&family=Montserrat:wght@700&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        :root {
            --primary: #6C5CE7;     /* Vibrant Purple */
            --secondary: #00B894;   /* Fresh Green */
            --accent: #FD79A8;     /* Playful Pink */
            --dark: #2D3436;
            --light: #F8F9FA;
            --gradient: linear-gradient(135deg, #6C5CE7 0%, #A29BFE 100%);
            --card-shadow: 0 20px 40px rgba(108, 92, 231, 0.15);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: var(--gradient);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }

        /* Animated Background Shapes */
        .bg-shape {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            animation: float 6s infinite ease-in-out;
        }

        .bg-shape:nth-child(1) {
            width: 300px;
            height: 300px;
            top: -100px;
            left: -100px;
            animation-delay: 0s;
        }

        .bg-shape:nth-child(2) {
            width: 200px;
            height: 200px;
            bottom: -80px;
            right: -60px;
            animation-delay: 2s;
        }

        .bg-shape:nth-child(3) {
            width: 150px;
            height: 150px;
            top: 50%;
            right: 10%;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(5deg); }
        }

        /* Floating Price Tags */
        .price-bubble {
            position: absolute;
            background: var(--secondary);
            color: white;
            padding: 8px 16px;
            border-radius: 50px;
            font-size: 14px;
            font-weight: 600;
            box-shadow: 0 8px 20px rgba(0, 184, 148, 0.3);
            animation: pop 3s infinite ease-in-out;
            z-index: 1;
        }

        .price-bubble:nth-child(1) {
            top: 15%;
            left: 10%;
            animation-delay: 0.5s;
        }

        .price-bubble:nth-child(2) {
            bottom: 20%;
            right: 12%;
            animation-delay: 1.5s;
            background: var(--accent);
            box-shadow: 0 8px 20px rgba(253, 121, 168, 0.3);
        }

        @keyframes pop {
            0%, 100% { transform: scale(1) translateY(0); }
            50% { transform: scale(1.1) translateY(-10px); }
        }

        /* Login Card */
        .login-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(15px);
            border-radius: 24px;
            padding: 40px 35px;
            width: 100%;
            max-width: 420px;
            box-shadow: var(--card-shadow);
            position: relative;
            z-index: 10;
            animation: slideUp 0.8s ease-out;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .logo {
            text-align: center;
            margin-bottom: 25px;
        }

        .logo h1 {
            font-family: 'Montserrat', sans-serif;
            font-size: 32px;
            background: linear-gradient(45deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin: 0;
        }

        .logo p {
            color: #777;
            font-size: 14px;
            margin-top: 5px;
        }

        h3 {
            text-align: center;
            color: var(--dark);
            margin-bottom: 30px;
            font-weight: 600;
            font-size: 22px;
            position: relative;
        }

        h3::after {
            content: '';
            width: 60px;
            height: 4px;
            background: var(--secondary);
            display: block;
            margin: 12px auto 0;
            border-radius: 2px;
        }

        /* Input Group */
        .input-group {
            position: relative;
            margin-bottom: 22px;
        }

        .input-group i {
            position: absolute;
            top: 50%;
            left: 18px;
            transform: translateY(-50%);
            color: var(--primary);
            font-size: 18px;
            z-index: 2;
            transition: 0.3s;
        }

        .form-control {
            width: 100%;
            padding: 16px 16px 16px 50px;
            border: 2px solid #e0e0e0;
            border-radius: 14px;
            font-size: 15px;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-control:focus {
            border-color: var(--primary);
            background: white;
            box-shadow: 0 0 0 4px rgba(108, 92, 231, 0.1);
            outline: none;
        }

        .form-control:focus + i {
            color: var(--primary);
        }

        .form-control::placeholder {
            color: #aaa;
        }

        /* Login Button */
        .login-button {
            background: var(--gradient);
            color: white;
            border: none;
            padding: 16px;
            width: 100%;
            border-radius: 14px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            margin-top: 10px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .login-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(108, 92, 231, 0.3);
        }

        .login-button:active {
            transform: translateY(-1px);
        }

        .login-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: 0.5s;
        }

        .login-button:hover::before {
            left: 100%;
        }

        /* Error Message */
        .error {
            background: #ffebee;
            color: #c62828;
            padding: 12px;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 20px;
            font-size: 14px;
            border-left: 4px solid #e57373;
            animation: shake 0.5s;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        /* Responsive */
        @media (max-width: 480px) {
            .login-container {
                margin: 20px;
                padding: 30px 25px;
            }
            .logo h1 { font-size: 28px; }
        }
    </style>
</head>
<body>
    <!-- Animated Background Shapes -->
    <div class="bg-shape"></div>
    <div class="bg-shape"></div>
    <div class="bg-shape"></div>

    <!-- Floating Price Bubbles -->
    <div class="price-bubble">₹499 <small>vs ₹799</small></div>
    <div class="price-bubble">Save 38%!</div>

    <form id="form1" runat="server">
        <div class="login-container">
            <div class="logo">
                <h1>PriceCompare</h1>
                <p>Find the best deals instantly</p>
            </div>

            <h3>Admin Login</h3>

            <asp:Label ID="lblError" runat="server" CssClass="error"></asp:Label>

            <div class="input-group">
                <i class="fas fa-user-shield"></i>
                <asp:TextBox ID="txtusername" runat="server" CssClass="form-control" Placeholder="Enter Username" />
            </div>

            <div class="input-group">
                <i class="fas fa-key"></i>
                <asp:TextBox ID="txtpassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Enter Password" />
            </div>

            <asp:Button ID="Button1" runat="server" Text="Secure Login" CssClass="login-button" OnClick="Button1_Click" />
        </div>
    </form>
</body>
</html>