<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddFunds.aspx.cs" Inherits="Project_Backup.AddFunds" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        // Form validation and basic client-side security
        const paymentForm = document.getElementById('payment-form');
        paymentForm.addEventListener('submit', function (event) {
            event.preventDefault();  // Prevent default form submission

            const cardNumber = document.getElementById('card-number').value;
            const expiryDate = document.getElementById('expiry-date').value;
            const cvc = document.getElementById('cvc').value;

            // Add basic validation (can be expanded as needed)
            if (!validateCardNumber(cardNumber)) {
                alert('Invalid card number');
                return;
            }

            alert('Payment submitted!');
            // In real-world scenarios, submit the data to the server or payment gateway securely.
        });

        // Example basic card validation
        function validateCardNumber(number) {
            // Strip spaces from the card number
            const cleaned = number.replace(/\s+/g, '');
            return /^[0-9]{16}$/.test(cleaned);  // Simple validation for 16-digit card numbers
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="profile-page common-typography mt-5">
        <section class="profile-area pt-5">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="profile-title">
                            <h2>Enter Payment Details</h2>
                        </div>
                    </div>
                    <div class="col-lg-8 mx-auto">
                        <div class="tab-content">
                            <div class="tab-one-content lost active">
                                <div class="contact-bg">
                                    <div class="form-border">
                                        <div class="form-title">
                                            <h4>Payment Details</h4>
                                        </div>
                                        <section id="payment-form">
                                            <h6>Payment Information</h6>

                                            <div class="row mb-5">
                                                <label for="card-name">Cardholder Name</label>
                                                <input type="text" id="card-name" name="card-name" placeholder="Name on card" required>
                                            </div>

                                            <div class="row mb-5">
                                                <label for="card-number">Card Number</label>
                                                <input type="text" id="card-number" name="card-number" placeholder="1234 5678 9101 1121" maxlength="19" required>
                                            </div>

                                            <div class="row mb-5">
                                                <label for="expiry-date">Expiry Date</label>
                                                <input type="text" id="expiry-date" name="expiry-date" placeholder="MM/YY" maxlength="5" required>
                                            </div>

                                            <div class="row mb-5">
                                                <label for="cvc">CVC/CVV</label>
                                                <input type="text" id="cvc" name="cvc" placeholder="123" maxlength="3" required>
                                            </div>


                                            <div class="row mb-5">
                                                <label for="cvc">Amount</label>
                                                <input runat="server" type="text" id="payola" name="cvc" placeholder="500" maxlength="7" required>
                                            </div>


                                            <a runat="server" class="template-btn2 on1" onserverclick="Pay">Submit Payment</a>

                                        </section>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</asp:Content>
