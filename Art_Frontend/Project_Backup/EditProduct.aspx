<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditProduct.aspx.cs" Inherits="Project_Backup.EditProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="profile-page common-typography mt-5">

        <!-- Profile Area Starts -->
        <section class="profile-area pt-5">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="profile-title">
                            <h2>Edit Item Details</h2>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-8 mx-auto">
                        <div class="tab-content">
                            <div class="tab-one-content lost active">
                                <div class="contact-bg">
                                    <div class="form-border">
                                        <div class="form-title">
                                            <h4>Item Information</h4>
                                        </div>
                                        <div>
                                            <div class="row mb-5">
                                                <h6>Item Name</h6>
                                                <input runat="server" id="iName" type="text" />
                                            </div>
                                            <div class="row mb-5">
                                                <h6>Item Description</h6>
                                                <textarea runat="server" id="iDescription" rows="8"></textarea>
                                            </div>
                                            <div class="row">
                                                <h6>Item Price</h6>
                                                <input runat="server" id="iPrice" type="number" />
                                            </div>
                                            <div class="form-button">
                                                <button runat="server" onserverclick="Edit" type="submit" class="template-btn2 on1">Update Item<span>&#8640;</span></button>
                                                <button runat="server" onserverclick="Back" type="submit" class="template-btn2 on2">Go Back<span>&#8640;</span></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</asp:Content>
