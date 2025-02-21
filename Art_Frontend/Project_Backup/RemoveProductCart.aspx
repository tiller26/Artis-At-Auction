<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RemoveProductCart.aspx.cs" Inherits="Project_Backup.RemoveProductCart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="profile-page common-typography mt-5">
        <section class="profile-area pt-5">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="profile-title">
                            <h2>About to Remove Product From Cart</h2>
                        </div>
                    </div>
                    <div class="col-lg-8 mx-auto">
                        <div class="tab-content">
                            <div class="tab-one-content lost active">
                                <div class="contact-bg">
                                    <div class="form-border">
                                        <div class="form-title">
                                            <h4>Remove Product</h4>
                                        </div>
                                        <section runat="server" id="removeproduct">
                                            <div class='row mb-5'>
                                                <h5>You are about to cancel the product you won in a bid. You will be charged <span runat="server" id="amount"></span>, 
                        30 % of the item.</h5>
                                            </div>
                                            <a runat='server' class='template-btn2 on1' onserverclick='Remove'>Remove</a>
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
