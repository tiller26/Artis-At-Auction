 <%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="PlaceBid.aspx.cs" Inherits="Project_Backup.PlaceBid" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="profile-page common-typography mt-5">

        <!-- Profile Area Starts -->
        <section class="profile-area pt-5">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="profile-title">
                            <h2>place your bid</h2>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-8 mx-auto">
                        <div class="tab-content">
                            <div class="tab-one-content lost active">
                                <div class="contact-bg">
                                    <div class="form-border">
                                        <div class="form-title">
                                            <h4 runat="server" id="price">Reserve Price: R 500</h4>
                                        </div>
                                        <div>
                                            <div class="row mb-5">
                                                <h6>Enter Bid Amount (Min. <span runat="server" id="min"></span>)</h6>
                                                <input runat="server" id="bidAmount" type="number" />
                                            </div>
                                            <div runat="server" id="bidCountdown" class="row">
                                                <h6 id='countdown' style='color: red;'>Time Left</h6>
                                            </div>
                                            <div class="form-button">
                                                <button runat="server" id="placeBid" onserverclick="PlaceBid_Click" style="width: 45%; cursor: pointer" type="submit" class="template-btn2 on1">Place Bid<span>&#8640;</span></button>
                                                <a href="Shop.aspx" style="width: 45%; cursor: pointer" class="template-btn2 on2">Go Back<span>&#8640;</span></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <span id="HiddenFieldTargetTime" runat="server" hidden></span>
    <script type="text/javascript">
        // Function to start the countdown
        function startCountdown(targetTime) {
            var countdownElement = document.getElementById("countdown");

            // Update the countdown every 1 second
            var countdownInterval = setInterval(function () {
                // Get the current time
                var now = new Date().getTime();

                // Calculate the distance between now and the target time
                var distance = targetTime - now;

                // Time calculations for days, hours, minutes, and seconds
                var days = Math.floor(distance / (1000 * 60 * 60 * 24));
                var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                var seconds = Math.floor((distance % (1000 * 60)) / 1000);

                // Display the result in the countdown element
                countdownElement.innerHTML = "Remaining: " + days + "d " + hours + "h " + minutes + "m " + seconds + "s " + " left";

                // If the countdown is finished, display "EXPIRED"
                if (distance < 0) {
                    clearInterval(countdownInterval);
                    countdownElement.innerHTML = "SOLD!";
                    //window.location.href = "EndBid.aspx?";
                }
            }, 1000);
        }

        // Get the target time from the hidden field and start the countdown
        window.onload = function () {
            var targetTime = document.getElementById('<%= HiddenFieldTargetTime.ClientID %>').innerText;
            startCountdown(parseInt(targetTime));
        };
    </script>
</asp:Content>
