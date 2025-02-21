<%@ Page Title="" EnableEventValidation="false" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Project_Backup.Cart" %> 

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cart-tab-page common-typography mt-5">
        <!-- Tab Header Starts -->
        <header class="container">
            <div class="row">
                <div class="col-lg-12 mt-70 mb-40">
                    <div class="tab-accordion cart-tab">
                        <div class="tab">
                            <ul class="d-flex justify-content-between">
                                <li class="active">
                                    <h4>Cart</h4>
                                </li>
                                <li class="">
                                    <h4>Shipping</h4>
                                </li>
                                <li class="">
                                    <h4>Checkout</h4>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="tab-accordion-text text-center mt-70">
                        <%-- <p>The next shipping for<span> 3 Hours 32 Mins</span> </p>--%>
                    </div>
                </div>
            </div>
        </header>
        <!-- Tab Header End -->

        <!-- Tab Content Starts -->
        <div class="tab-content-section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="tab-content">
                            <div class="tab-one-content lost active current">

                                <!-- Cart Section Starts -->
                                <div class="cart-section estimation-section-main">
                                    <div class="cart-title">
                                        <h2>Cart</h2>
                                    </div>
                                    <div class="qty-price text-center mb-4">
                                        <ul>
                                            <li class="right-margin"></li>
                                            <li>
                                                <h4>Price</h4>
                                            </li>
                                        </ul>
                                    </div>

                                    <div class="cart-box">

                                        <div runat="server" id="cartItems">
                                            <%-- Cart items go here --%>
                                        </div>

                                        <div class="row estimation-section">
                                            <div class="col-lg-6">
                                                <div class="estimation-left">
                                                    <div class="left-title">
                                                        <h4>Estimation</h4>
                                                    </div>

                                                    <div class="left-text d-md-flex">
                                                        <div class="name">
                                                            <ul>
                                                                <li>Order</li>
                                                                <li>VAT</li>
                                                            </ul>
                                                        </div>
                                                        <div class="price">
                                                            <ul>
                                                                <li runat="server" id="cartTotal">R 2828</li>
                                                                <li runat="server" id="vat">R 370,20</li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="estimation-right text-right">
                                                    <div class="right-title">
                                                        <h4>Total</h4>
                                                        <h3 runat="server" id="grandTotal">R 2838,20</h3>
                                                        <a runat="server" id="proceed" href="Checkout.aspx" class="template-btn2 off1">Set Address <span>&rharu;</span></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Cart Section End -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Tab Content End -->
    </div>
</asp:Content>
