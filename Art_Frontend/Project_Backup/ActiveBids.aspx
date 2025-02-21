<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ActiveBids.aspx.cs" Inherits="Project_Backup.ActiveBids" %>

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
                        <h2>bids you are currently in</h2>
                    </div>
                </div>
            </div>
            <div runat="server" id="adsellers" class="gallery-slider owl-carousel">
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
