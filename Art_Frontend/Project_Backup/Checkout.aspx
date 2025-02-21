<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="Project_Backup.Checkout" %>

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
                                <li class="">
                                    <h4>Cart</h4>
                                </li>
                                <li class="active">
                                    <h4>Shipping</h4>
                                </li>
                                <li class="">
                                    <h4>Summary</h4>
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
                            <div class="tab-second-content lost active">
                                <!-- Shipping Section Starts -->
                                <div class="shipping-section">
                                    <div class="shipping-title">
                                        <h2>Shipping</h2>
                                    </div>

                                    <div class="shipping-box estimation-section-main cart-box mt-70">
                                        <div class="address-section delivery-section d-md-flex">
                                            <div class="address-left">
                                                <h4>Address</h4>
                                            </div>
                                            <div class="address-right">
                                                <div class="mt-1">
                                                    <div class="common-input2 mb-5">
                                                        <h6>Name*</h6>
                                                        <input runat="server" id="name" type="text" disabled>
                                                    </div>


                                                    <div class="common-input2 mb-5">
                                                        <h6>Street Address*</h6>
                                                        <input runat="server" id="street" type="text" placeholder="e.i 123 High Street">
                                                    </div>

                                                    <div class="common-input2 mb-5">
                                                        <h6>City*</h6>
                                                        <input runat="server" id="city" type="text" placeholder="e.i Cape Town">
                                                    </div>

                                                    <div class="common-input2 mb-5">
                                                        <h6>Province*</h6>
                                                        <input runat="server" id="province" type="text" placeholder="e.i Gauteng">
                                                    </div>

                                                    <div class="common-input2 mb-5">
                                                        <h6>Country*</h6>
                                                        <input type="text" value="South Africa" disabled>
                                                    </div>

                                                    <div class="common-input2 mb-5 row">
                                                        <div class="col-6">
                                                            <h6>Phone Number*</h6>
                                                            <input runat="server" id="contact" type="text" disabled>
                                                        </div>
                                                        <div class="col-6">
                                                            <h6>Email*</h6>
                                                            <input runat="server" id="email" type="email" disabled>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="row estimation-section" style="background-color: #FBF4EF">
                                            <div class="col-lg-6">
                                                <div class="estimation-left">
                                                    <div class="left-title">
                                                        <h4>Estimation</h4>
                                                    </div>

                                                    <div class="left-text d-md-flex">
                                                        <div class="name">
                                                            <ul>
                                                                <li>Order</li>
                                                                <li>Free Delivery</li>
                                                                <li>VAT</li>
                                                            </ul>
                                                        </div>
                                                        <div class="price">
                                                            <ul>
                                                                <li runat="server" id="cartTotal">R 2828</li>
                                                                <li>R 0</li>
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
                                                        <a href="OrderSummary.aspx" class="template-btn2 off1">Complete Order <span>&rharu;</span></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Shipping Section End -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Tab Content End -->
    </div>
</asp:Content>
