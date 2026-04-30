<%@ Page Title="Add Product" Language="C#" MasterPageFile="~/admin/adminMasterPage.master" AutoEventWireup="true" CodeFile="product.aspx.cs" Inherits="product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .page-title {
            font-weight: 600;
            color: #003384;
            margin-bottom: 25px;
        }

        .card {
            border: none;
            border-radius: 18px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
            transition: 0.3s;
        }

        .card:hover { transform: translateY(-3px); }

        .form-control {
            border-radius: 10px;
            font-size: 14px;
        }

        .btn-custom {
            background-color: #003384;
            color: #fff;
            border-radius: 10px;
            padding: 10px 25px;
            transition: 0.3s;
        }

        .btn-custom:hover { background-color: #002366; }

        .preview-card {
            background: #f8faff;
            border-radius: 18px;
            text-align: center;
            padding: 25px;
        }

        .preview-img {
            width: 140px;
            height: 140px;
            border-radius: 10px;
            object-fit: cover;
            border: 1px solid #ddd;
            margin-bottom: 10px;
        }

        .form-label {
            font-weight: 500;
            font-size: 14px;
        }

        .container-fluid {
            max-width: 1200px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="container-fluid mt-5">
    <h3 class="page-title"><i class="fa-solid fa-box-open"></i> Add New Product</h3>

    <div class="row g-4">
        <!-- LEFT SIDE: FORM -->
        <div class="col-lg-12">
            <div class="card p-4">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Category</label>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Brand</label>
                        <asp:TextBox ID="txtBrand" runat="server" CssClass="form-control" Placeholder="Enter brand"></asp:TextBox>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Product Name</label>
                        <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" Placeholder="Product name"></asp:TextBox>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Price (₹)</label>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" Placeholder="Enter price"></asp:TextBox>
                    </div>

                    <div class="col-12 mb-3">
                        <label class="form-label">Features</label>
                        <asp:TextBox ID="txtFeatures" TextMode="MultiLine" Rows="3" runat="server" CssClass="form-control" Placeholder="Write product features..."></asp:TextBox>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">AmazonPrice</label>
                        <asp:TextBox ID="txtamazonprice" runat="server" CssClass="form-control" Placeholder="Enter Amazon Price"></asp:TextBox>
                    </div>
                       <div class="col-md-6 mb-3">
                        <label class="form-label">FlipkartPrice</label>
                        <asp:TextBox ID="txtflipkartprice" runat="server" CssClass="form-control" Placeholder="Enter Flipkart Price"></asp:TextBox>
                    </div>
                       <div class="col-md-6 mb-3">
                        <label class="form-label">MyntraPrice</label>
                        <asp:TextBox ID="txtmyntraprice" runat="server" CssClass="form-control" Placeholder="Enter Myntra Price"></asp:TextBox>
                    </div>
                       <div class="col-md-6 mb-3">
                        <label class="form-label">AjioPrice</label>
                        <asp:TextBox ID="txtajioprice" runat="server" CssClass="form-control" Placeholder="Enter Ajio Price"></asp:TextBox>
                    </div>
                       <div class="col-md-6 mb-3">
                        <label class="form-label">CromaPrice</label>
                        <asp:TextBox ID="txtcromaprice" runat="server" CssClass="form-control" Placeholder="Enter Croma Price"></asp:TextBox>
                    </div>
                       <div class="col-md-6 mb-3">
                        <label class="form-label">ReliancePrice</label>
                        <asp:TextBox ID="txtrelianceprice" runat="server" CssClass="form-control" Placeholder="Enter Reliance Price"></asp:TextBox>
                    </div>
                        <div class="col-md-6 mb-3">
                        <label class="form-label">MeeshoPrice</label>
                        <asp:TextBox ID="txtmeeshoprice" runat="server" CssClass="form-control" Placeholder="Enter Reliance Price"></asp:TextBox>
                    </div>
                        <div class="col-md-6 mb-3">
                        <label class="form-label">ShopsyPrice</label>
                        <asp:TextBox ID="txtshopsyprice" runat="server" CssClass="form-control" Placeholder="Enter Reliance Price"></asp:TextBox>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Upload Image</label>
                        <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" />
                    </div>

                    <div class="col-md-6 mb-3">
    <label class="form-label">Amazon Link</label>
    <asp:TextBox ID="txtAmazon" runat="server" CssClass="form-control" Placeholder="Amazon affiliate link"></asp:TextBox>
</div>

<div class="col-md-6 mb-3">
    <label class="form-label">Flipkart Link</label>
    <asp:TextBox ID="txtFlipkart" runat="server" CssClass="form-control" Placeholder="Flipkart affiliate link"></asp:TextBox>
</div>

<div class="col-md-6 mb-3">
    <label class="form-label">Myntra Link</label>
    <asp:TextBox ID="txtMyntra" runat="server" CssClass="form-control" Placeholder="Myntra affiliate link"></asp:TextBox>
</div>
                    <div class="col-md-6 mb-3">
    <label class="form-label">Ajio Link</label>
    <asp:TextBox ID="txtAjioLink" runat="server" CssClass="form-control" Placeholder="Ajio affiliate link"></asp:TextBox>
</div>

<div class="col-md-6 mb-3">
    <label class="form-label">Croma Link</label>
    <asp:TextBox ID="txtCromaLink" runat="server" CssClass="form-control" Placeholder="Croma affiliate link"></asp:TextBox>
</div>

<div class="col-md-6 mb-3">
    <label class="form-label">Reliance Link</label>
    <asp:TextBox ID="txtRelianceLink" runat="server" CssClass="form-control" Placeholder="Reliance affiliate link"></asp:TextBox>
</div>
<div class="col-md-6 mb-3">
    <label class="form-label">Meesho Link</label>
    <asp:TextBox ID="txtMesshoLink" runat="server" CssClass="form-control" Placeholder="Ajio affiliate link"></asp:TextBox>
</div>

<div class="col-md-6 mb-3">
    <label class="form-label">Shopsy Link</label>
    <asp:TextBox ID="txtShopsyLink" runat="server" CssClass="form-control" Placeholder="Croma affiliate link"></asp:TextBox>
</div>





                    <div class="col-12 text-center mt-2">
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-custom" OnClick="btnSave_Click" Text="Add Product" />
                        <asp:Label ID="lblMsg" runat="server" CssClass="text-success d-block mt-2"></asp:Label>
                    </div>
                </div>
            </div>
        </div>

        <!-- RIGHT SIDE: LIVE PREVIEW -->
      
    </div>
</div>

</asp:Content>
