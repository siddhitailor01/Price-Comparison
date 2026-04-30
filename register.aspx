<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <style>
/* Background Gradient & Animation */
.login-bg {
    min-height: 0vh !important;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 5px;
    background-size: 300% 300%;
    animation: gradientMove 8s ease infinite;
}

@keyframes gradientMove {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}

/* Glass Card */
.login-card {
    width: 380px;
    background: rgba(255, 255, 255, 0.15);
    border-radius: 18px;
    padding: 35px;
    box-shadow: 0 10px 40px rgba(0,0,0,0.3);
    backdrop-filter: blur(15px);
    border: 1px solid rgba(255,255,255,0.3);
    animation: fadeSlide 0.8s ease;
        background: linear-gradient(135deg, #4f46e5, #3b82f6, #06b6d4);

}

@keyframes fadeSlide {
    from { opacity: 0; transform: translateY(30px); }
    to { opacity: 1; transform: translateY(0); }
}

.login-title {
    font-weight: 700;
    font-size: 30px;
    text-align: center;
    color: #fff;
}

.login-card .form-control {
    border-radius: 10px;
    padding: 12px;
    border: none;
    margin-top: 18px;
    box-shadow: 0 0 0 1px rgba(255,255,255,0.4);
}

.login-btn {
    background: #ffffff;
    color: #3b82f6;
    font-weight: bold;
    border-radius: 12px;
    padding: 12px;
    margin-top: 20px;
    transition: 0.3s;
    border: none;
}

.login-btn:hover {
    background: #3b82f6;
    color: #fff;
    transform: translateY(-3px);
    box-shadow: 0 8px 18px rgba(59,130,246,0.5);
}

.login-link {
    color: #fff;
    display: block;
    margin-top: 12px;
    text-align: center;
    font-size: 14px;
}

.login-link:hover {
    text-decoration: underline;
}

</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="login-bg">
    <div class="login-card">

        <h3 class="login-title">Create Account</h3>

        <asp:TextBox ID="txtName" CssClass="form-control" placeholder="Full Name" runat="server"></asp:TextBox>
        <asp:TextBox ID="txtEmail" CssClass="form-control" placeholder="Email Address" runat="server"></asp:TextBox>
        <asp:TextBox ID="txtPassword" TextMode="Password" CssClass="form-control" placeholder="Create Password" runat="server"></asp:TextBox>

        <asp:Button ID="btnRegister" runat="server" Text="Register"
            CssClass="login-btn w-100" OnClick="btnRegister_Click" />

        <asp:Label ID="lblMsg" runat="server" CssClass="text-danger mt-2"></asp:Label>

        <a href="login.aspx" class="login-link">Already have an account? Login</a>
    </div>
</div>

</asp:Content>


