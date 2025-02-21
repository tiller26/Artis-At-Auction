 <%@ Page Title="" EnableEventValidation="false" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Project_Backup.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Banner Starts -->
    <section class="home-2-banner">
        <div class="home-2-slider">
            <div class="single-slide single-slide-image2">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-5">
                            <div class="slider-left">
                                <h1>Know
                                    <br>
                                    Thy Self</h1>
                                <h4>enter the world of true artistry</h4>
                                <div class="home-2-button mt-70">
                                    <a href="Shop.aspx" class="template-btn2">Explore Collection <span>&rharu;</span></a>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 offset-lg-1">
                            <div class="slider-right d-md-flex">
                                <div class="single-image single-image-1 mr-5">
                                    <div class="image-bg image-3"></div>
                                    <div class="hover-state">
                                        <h5><a href="Shop.aspx">Shop for Art</a></h5>
                                        <a href="Shop.aspx">Explore Collection <span>&rharu;</span></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Banner End -->

    <!-- Collection Starts -->
    <section class="collection-area section-padding-both2">
        <!--floating-icon-->
        <div class="container">
            <div class="row">
                <div class="col-lg-7 align-self-center">
                    <div class="collection-content">
                        <div class="section-title">
                            <h2 class="collection-h2">Timeless Artwork
                                <br>
                                At Auction</h2>
                        </div>
                        <p>Welcome to our platform, where your art takes center stage. We are dedicated to showcasing and celebrating your creativity, offering a space where your work can truly shine. Here, your art reaches those who value it, and our unique bidding system ensures that buyers can pay what they feel your work is worth, making every transaction a fair exchange. Whether you're here to explore inspiring creations or to find the perfect piece to add to your collection, our site empowers you to engage with art in a way that is both rewarding and accessible. Get ready to bid, pay, and receive your chosen artwork whenever you're ready—because we believe in making art available to everyone, anytime.</p>
                        <div class="btn-margin-top">
                            <a href="Shop.aspx" class="template-btn2">Explore Collection <span>&rharu;</span></a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 offset-lg-1 fadeInRight">
                    <div class="collection-image">
                        <div class="collection-bg"></div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Collection End -->

    <!-- Categories Starts -->
    <section class="categories-area mb-5">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-7 mx-auto">
                    <div class="section-title text-center">
                        <h2>Categories</h2>
                    </div>
                    <div class="categories-item d-lg-flex justify-content-end">
                        <div class="single-item active fadeIn mb-5 mb-lg-0" data-wow-duration=".8s" data-wow-delay=".2s">
                            <div class="item-image cat-1">
                            </div>
                            <div class="item-content">
                                <h5><a href="Shop.aspx?id=art">Shop for Art</a></h5>
                                <a href="Shop.aspx?id=art">Explore Collection </a>
                            </div>
                        </div>
                        <div class="single-item fadeIn" data-wow-duration=".8s" data-wow-delay=".4s">
                            <div class="item-image cat-2">
                            </div>
                            <div class="item-content">
                                <h5><a href="Shop.aspx?id=accessories">Shop for Accessories</a></h5>
                                <a href="Shop.aspx?id=accessories">Live in your pockets</a>
                            </div>
                        </div>
                        <div class="single-item fadeIn" data-wow-duration=".8s" data-wow-delay=".6s">
                            <div class="item-image cat-3">
                            </div>
                            <div class="item-content">
                                <h5><a href="Shop.aspx?id=clothing">Shop for Clothing</a></h5>
                                <a href="Shop.aspx?id=clothing">Must haves for this summer</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Categories End -->

    <!-- Video Starts -->
    <section class="video-area section-padding-both">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 offset-lg-8">
                    <div class="video-content">
                        <div class="section-title">
                            <h2>Start Career As
                                <br>
                                An Artisan</h2>
                        </div>
                        <p>Join our platform and unlock a world of opportunity for your art. Here, selling your work is not just about making a transaction—it's about connecting with a passionate community that values your creativity. Our bidding system ensures that you get the best possible price, allowing buyers to compete for the art they love. </p>
                        <a runat="server" href="SellerRegistration.aspx" onserverclick="SellOnSite" class="template-btn3">Sell On Our Site <span>&#8640;</span></a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Video End -->

    <%--<!-- Picks Starts -->
    <section class="picks-area section-padding-both">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title text-center">
                        <h2>Our Picks For You</h2>
                    </div>
                </div>
            </div>

            <!-- Top Tabs Start -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="tab-accordion picks-tab text-center">
                        <div class="tab">
                            <ul>
                                <li class="tab-one active">New Arrivals</li>
                                <li class="tab-second">active bids</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Top Tabs End -->

            <!-- New Arrivals Tab -->
            <div class="tab-content">
                <div class="tab-one-content lost active">
                    <div runat="server" id="newArrivals" class="row">
                        <!-- Item 1 Goes Here -->
                        
                        <!-- Item 1 End -->
                    </div>
                </div>

                <!-- Active Bids Tab -->
                <div class="tab-second-content lost">
                    <div class="row">
                        <div class="col-lg-3 col-md-6">
                            <div class="single-cart-item">
                                <div class="single-cart-image">
                                    <img class="image-item-01 item-active" src="assets/img/home-1/pick/pick-4.png" alt="">
                                    <img class="image-item-02" src="assets/img/shop-page/item7.png" alt="">
                                    <div class="image-dots">
                                        <div class="dot-01"></div>
                                        <div class="dot-02 active"></div>
                                    </div>
                                </div>
                                <span class="love-icon"><i class="fa fa-heart"></i></span>

                                <div class="single-cart-content">
                                    <div class="cart-content-left">
                                        <ul class="cart-rating">
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li class="diff-color"><i class="fa fa-star"></i></li>
                                        </ul>
                                        <h5>Belted Chino Trousers</h5>
                                        <ul class="cart-size">
                                            <li><span>xs</span></li>
                                            <li class="active"><span>s</span></li>
                                            <li><span>m</span></li>
                                            <li><span>l</span></li>
                                            <li><span>xl</span></li>
                                        </ul>
                                    </div>

                                    <div class="cart-content-right">
                                        <span class="current-price">$45.99</span>
                                        <span class="old-price">$99.10</span>
                                    </div>
                                </div>

                                <div class="single-cart-button">
                                    <a href="#" class="cart-button floating-icon-1">add to cart</a>
                                    <a href="#" class="compare-button">compare</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6">
                            <div class="single-cart-item">
                                <div class="single-cart-image">
                                    <img class="image-item-01 item-active" src="assets/img/home-1/pick/pick-2.jpg" alt="">
                                    <img class="image-item-02" src="assets/img/shop-page/item7.png" alt="">
                                    <div class="image-dots">
                                        <div class="dot-01"></div>
                                        <div class="dot-02 active"></div>
                                    </div>
                                </div>
                                <span class="love-icon"><i class="fa fa-heart"></i></span>

                                <div class="single-cart-content">
                                    <div class="cart-content-left">
                                        <ul class="cart-rating">
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li class="diff-color"><i class="fa fa-star"></i></li>
                                        </ul>
                                        <h5>Belted Chino Trousers</h5>
                                        <ul class="cart-size">
                                            <li><span>xs</span></li>
                                            <li class="active"><span>s</span></li>
                                            <li><span>m</span></li>
                                            <li><span>l</span></li>
                                            <li><span>xl</span></li>
                                        </ul>
                                    </div>

                                    <div class="cart-content-right">
                                        <span class="current-price">$45.99</span>
                                        <span class="old-price">$99.10</span>
                                    </div>
                                </div>

                                <div class="single-cart-button">
                                    <a href="#" class="cart-button floating-icon-1">add to cart</a>
                                    <a href="#" class="compare-button">compare</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6">
                            <div class="single-cart-item">
                                <div class="single-cart-image">
                                    <img class="image-item-01 item-active" src="assets/img/home-1/pick/pick-3.jpg" alt="">
                                    <img class="image-item-02" src="assets/img/shop-page/item7.png" alt="">
                                    <div class="image-dots">
                                        <div class="dot-01"></div>
                                        <div class="dot-02 active"></div>
                                    </div>
                                </div>
                                <span class="love-icon"><i class="fa fa-heart"></i></span>

                                <div class="single-cart-content">
                                    <div class="cart-content-left">
                                        <ul class="cart-rating">
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li class="diff-color"><i class="fa fa-star"></i></li>
                                        </ul>
                                        <h5>Belted Chino Trousers</h5>
                                        <ul class="cart-size">
                                            <li><span>xs</span></li>
                                            <li class="active"><span>s</span></li>
                                            <li><span>m</span></li>
                                            <li><span>l</span></li>
                                            <li><span>xl</span></li>
                                        </ul>
                                    </div>

                                    <div class="cart-content-right">
                                        <span class="current-price">$45.99</span>
                                        <span class="old-price">$99.10</span>
                                    </div>
                                </div>

                                <div class="single-cart-button">
                                    <a href="#" class="cart-button floating-icon-1">add to cart</a>
                                    <a href="#" class="compare-button">compare</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tab-three-content lost">
                    <div class="row">
                        <div class="col-lg-3 col-md-6">
                            <div class="single-cart-item">
                                <div class="single-cart-image">
                                    <img class="image-item-01 item-active" src="assets/img/home-1/pick/pick-2.jpg" alt="">
                                    <img class="image-item-02" src="assets/img/shop-page/item7.png" alt="">
                                    <div class="image-dots">
                                        <div class="dot-01"></div>
                                        <div class="dot-02 active"></div>
                                    </div>
                                </div>
                                <span class="love-icon"><i class="fa fa-heart"></i></span>

                                <div class="single-cart-content">
                                    <div class="cart-content-left">
                                        <ul class="cart-rating">
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li class="diff-color"><i class="fa fa-star"></i></li>
                                        </ul>
                                        <h5>Belted Chino Trousers</h5>
                                        <ul class="cart-size">
                                            <li><span>xs</span></li>
                                            <li class="active"><span>s</span></li>
                                            <li><span>m</span></li>
                                            <li><span>l</span></li>
                                            <li><span>xl</span></li>
                                        </ul>
                                    </div>

                                    <div class="cart-content-right">
                                        <span class="current-price">$45.99</span>
                                        <span class="old-price">$99.10</span>
                                    </div>
                                </div>

                                <div class="single-cart-button">
                                    <a href="#" class="cart-button floating-icon-1">add to cart</a>
                                    <a href="#" class="compare-button">compare</a>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-6">
                            <div class="single-cart-item">
                                <div class="single-cart-image">
                                    <img class="image-item-01 item-active" src="assets/img/home-1/pick/pick-1.png" alt="">
                                    <img class="image-item-02" src="assets/img/shop-page/item7.png" alt="">
                                    <div class="image-dots">
                                        <div class="dot-01"></div>
                                        <div class="dot-02 active"></div>
                                    </div>
                                </div>
                                <span class="love-icon"><i class="fa fa-heart"></i></span>

                                <div class="single-cart-content">
                                    <div class="cart-content-left">
                                        <ul class="cart-rating">
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li class="diff-color"><i class="fa fa-star"></i></li>
                                        </ul>
                                        <h5>Belted Chino Trousers</h5>
                                        <ul class="cart-size">
                                            <li><span>xs</span></li>
                                            <li class="active"><span>s</span></li>
                                            <li><span>m</span></li>
                                            <li><span>l</span></li>
                                            <li><span>xl</span></li>
                                        </ul>
                                    </div>

                                    <div class="cart-content-right">
                                        <span class="current-price">$45.99</span>
                                        <span class="old-price">$99.10</span>
                                    </div>
                                </div>

                                <div class="single-cart-button">
                                    <a href="#" class="cart-button floating-icon-1">add to cart</a>
                                    <a href="#" class="compare-button">compare</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="text-center">
                <a href="Shop.aspx" class="template-btn2">view items <span>&rharu;</span></a>
            </div>
        </div>
    </section>
    <!-- Picks End -->--%>

    <!-- Services Starts -->
    <section class="services-area section-padding-both3 mb-5">
        <div class="container">
            <h2 class="mb-5">Our Services</h2>
            <div class="row">
                <div class="col-lg-3 col-md-6  fadeIn" data-wow-duration=".8s" data-wow-delay=".2s">
                    <div class="single-item mb-5 mb-lg-0">
                        <img src="assets/img/home-1/service/item-1.png" alt="">
                        <h5 class="my-4">Free Local Shipping</h5>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6  fadeIn" data-wow-duration=".8s" data-wow-delay=".4s">
                    <div class="single-item mb-5 mb-lg-0">
                        <img src="assets/img/home-1/service/item-2.png" alt="">
                        <h5 class="my-4">Customer Care</h5>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6  fadeIn" data-wow-duration=".8s" data-wow-delay=".6s">
                    <div class="single-item">
                        <img src="assets/img/home-1/service/item-3.png" alt="">
                        <h5 class="my-4">Secured Payment</h5>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6  fadeIn" data-wow-duration=".8s" data-wow-delay=".8s">
                    <div class="single-item">
                        <img src="assets/img/home-1/service/item-4.png" alt="">
                        <h5 class="my-4">24/7 Support</h5>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Services End -->

   

    <!-- Newsletter Starts -->
    <section class="newsletter-area section-padding-both">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="section-title">
                        <h2>subscribe to our newsletter</h2>
                    </div>
                    <p>Receive 10% off on your first order and be among the first to receive our exclusive emails about discounts and new arrivals.</p>
                    <form action="#">
                        <input type="email" class="common-input" placeholder="Enter Your Email Address Here" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Enter Your Email Address Here'">
                        <button type="submit"><span>&rharu;</span></button>
                    </form>
                </div>
            </div>
        </div>
    </section>
    <!-- Newsletter End -->
</asp:Content>
