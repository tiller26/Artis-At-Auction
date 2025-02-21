<%@ Page Title="" EnableEventValidation="false" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderCompleted.aspx.cs" Inherits="Project_Backup.OrderCompleted" %>

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
                    <div class="summary-header text-center">
                        <img src="assets/img/cart-tab-page/thanks.png" class="mb-3" alt="">
                        <h3>Thank You, Champion !</h3>
                        <p class="mt-4">
                            Huraaay! You order has been placed successfully.
                                        <br>
                            We received your payment and wrapping up your stuff for shipping
                        </p>
                        <a href="Home.aspx" class="template-btn2 off1 mt-5">Go Home</a>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
