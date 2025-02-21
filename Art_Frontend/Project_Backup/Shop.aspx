<%@ Page Title="" EnableEventValidation="false" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Shop.aspx.cs" Inherits="Project_Backup.Shop" %>

<%@ MasterType VirtualPath="~/Site.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="shop-page common-typography">
        <!-- Shop Content Starts -->
        <section class="shop-content">
            <div class="container">
                <div class="row">
                    <!-- Side Bar Starts -->
                    <div class="col-lg-3">
                        <div class="shop-sidebar">
                            <div>
                                <input runat="server" id="search" type="text" class="search-input" placeholder="Search" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Search'" >
                                <button runat="server" onserverclick="Search" id="btnSearch" type="submit" class="search-button"><i class="fa fa-search"></i></button>
                            </div>

                            <div class="categories">
                                <div class="title">
                                    <h4>CATEGORIES</h4>
                                </div>
                                <ul>
                                    <li><a href="Shop.aspx?id=clothing">Clothing</a></li>
                                    <li><a href="Shop.aspx?id=accessories">Accessories</a></li>
                                    <li><a href="Shop.aspx?id=art">Art</a></li>
                                </ul>
                            </div>

                            <%--<div class="row">
                                <div class="col-lg-12">
                                    <div class="title">
                                        <h4>Filter by Category</h4>
                                    </div>
                                    <div class="tab-accordion picks-tab text-center">

                                        <div class="tab">
                                            <ul style="display: inline-block; text-align: left;">
                                                <li class="tab-one active" data-filter="*"><a href="Shop.aspx">All</a></li>
                                                <li class="tab-second" data-filter=".clothing"><a href="Shop.aspx?id=clothing">Clothing</a></li>
                                                <li class="tab-three" data-filter=".accessories"><a href="Shop.aspx?id=accessories">Accessories</a></li>
                                                <li class="tab-four" data-filter=".art"><a href="Shop.aspx?id=art">Art</a></li>

                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>--%>


                            <div class="row">
                                <!-- Filter by Price Section -->
                                <div class="col-lg-12">
                                    <div class="title">
                                        <h4>Filter by Price</h4>
                                    </div>
                                    <div class="tab-accordion picks-tab text-center">
                                        <div class="tab">
                                            <ul style="display: inline-block; text-align: left;">
                                                <li class="tab-one active" data-filter="*"><a href="Shop.aspx">All</a></li>
                                                <li class="tab-second" data-filter=".price-0-3000"><a href="Shop.aspx?id=3stack">R0 - R3000</a></li>
                                                <li class="tab-third" data-filter=".price-3000-6000"><a href="Shop.aspx?id=6stack">R3000 - R6000</a></li>
                                                <li class="tab-four" data-filter=".price-6000-9000"><a href="Shop.aspx?id=9stack">R6000 - R9000</a></li>
                                                <li class="tab-five" data-filter=".price-9000-18000"><a href="Shop.aspx?id=18stack">R9000 - R18000</a></li>
                                                <li class="tab-six" data-filter=".price-18000plus"><a href="Shop.aspx?id=maxstack">R18000+</a></li>

                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- Side Bar Ends -->

                    <div class="col-lg-9">
                        <div class="shop-items-top d-flex justify-content-between">
                            <div class="left"><span runat="server" id="totalItems"></span></div>
                            <div class="dropdown">
                                <button class="drop-btn dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Show
                       
                                </button>
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
    <script type="text/javascript">
        // Function to start countdown for each product
        function startCountdown(productId, expiryTime) {
            const countdownElement = document.getElementById(`countdown-${productId}`);
            const expiryDate = new Date(expiryTime).getTime();

            // Update the countdown every 1 second
            const timer = setInterval(function () {
                const now = new Date().getTime();
                const distance = expiryDate - now;

                // Time calculations for days, hours, minutes, and seconds
                const days = Math.floor(distance / (1000 * 60 * 60 * 24));
                const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((distance % (1000 * 60)) / 1000);

                // Display the result
                countdownElement.innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s ";

                // If the countdown is finished
                if (distance < 0) {
                    clearInterval(timer);
                    countdownElement.innerHTML = "CLOSED";
                }
            }, 1000);
        }
        function openCountDown(productId, openTime) {
            const countdownElement = document.getElementById(`countdown-${productId}`);
            const openDate = new Date(openTime).getTime();

            // Update the countdown every 1 second
            const timer = setInterval(function () {
                const now = new Date().getTime();
                const distance = openDate - now;

                // Time calculations for days, hours, minutes, and seconds
                const days = Math.floor(distance / (1000 * 60 * 60 * 24));
                const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((distance % (1000 * 60)) / 1000);

                // Display the result
                countdownElement.innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s ";

                // If the countdown is finished
                if (distance < 0) {
                    clearInterval(timer);
                    countdownElement.innerHTML = "OPEN";
                }
            }, 1000);
        }

        // On page load, initialize the countdowns for each product
        window.onload = function () {
            const openProducts = document.querySelectorAll("[id^='opens-']");

            openProducts.forEach(function (product) {
                const productId = product.id.split('-')[1]; // Extract product ID from the element ID
                const openTime = product.value; // Get expiry time
                startCountdown(productId, openTime);
            });

            // Get all hidden input elements that store expiry times
            const products = document.querySelectorAll("[id^='expiry-']");

            products.forEach(function (product) {
                const productId = product.id.split('-')[1]; // Extract product ID from the element ID
                const expiryTime = product.value; // Get expiry time
                startCountdown(productId, expiryTime);
            });
        };
</script>

</asp:Content>
