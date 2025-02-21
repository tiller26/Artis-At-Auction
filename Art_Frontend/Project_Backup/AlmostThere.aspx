<%@ Page Title="" EnableEventValidation="false" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AlmostThere.aspx.cs" Inherits="Project_Backup.AlmostThere" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Banner Starts -->
    <div class="coming-soon-page common-typography">
        <div class="coming-soon-banner text-center">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <ul class=" mt-70 mb-70">
                            <li>
                                <span class="days">00</span>
                                <p class="days_ref">days</p>
                            </li>
                            <li class="seperator">:</li>
                            <li>
                                <span class="hours">00</span>
                                <p class="hours_ref">hours</p>
                            </li>
                            <li class="seperator">:</li>
                            <li>
                                <span class="minutes">00</span>
                                <p class="minutes_ref">minutes</p>
                            </li>
                            <li class="seperator">:</li>
                            <li>
                                <span class="seconds">00</span>
                                <p class="seconds_ref">seconds</p>
                            </li>
                        </ul>
                    </div>

                    <div class="coming-soon-button">
                        <a href="Home.aspx" class="template-btn2 off1">Go Home <span>&rharu;</span></a>
                        <a href="Shop.aspx" class="template-btn2">Go Back <span>&rharu;</span></a>
                    </div>
                </div>
            </div>
        </div>
        <input runat="server" id="hidden" type="text" value="" hidden />
    </div>
    <!-- Banner End -->
    <script type="text/javascript">
        function startCountdown(openTime) {
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

                // Find elements and update their content
                document.querySelector('.days').innerHTML = days;
                document.querySelector('.hours').innerHTML = hours;
                document.querySelector('.minutes').innerHTML = minutes;
                document.querySelector('.seconds').innerHTML = seconds;

                // If the countdown is finished
                if (distance < 0) {
                    clearInterval(timer);
                    document.querySelector('.days').innerHTML = "0";
                    document.querySelector('.hours').innerHTML = "0";
                    document.querySelector('.minutes').innerHTML = "0";
                    document.querySelector('.seconds').innerHTML = "0";
                    document.querySelector('.seconds_ref').innerHTML = "SOLD";
                }
            }, 1000);
        }

        // On page load, initialize the countdowns for each product
        window.onload = function () {
            const hiddenElement = document.getElementById("hidden");
            const openTime = hiddenElement.value;
            startCountdown(openTime);
        };
</script>
</asp:Content>
