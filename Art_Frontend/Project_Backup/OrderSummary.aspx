<%@ Page Title="" EnableEventValidation="false" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderSummary.aspx.cs" Inherits="Project_Backup.OrderSummary" %>

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
                                <li class="">
                                    <h4>Shipping</h4>
                                </li>
                                <li class="active">
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

        <div class="cart-tab-page common-typography mt-5">
            <!-- Order Summary-->
            <div class="tab-four-content">
                <div class="summary-section">
                    <div class="summary-box cart-box">
                        <div class="summary-content">
                            <div class="order-part">
                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="common-left">
                                            <h4>Invoice Details</h4>
                                        </div>
                                    </div>
                                    <div runat="server" id="items" class="col-lg-8">
                                        
                                            <%-- Items go here --%>

                                    </div>
                                </div>
                            </div>

                            <div class="estimation-part mt-70">
                                <div class="row">
                                    <div class="col-lg-3">
                                        <div class="common-left">
                                            <h4>Estimation</h4>
                                        </div>
                                    </div>
                                    <div class="col-lg-8 offset-lg-1">
                                        <div class="common-right pt-80 d-flex justify-content-between mb-70">
                                            <div>
                                                <ul>
                                                    <li>Order Total</li>
                                                    <li>Free Shipping</li>
                                                    <li>VAT</li>
                                                    <li class="mt-4">Grand Total</li>
                                                </ul>
                                            </div>
                                            <div class="price">
                                                <ul>
                                                    <li runat="server" id="total">R 2828</li>
                                                    <li>R 0</li>
                                                    <li runat="server" id="vat">R 370,20</li>
                                                    <li runat="server" id="grandTotal" class="mt-4">R 2838,20</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="information-part mt-70">
                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="common-left">
                                            <h4>Customer Information</h4>
                                        </div>
                                    </div>
                                    <div class="col-lg-8">
                                        <div class="common-right pt-80 d-flex justify-content-between mb-70">
                                            <div class="address">
                                                <h5>Shipping Address</h5>
                                                <ul class="mt-4">
                                                    <li runat="server" id="street">Western Cape</li>
                                                    <li runat="server" id="city">Claremont</li>
                                                    <li runat="server" id="province">P.O Box 255</li>
                                                    <li>South Africa</li>
                                                    <li runat="server" id="contact">+27 71 523 7555</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row estimation-section">
                                <div class="col-lg-6">
                                </div>
                                <div class="col-lg-6">
                                    <div class="estimation-right text-right">
                                        <div class="right-title">
                                            <a href="OrderCompleted.aspx" class="template-btn2 off1">Pay <span>&rharu;</span></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
