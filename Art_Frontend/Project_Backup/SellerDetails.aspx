<%@ Page EnableEventValidation="false" Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SellerDetails.aspx.cs" Inherits="Project_Backup.Seller" %>

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
                        <div runat="server" id="sellerSide" class="shop-sidebar">

                            <!-- The Seller goeas here -->

                        </div>
                    </div>
                    <!-- Side Bar Ends -->

                    <div class="col-lg-9">
                        <div runat="server" id="nameSeller" class="col-lg-12">
                            <!-- The name of the artist goes here -->
                        </div>
                        <a runat="server" id="addItem" visible="false" href="AddProduct.aspx" class="btn template-btn2 pr-4"><i class="fa fa-plus-circle"></i> Add Item</a>
                        <%--<div class="shop-items-top d-flex justify-content-between">
                            <div class="left"><span runat="server" id="totalItems"></span></div>
                            <div class="dropdown">
                                <button runat="server" class="drop-btn dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Sort by
                       
                                </button>
                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                    <a class="dropdown-item" href="#">Title</a>
                                    <a class="dropdown-item" href="#">Price</a>
                                    <a class="dropdown-item" href="#">Highest Selling</a>
                                </div>
                            </div>
                        </div>--%>

                        <div class="shop-items">
                            <div runat="server" id="productItem" class="row mt-5">
                                <!-- Item goes here -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Shop Content End -->
        <span id="HiddenFieldTargetTime" runat="server" hidden></span>
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
