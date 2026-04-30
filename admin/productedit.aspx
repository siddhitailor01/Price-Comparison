<%@ Page Title="" Language="C#" MasterPageFile="~/admin/adminMasterPage.master" AutoEventWireup="true" CodeFile="productedit.aspx.cs" Inherits="productedit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .edit-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 85vh;
            background: #f8f9fa;
        }

        .edit-card {
            width: 100%;
            max-width: 700px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 30px 40px;
        }

        .edit-card h3 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: 600;
            color: rgb(0 51 132 / 90%);
        }

        .form-group label {
            font-weight: 500;
        }

        .form-control {
            border-radius: 8px;
        }

        .img-preview {
            display: flex;
            justify-content: center;
            margin-bottom: 15px;
        }

        .img-preview img {
            border: 1px solid #ccc;
            border-radius: 12px;
            width: 140px;
            height: 140px;
            object-fit: cover;
        }

        .btn {
            width: 100%;
            border-radius: 30px;
            font-weight: 500;
            padding: 10px;
            background-color:rgb(0 51 132 / 90%);
            color:#ffffff;
        }
            .btn:hover {
            border:1px solid rgb(0 51 132 / 90%);
            color:rgb(0 51 132 / 90%);
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="edit-container mt-4">
    <div class="edit-card">
    <h3>Edit Product</h3>

    <div class="form-group mb-3">
        <label>Category</label>
        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control"></asp:DropDownList>
    </div>

    <div class="form-group mb-3">
        <label>Product Name</label>
        <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control"></asp:TextBox>
    </div>

    <div class="form-group mb-3">
        <label>Brand</label>
        <asp:TextBox ID="txtBrand" runat="server" CssClass="form-control"></asp:TextBox>
    </div>

    <div class="form-group mb-3">
        <label>Price</label>
        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control"></asp:TextBox>
    </div>

    <div class="form-group mb-3">
        <label>Features</label>
        <asp:TextBox ID="txtFeatures" TextMode="MultiLine" Rows="2" runat="server" CssClass="form-control"></asp:TextBox>
    </div>

    <div class="img-preview">
        <asp:Image ID="imgPreview" runat="server" />
    </div>

    <div class="form-group mb-3">
        <label>Upload New Image</label>
        <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" />
    </div>

    <!-- Affiliate Price Fields -->
    <div class="form-group mb-3">
        <label>Amazon Price</label>
        <asp:TextBox ID="txtAmazonPrice" runat="server" CssClass="form-control"></asp:TextBox>
    </div>

    <div class="form-group mb-3">
        <label>Flipkart Price</label>
        <asp:TextBox ID="txtFlipkartPrice" runat="server" CssClass="form-control"></asp:TextBox>
    </div>

    <div class="form-group mb-3">
        <label>Myntra Price</label>
        <asp:TextBox ID="txtMyntraPrice" runat="server" CssClass="form-control"></asp:TextBox>
    </div>

    <div class="form-group mb-3">
        <label>Ajio Price</label>
        <asp:TextBox ID="txtAjioPrice" runat="server" CssClass="form-control"></asp:TextBox>
    </div>

    <div class="form-group mb-3">
        <label>Croma Price</label>
        <asp:TextBox ID="txtCromaPrice" runat="server" CssClass="form-control"></asp:TextBox>
    </div>

    <div class="form-group mb-3">
        <label>Reliance Price</label>
        <asp:TextBox ID="txtReliancePrice" runat="server" CssClass="form-control"></asp:TextBox>
    </div>

    <div class="form-group mb-3">
        <label>Meesho Price</label>
        <asp:TextBox ID="txtMeeshoPrice" runat="server" CssClass="form-control"></asp:TextBox>
    </div>

    <div class="form-group mb-3">
        <label>Shopsy Price</label>
        <asp:TextBox ID="txtShopsyPrice" runat="server" CssClass="form-control"></asp:TextBox>
    </div>

    <!-- Affiliate Link Fields -->
    <div class="form-group mb-3">
        <label>Amazon Link</label>
        <asp:TextBox ID="txtAmazon" runat="server" CssClass="form-control" Placeholder="Amazon affiliate link"></asp:TextBox>
    </div>

    <div class="form-group mb-3">
        <label>Flipkart Link</label>
        <asp:TextBox ID="txtFlipkart" runat="server" CssClass="form-control" Placeholder="Flipkart affiliate link"></asp:TextBox>
    </div>

    <div class="form-group mb-3">
        <label>Myntra Link</label>
        <asp:TextBox ID="txtMyntra" runat="server" CssClass="form-control" Placeholder="Myntra affiliate link"></asp:TextBox>
    </div>

    <div class="form-group mb-3">
        <label>Ajio Link</label>
        <asp:TextBox ID="txtAjioLink" runat="server" CssClass="form-control" Placeholder="Ajio affiliate link"></asp:TextBox>
    </div>

    <div class="form-group mb-3">
        <label>Croma Link</label>
        <asp:TextBox ID="txtCromaLink" runat="server" CssClass="form-control" Placeholder="Croma affiliate link"></asp:TextBox>
    </div>

    <div class="form-group mb-3">
        <label>Reliance Link</label>
        <asp:TextBox ID="txtRelianceLink" runat="server" CssClass="form-control" Placeholder="Reliance affiliate link"></asp:TextBox>
    </div>

    <div class="form-group mb-3">
        <label>Meesho Link</label>
        <asp:TextBox ID="txtMeeshoLink" runat="server" CssClass="form-control" Placeholder="Meesho affiliate link"></asp:TextBox>
    </div>

    <div class="form-group mb-3">
        <label>Shopsy Link</label>
        <asp:TextBox ID="txtShopsyLink" runat="server" CssClass="form-control" Placeholder="Shopsy affiliate link"></asp:TextBox>
    </div>

    <asp:Button ID="btnupdate" runat="server" CssClass="btn btn-primary" OnClick="btnupdate_Click" Text="Update Product" />
    <asp:Label ID="lblMsg" runat="server" CssClass="text-success mt-3 d-block text-center"></asp:Label>
</div>

</div>


</asp:Content>
