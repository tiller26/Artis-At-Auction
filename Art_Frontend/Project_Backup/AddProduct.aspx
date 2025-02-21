<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="Project_Backup.AddProduct" %>

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
                            <h2>Artwork Category</h2>
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
                                            <h4>Select the category the artwork falls under</h4>
                                        </div>
                                        <div>
                                            <div class="form-button">
                                                <button runat="server" onserverclick="Art" style="width: 55%; cursor: pointer" type="submit" class="template-btn2 on1">Art<span>&#8640;</span></button>
                                            </div>
                                            <div class="form-button">
                                                <button runat="server" onserverclick="Clothing" style="width: 55%; cursor: pointer" type="submit" class="template-btn2 on1">Clothing<span>&#8640;</span></button>
                                            </div>
                                            <div class="form-button">
                                                <button runat="server" onserverclick="Accessory" style="width: 55%; cursor: pointer" type="submit" class="template-btn2 on1">Accessory<span>&#8640;</span></button>
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
