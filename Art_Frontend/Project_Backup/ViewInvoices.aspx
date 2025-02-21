<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewInvoices.aspx.cs" Inherits="Project_Backup.ViewInvoices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cart-tab-page common-typography mt-1">
        <header class="container">
            <div class="row">
                <div class="col-lg-12 mb-40">
                    <%--<div class="tab-accordion cart-tab">
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
                        </div>
                    </div>--%>
                    <div class="tab-accordion-text text-center mt-70">
                        <%-- <p>The next shipping for<span> 3 Hours 32 Mins</span> </p>--%>
                    </div>
                </div>
            </div>
        </header>
        <!-- Tab Header End -->
        <div class="tab-four-content">
            <div class="summary-section">
                <div class="summary-box cart-box">
                    <div class="summary-content">
                        <div class="order-part">
                            <div class="row">

                                <%--<div runat="server" id="items" class="col-lg-8">--%>

                                <%-- Items go here --%>
                                <div class="col-lg-4 " id="InvoiceHtml" runat="server">
                                </div>

                                <%--</div>--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
