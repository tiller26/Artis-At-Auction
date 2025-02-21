<%@ Page EnableEventValidation="false" Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AboutArtisans.aspx.cs" Inherits="Project_Backup.AboutArtisans" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="shop-page common-typography">
        <!-- Shop Content Starts -->
        <section class="shop-content">
            <div class="container mb-5">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title text-center">
                        <h2>our trusted artisans</h2>
                    </div>
                </div>
            </div>
            <div runat="server" id="Div1" class="gallery-slider owl-carousel">
               <!--- Sellers goes here -->
            </div>
        </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-9 mx-auto">
                        <div class="shop-items-top d-flex justify-content-between">
                            <div class="dropdown">
                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                    <a class="dropdown-item" href="Shop.aspx">All Bids</a>
                                    <a class="dropdown-item" href="Shop.aspx?bt=upcoming">Upcoming</a>
                                    <a class="dropdown-item" href="Shop.aspx?bt=open">Open Bids</a>
                                </div>
                            </div>
                        </div>

                        <div class="shop-items">
                            <div runat="server" id="productItem" class="row">
                                <!-- Item goes here -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</asp:Content>
