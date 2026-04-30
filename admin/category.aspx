<%@ Page Title="Manage Categories" Language="C#" MasterPageFile="~/admin/adminMasterPage.master" AutoEventWireup="true" CodeFile="category.aspx.cs" Inherits="category" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .page-title { font-weight: 600; color: #003384; margin-bottom: 25px; }
        .card { border: none; border-radius: 20px; box-shadow: 0 4px 18px rgba(0, 0, 0, 0.08); transition: 0.3s ease; }
        .card:hover { transform: translateY(-3px); }
        .form-control { border-radius: 10px; padding: 10px 12px; }
        .btn-custom { background-color: #003384; color: white; border-radius: 10px; padding: 10px 20px; }
        .btn-custom:hover { background-color: #002366; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th { background: #003384; color: white; padding: 12px; text-align: center; }
        td { padding: 10px; text-align: center; border-bottom: 1px solid #ddd; }
        tr:hover td { background-color: #f1f3f9; }
        .btn-link { text-decoration: none; font-weight: 600; }
        .btn-link:hover { color: #ffba08; }
        .lbl-hidden { display: none; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="container-fluid px-4">
        <h2 class="page-title mt-5"><i class="fa-solid fa-layer-group"></i> Manage Categories</h2>

        <div class="row g-4">

            <!-- Left Side Form -->
            <div class="col-lg-5">
                <div class="card p-4">
                    <h5 class="mb-3"><i class="fa-solid fa-plus-circle"></i> Add / Update Category</h5>

                    <div class="mb-3">
                        <label>Category Name</label>
                        <asp:TextBox ID="txtcategory" runat="server" CssClass="form-control" Placeholder="Enter category name"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label>Select Main Category (Optional)</label>
                        <asp:DropDownList ID="ddlParent" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>

                    <div class="d-flex gap-2">
                        <asp:Button ID="btnsave" runat="server" Text="Save" CssClass="btn btn-custom me-2" OnClick="btnsave_Click" />
                        <asp:Button ID="Button1" runat="server" Text="Update" CssClass="btn btn-warning text-white" OnClick="Button1_Click" />
                    </div>

                    <asp:Label ID="lbledit" runat="server" CssClass="lbl-hidden"></asp:Label>
                </div>
            </div>

            <!-- Right Side Table -->
            <div class="col-lg-7">
                <div class="card p-4">
                    <h5 class="mb-3"><i class="fa-solid fa-table-list"></i> Category List</h5>

                    <table class="table table-bordered">
                        <tr>
                            <th>ID</th>
                            <th>Category</th>
                            <th>Main Category</th>
                            <th>Delete</th>
                            <th>Edit</th>
                        </tr>

                        <asp:ListView ID="lstview" runat="server" OnItemCommand="lstview_ItemCommand" OnItemDeleting="lstview_ItemDeleting">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("CatID") %></td>
                                    <td><%# Eval("CategoryName") %></td>
                                    <td><%# Eval("ParentCategory") %></td>

                                    <td>
                                        <asp:LinkButton ID="btnDel" runat="server" CommandName="delete" 
                                            CommandArgument='<%# Eval("CatID") %>' CssClass="btn-link text-danger">
                                            Delete
                                        </asp:LinkButton>
                                    </td>

                                    <td>
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="edit" 
                                            CommandArgument='<%# Eval("CatID") %>' CssClass="btn-link text-success">
                                            Edit
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:ListView>
                    </table>

                </div>
            </div>
        </div>
    </div>

</asp:Content>
