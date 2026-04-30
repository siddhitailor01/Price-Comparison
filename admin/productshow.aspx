<%@ Page Title="Manage Products" Language="C#" MasterPageFile="~/admin/adminMasterPage.master" AutoEventWireup="true" CodeFile="productshow.aspx.cs" Inherits="productshow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .page-header {
            font-weight: 600;
            color: #003384;
            margin: 25px 0;
            text-transform: uppercase;
        }

        .table-container {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
            padding: 25px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #003384;
            color: white;
            text-align: center;
            padding: 12px;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        td {
            text-align: center;
            padding: 10px;
            font-size: 13px;
            vertical-align: middle;
        }

        tr:nth-child(even) { background-color: #f8faff; }
        tr:hover { background-color: #eef3ff; }

        img {
            border-radius: 8px;
            border: 1px solid #ddd;
        }

        .action-btn {
            padding: 5px 10px;
            border-radius: 6px;
            color: #fff;
            text-decoration: none;
            font-size: 13px;
            transition: 0.3s;
        }

        .btn-delete {
            background: #d9534f;
        }

        .btn-delete:hover {
            background: #b52b27;
        }

        .btn-edit {
            background: #5cb85c;
        }

        .btn-edit:hover {
            background: #449d44;
        }
      .table-scroll-row {
    display: flex;
    overflow-x: auto;
    -webkit-overflow-scrolling: touch; /* smooth scroll mobile */
}

.table-scroll-row > div {
    flex: 0 0 150px; /* adjust column width */
    padding: 8px;
    text-align: center;
    border-bottom: 1px solid #ddd;
    white-space: nowrap;
}

.table-scroll-row img {
    width: 80px;
    height: 80px;
    border-radius: 8px;
    border: 1px solid #ddd;
}


    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="container-fluid mt-5">
        <h3 class="page-header"><i class="fa-solid fa-boxes-stacked"></i> Manage Products</h3>

        <div class="table-container">
    <div class="table-scroll-wrapper">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>P. ID</th>
                    <th>Cat. ID</th>
                    <th>Pr Name</th>
                    <th>Brand</th>
                    <th>Price (₹)</th>
                    <th>Features</th>
                    <th>Image</th>
                    <th>Amazon</th>
                    <th>Amazon ₹</th>
                    <th>Flipkart</th>
                    <th>Flipkart ₹</th>
                    <th>Myntra</th>
                    <th>Myntra ₹</th>
                    <th>Ajio ₹</th>
                    <th>Croma ₹</th>
                    <th>Reliance ₹</th>
                    <th>Delete</th>
                    <th>Edit</th>
                </tr>
            </thead>
            <tbody>
                <asp:ListView ID="lstshow" runat="server" OnItemCommand="lstshow_ItemCommand">
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("ProductID") %></td>
                            <td><%# Eval("CatID") %></td>
                            <td><%# Eval("ProductName") %></td>
                            <td><%# Eval("Brand") %></td>
                            <td>₹ <%# Eval("Price") %></td>
                            <td><%# Eval("Features") %></td>
                            <td>
                                <img src='<%# ResolveUrl("~/admin/images/" + Eval("ImageUrl")) %>' 
                                     alt="Product Image" width="80" height="80" />
                            </td>

                            <td><a href='<%# Eval("AmazonLink") %>' target="_blank">View</a></td>
                            <td>₹ <%# Eval("AmazonPrice") %></td>

                            <td><a href='<%# Eval("FlipkartLink") %>' target="_blank">View</a></td>
                            <td>₹ <%# Eval("FlipkartPrice") %></td>

                            <td><a href='<%# Eval("MyntraLink") %>' target="_blank">View</a></td>
                            <td>₹ <%# Eval("MyntraPrice") %></td>

                            <td>₹ <%# Eval("AjioPrice") %></td>
                            <td>₹ <%# Eval("CromaPrice") %></td>
                            <td>₹ <%# Eval("ReliancePrice") %></td>

                            <td>
                                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="action-btn btn-delete"
                                    CommandName="delete" CommandArgument='<%# Eval("ProductID") %>'>
                                    <i class="fa fa-trash"></i> 
                                </asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton ID="LinkButton2" runat="server" CssClass="action-btn btn-edit"
                                    CommandName="edit" CommandArgument='<%# Eval("ProductID") %>'>
                                    <i class="fa fa-edit"></i> 
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
            </tbody>
        </table>
    </div>
</div>


    </div>

</asp:Content>
