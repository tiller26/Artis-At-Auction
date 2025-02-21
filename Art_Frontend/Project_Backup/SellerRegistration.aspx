<%@ Page Title="Seller Registration" EnableEventValidation="false" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SellerRegistration.aspx.cs" Inherits="Project_Backup.SellerRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function checkCheckboxBeforeSubmit() {
            var checkbox = document.getElementById("acc-or");
            if (!checkbox.checked) {
                alert("You must check the 'Create an account?' box.");
                return false;  // Prevents form submission if not checked
            }
            return true;  // Proceeds with form submission if checked
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
                            <h2>Register As Seller</h2>
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
                                            <h4>Give us more details</h4>
                                        </div>

                                        <div class="row mb-5">
                                            <h6>Give a description of yourself and your artwork</h6>
                                            <textarea runat="server" id="sDescription" rows="8"></textarea>
                                        </div>
                                        <div class="row mb-5">
                                            <h6>Give us the name of your business</h6>
                                            <input runat="server" id="sBusiness" type="text" placeholder="e.g Fashion Corp" />
                                        </div>
                                        <div class="row">
                                            <h6>Select a profile image</h6>
                                            <input runat="server" id="sImage" type="file" placeholder="e.g Fashion Corp" />
                                        </div>
                                        <div class="row mb-5"></div>

                                        <div class="row mb-5">
                                            <div class="checkout__order">
                                                <h4>Registration Fee</h4>
                                                <div class="checkout__order__products">Products <span>Total</span></div>
                                                <ul>
                                                    <li><h6>Fee<span>R500.00</span></h6></li>
                                                </ul>
                                                <div class="checkout__order__subtotal">Subtotal <span>R500.00</span></div>
                                                <div class="checkout__order__total">Total <span>R500.00</span></div>
                                                <div class="checkout__input__checkbox">
                                                    <label for="acc-or" style="white-space: nowrap;">
                                                        <input type="checkbox" id="acc-or" />
                                                        Create an account?
                                                        <span class="checkmark"></span>
                                                    </label>
                                                </div>
                                                <h6>By agreeing to create an account you are allowing to pay the registration fee.</h6>
                                            </div>
                                        </div>
                                        <div class="form-button">
                                            <button runat="server" onserverclick="AddSeller"  type="submit" style="width:55%; cursor:pointer" class="template-btn2 on1">
                                                Register<span>&#8640;</span>
                                            </button>
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
    </asp:Content>
