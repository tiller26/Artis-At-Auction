<%@ Page EnableEventValidation="false" Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="Project_Backup.Product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Banner Starts -->
    <div class="cart-page common-typography">
        <section class="cart-banner">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 align-self-center pt-5 mt-5 order-2 order-lg-1">
                        <div class="cart-banner-left">
                            <div class="left-title mb-5">
                                <h3 runat="server" id="name">Summer Collection</h3>
                                <a runat="server" id="sellerLink">
                                    <h4 runat="server" id="sellerName">Velvet Red Dress</h4>
                                </a>
                            </div>
                            <div class="price mb-5">
                                <h2 runat="server" id="price">$90,00</h2>
                            </div>
                            <div runat="server" id="images" class="left-image d-flex small-slider">
                                <!-- Images go here -->
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-5 order-1 order-lg-2">
                        <div runat="server" id="bannerImg" class="banner-image big-slider">
                            <!-- Banner image goes here -->
                        </div>
                    </div>
                    <div class="col-lg-4 align-self-center order-3">
                        <div class="banner-right mb-5">
                            <div runat="server" id="description" class="right-top">
                                <!-- Description goes here -->
                            </div>
                            <div runat="server" id="button" class="right-button mt-40">
                                <!-- Place Bid OR View Bid button goes here -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <!-- Banner End -->
</asp:Content>
