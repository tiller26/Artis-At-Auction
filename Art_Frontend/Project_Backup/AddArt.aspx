<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddArt.aspx.cs" Inherits="Project_Backup.AddArt" %>

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
                            <h2>Artwork Details</h2>
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
                                            <h4>Tell us more about your artwork</h4>
                                        </div>
                                        <div>
                                            <div class="row mb-5">
                                                <h6>What is the name of your artwork?</h6>
                                                <input runat="server" id="pName" type="text" placeholder="e.g Crying Monalisa" />
                                            </div>
                                            <div class="row mb-5">
                                                <h6>Give a detailed description of your artwork. (What makes it special?)</h6>
                                                <textarea runat="server" id="pDescription" rows="8"></textarea>
                                            </div>
                                                <div class="row mb-5">
                                                    <h6>What is the price? (If bid is below, then no sale is made)</h6>
                                                    <input runat="server" id="pPrice" type="number" placeholder="e.g R 350" />
                                                </div>
                                            <div class="row mb-5">
                                                <h6>Select clear images of your artwork</h6>
                                                <input runat="server" id="sImages" type="file" multiple />
                                            </div>
                                            <div runat="server" id="extraDetails">
                                                <%-- Additional info for a category goes here --%>
                                                <div class="row mb-5">
                                                    <h6>What type of artwork is it?</h6>
                                                    <input runat="server" id="pType" type="text" placeholder="e.g Paiting" />
                                                </div>
                                                <div class="row mb-5">
                                                    <h6>What is the approxiate weight of the artwork? (grams)</h6>
                                                    <input runat="server" id="pWeight" type="number" placeholder="e.g 2500 g" />
                                                </div>
                                                <div class="row">
                                                    <h6>What are dimensions? (L x W x H)</h6>
                                                    <input runat="server" id="pDimensions" type="text" placeholder="e.g 40x50 m" />
                                                </div>
                                            </div>
                                            <div class="form-button">
                                                <button runat="server" onserverclick="AddItem" style="width: 55%; cursor: pointer" type="submit" class="template-btn2 on1">Add Item <span>&#8640;</span></button>
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
