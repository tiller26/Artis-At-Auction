<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DeleteProduct.aspx.cs" Inherits="Project_Backup.DeleteProduct" %>
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
                            <h2>Delete Item Permanently</h2>
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
                                            <h5 runat="server" class="text-danger mb-5" id="prompt"></h5>
                                            <h4 runat="server" id="name"></h4>
                                        </div>
                                        <div>
                                            <div class="form-button">
                                                <button runat="server" onserverclick="Back" type="submit" class=" btn template-btn2">Go Back</button>
                                                <button runat="server" onserverclick="Delete" type="submit" class="btn template-btn btn-danger">Delete Permanently</button>
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
</asp:Content>
