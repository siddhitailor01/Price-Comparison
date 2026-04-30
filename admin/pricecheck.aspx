<%@ Page Title="" Language="C#" MasterPageFile="~/admin/adminMasterPage.master" AutoEventWireup="true" CodeFile="pricecheck.aspx.cs" Inherits="pricecheck" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2 class="mb-4">Price Drop Checker</h2>

<!-- CHECK PRICE BUTTON -->
<asp:Button ID="btnCheckPrice" runat="server"
    CssClass="btn btn-primary"
    Text="Check Price Drops & Send Emails"
    OnClick="btnCheckPrice_Click" />

<br /><br />



<!-- RESULT MESSAGE -->
<asp:Label ID="lblMsg" runat="server" CssClass="fw-bold"></asp:Label>

<hr />

<!-- FOLLOWED PRODUCTS LIST -->
<asp:ListView ID="lstFollowed" runat="server">
    <ItemTemplate>
        <div class="card p-3 mb-2 border-2 
                     <%# Convert.ToDecimal(Eval("Price")) < Convert.ToDecimal(Eval("OldPrice")) 
                         ? "border-danger" : "border-secondary" %>">

            <h5><%# Eval("ProductName") %></h5>

            <p>User: <strong><%# Eval("Email") %></strong></p>

            <p>
                Old Price: 
                <span class="text-muted">₹<%# Eval("OldPrice") %></span>
            </p>

            <p>
                Current Price:
                <span class='<%# Convert.ToDecimal(Eval("Price")) < Convert.ToDecimal(Eval("OldPrice")) 
                        ? "text-danger fw-bold" : "fw-bold" %>'>
                    ₹<%# Eval("Price") %>
                </span>
            </p>
        </div>
    </ItemTemplate>
</asp:ListView>


</asp:Content>

