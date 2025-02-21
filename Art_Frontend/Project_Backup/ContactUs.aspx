<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="Project_Backup.ContactUs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Contact Form Starts -->
<div class="contact-us-page common-typography">

 
<section class="contact-form-area common-form common-input2">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="contact-title section-padding-top2">
                    <h2>Contact us</h2>
                    <h3>Hello. Let’s get in touch</h3>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-7">
                <div class="contact-bg">
                      <div class="contact-address">
                    <div action="#">
                        <h6>Full Name</h6>
                        <input type="text" placeholder="Enter your Full Name">

                        <h6>Email Address</h6>
                        <input type="email" placeholder="Enter your Email Address">

                        <h6>Reason For Contact</h6>
                        <input type="text" id="reason" placeholder="Enter Reason">

                        <h6>Message</h6>
                        <textarea cols="50" rows="12"></textarea>

                        <div>
                             <button type="submit" class="template-btn2 off1">Send Your Message <span>&rharu;</span></button>
                        </div>
                       
                    </div>
                     </div>
                </div>
            </div>
            <div class="col-xl-4 offset-xl-1 col-lg-5">
                <div class="contact-bg">
                    <div class="contact-address">
                        <div class="single-part">
                            <h6>In The Mother City?</h6>
                            <p>Cape Town,<br> 89 Balencia Street<br> South Africa</p>
                        </div>

                        <div class="single-part mt-70">
                            <h6>Office  Hours</h6>
                            <p>Monday - Saturday<br> 10 am - 4 pm<br> Sunday<br> 10 am - 1pm</p>
                        </div>
                        
                        <div class="single-part mt-70">
                            <h6>Support?</h6>
                            <p>artisatauction@support.com<br> +27 11 336 2579</p>
                        </div>
                        <div class="single-part-img mt-70">

                            <img src=https://i.pinimg.com/originals/01/7e/83/017e83563e3e90d8f0a61cda7cac4428.jpg alt="">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
 </div>
</asp:Content>
