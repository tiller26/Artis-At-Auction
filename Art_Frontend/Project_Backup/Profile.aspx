<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Project_Backup.Profile" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>https://www.chartjs.org/docs/latest/samples/other-charts/pie.html</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="profile-page common-typography">
        <!-- Banner Starts -->
        <div class="profile-banner">
        </div>
        <!-- Banner End -->

        <!-- Profile Area Starts -->
        <section class="profile-area">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="profile-image">
                            <div runat="server" id="uImage" class="image"></div>
                            <div class="name mt-2">
                                <h4><span runat="server" id="uName">User Name</span></h4>
                                <h3 class="mt-5">Balance: <span runat="server" id="balance">Balance</span></h3>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <div class="profile-title">
                            <h2>My Account</h2>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-2 pr-0">
                        <div class="profile-tab">
                            <div class="tab-accordion">
                                <div class="tab">
                                    <ul>
                                        <li class="tab-one active">
                                            <h6><i class="fa fa-user-o"></i>profile</h6>
                                        </li>
                                        <li runat="server" id="manageProds" visible="false" class="">
                                            <h6><a runat="server" id="linkToAbout"><i class="fa fa-edit"></i>manage products</a></h6>
                                        </li>
                                        <li class="tab-three">
                                            <h6><i class="fa fa-bookmark-o"></i>View Invoices</h6>
                                        </li>
                                        <li class=''>
                                            <h6><i class='fa fa-money'></i><a href='AddFunds.aspx'>Deposit</a></h6>
                                        </li>
                                        <li class='tab-four'>
                                            <h6><i class='fa fa-bell-o'></i>Notifications</h6>
                                        </li>
                                        <li runat="server" id="bidsTab" class='tab-six'>
                                            <h6><a href="ActiveBids.aspx"><i class='fa fa-clock-o'></i>Active Bids</a></h6>
                                        </li>
                                        <li runat="server" id="reportsTab" class='tab-second'>
                                            <h6><i class='fa fa-group'></i>Reports</h6>
                                        </li>
                                        <li class="tab-five">
                                            <h6><i class="fa fa-sign-out"></i><a href="Home.aspx" runat="server" onserverclick="Logout_OnClick">Log Out</a></h6>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- Profile Section --%>
                    <div class="col-lg-10 pl-0">
                        <div class="tab-content">
                            <div class="tab-one-content lost active">
                                <div class="contact-bg">
                                    <div class="form-border">
                                        <div class="form-title">
                                            <h4>Contact Information</h4>
                                        </div>
                                        <div>
                                            <h6>Email Address</h6>
                                            <input runat="server" id="uEmail" type="email" class="mb-4" disabled>

                                            <h6>Contact Number</h6>
                                            <input runat="server" id="uContact" type="text" class="mb-5" disabled>

                                            <div class="form-title">
                                                <h4>Edit Address Details</h4>
                                            </div>

                                            <h6>Street Address</h6>
                                            <input runat="server" id="uStreet" type="text" class="mb-4">

                                            <h6>City</h6>
                                            <input runat="server" id="uCity" type="text" class="mb-4">

                                            <h6>Province</h6>
                                            <input runat="server" id="uProvince" type="text">

                                            <div class="form-button">
                                                <button runat="server" onserverclick="SaveAddress_OnClick" type="submit" class="template-btn2 on1">Save Changes<span class="custom-icon"></span></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%-- Reports go here --%>
                            <div class="tab-second-content lost">
                                <div class="contact-bg4">
                                    <div class="form-border">

                                        <%-- STYLING HERE FOR WIDTH AND HEIGHT START --%>
                                        <div class="row">
                                           
                                            <div class="col-4">
                                                <a href="FinanceReports.aspx" class="template-btn2 on1" runat="server" > Financial Reports</a>
                                            </div>
                                            <div class="col-4">
                                                <a href="UserReports.aspx" class="template-btn2 on1" runat="server">User Reports</a>
                                            </div>
                                            <div class="col-4">
                                                <a href="ProductReports.aspx" class="template-btn2 on1" runat="server" >Product Reports</a>
                                            </div>
                                            
                                        </div>
                                     
                                        <div class="row mt-5" style="width: 330px; height: 330px; margin-bottom: 120px;" runat="server" id="percentage" visible="false">
                                            <div>
                                                <h6>Percentage of active and inactive products</h6>
                                            </div>

                                            <canvas id="AllPie"></canvas>
                                        </div>

                                        <div style="width: 900px; height: 900px; margin-top: 120px;" runat="server" id="users" visible="false">
                                            <div>
                                                <h6>Number of registered users per month </h6>
                                            </div>
                                            <canvas id="RegisterLine"></canvas>
                                        </div>

                                        <div style="width: 950px; height: 950px; margin-top: -330px;" runat="server" id="regusers" visible="false">
                                            <div>
                                                <h6>Number of registered users per province </h6>
                                            </div>
                                            <canvas id="ProvinceLine"></canvas>
                                        </div>

                                        <%-- DRAW CLOTHING --%>

                                        <div style="width: 300px; height: 300px; margin-top: -330px;" runat="server" id="clothing" visible="false">
                                            <div>
                                                <h6>Percentage of sold and unsold  Clothing Products </h6>
                                            </div>
                                            <canvas id="ClothingPie"></canvas>
                                        </div>

                                        <%-- DRAW ACCESSORIES --%>

                                        <div style="width: 300px; height: 300px; margin-top: 150px;" runat="server" id="accessories" visible="false">
                                            <div>
                                                <h6>Percentage of sold and unsold  Accessories Products </h6>
                                            </div>
                                            <canvas id="AccessoriesPie"></canvas>
                                        </div>

                                        <%-- DRAW ART --%>

                                        <div style="width: 300px; height: 300px; margin-top: 150px;" runat="server" id="products" visible="false">
                                            <div>
                                                <h6>Percentage of sold and unsold  Art Products </h6>
                                            </div>
                                            <canvas id="ArtPie"></canvas>
                                        </div>
                                        <%-- STYLING HERE FOR WIDTH AND HEIGHT END --%>
                                    </div>
                                </div>
                            </div>
                            <%-- Past Invoices Section --%>
                            <div class="tab-three-content lost">
                                <div class="contact-bg3">
                                    <div class="form-border">
                                        <div class="form-title">
                                            <h4>All Invoices</h4>
                                        </div>
                                        <div runat="server" id="InvoiceHtml" class="content-bottom  content-padding">
                                            <%-- Invoices show here --%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                             <%-- Active Bids Section --%>
                            <div class="tab-six-content lost">
                                <div class="contact-bg3">
                                    <div class="form-border">
                                        <div class="form-title">
                                            <h4>Active Bids</h4>
                                        </div>
                                        <div runat="server" id="activeBids" class="content-bottom  content-padding">
                                            <%-- Active Bids show here --%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%-- Notifications Section --%>
                            <div class="tab-four-content lost">
                                <div class="contact-bg3">
                                    <div class="form-border">
                                        <div class="form-title">
                                            <h4>Recent Activity</h4>
                                        </div>
                                        <div runat="server" id="notifications" class="content-bottom  content-padding">
                                            <%-- Notifications show here --%>
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
    <!-- Profile Area End -->
    <%-- GRAPHING MATERIAL HERE HERE WITH THE LIBRARY FOR CHART JS'S START --%>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>  

var activeCount = '<%= activeProductCount %>';
        var inactiveCount = '<%= inactiveProductCount %>';


        const data = {
            labels: ['Active', 'Inactive'],
            datasets: [{
                label: 'Product Status',
                data: [activeCount, inactiveCount],
                backgroundColor: ['#36A2EB', '#FF6384'],      //GO CRAZY ANY COLOR THAT SUITS
                hoverBackgroundColor: ['#36A2EB', '#FF6384'],
            }]
        };

        const config = {
            type: 'pie',
            data: data,
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function (tooltipItem) {
                                const value = tooltipItem.raw;
                                const total = parseInt(activeCount) + parseInt(inactiveCount);
                                const percentage = ((value / total) * 100).toFixed(2);
                                return `${value} (${percentage}%)`;
                            }
                        }
                    }
                }
            }
        };

        // Render the chart   
        const ctx = document.getElementById('AllPie').getContext('2d');
        new Chart(ctx, config);
    </script>


    <script>  
        //DEFINE VARIABLES HERE
        var monthLabels = [<%= monthLabels %>];
        var userCounts = [<%= userCounts %>];


        const Linedata = {
            labels: monthLabels,  //DISPLAY Months
            datasets: [{
                label: 'User Registrations',
                data: userCounts,  // NUMBER OF REGISTERS EACH MONTH
                fill: true,
                borderColor: '#36A2EB',          //https://www.fffuel.co/cccolor/ GO  THIS SITE TO CHOOSE YOUR COLORS
                tension: 0.1
            }]
        };

        const Lineconfig = {
            type: 'line',  //TYPE OF GRAPH YOU WANT
            data: Linedata,
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Number of Users'
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: 'Months'
                        }
                    }
                }
            }
        };

        // Render the chart
        const Linectx = document.getElementById('RegisterLine').getContext('2d');
        new Chart(Linectx, Lineconfig);
    </script>

    <%--province plot below--%>
    <script> 
        var provinceLabels = [<%= ProvinceLabels %>];
        var provincecounts = [<%= ProvinceCounts %>];

        const Provincedata = {
            labels: provinceLabels,  // Display Provinces
            datasets: [{
                label: 'User Count by Province',
                data: provincecounts,  // Number of users in each province
                fill: true,
                borderColor: '#FF6384',
                tension: 0.1
            }]
        };

        const ProvinceConfig = {
            type: 'line',
            data: Provincedata,
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Number of Users'
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: 'Provinces'
                        }
                    }
                }
            }
        };

        // Render the chart
        const Provincectx = document.getElementById('ProvinceLine').getContext('2d');
        new Chart(Provincectx, ProvinceConfig);
    </script>


    <%-- DRAW THAT CLOTHING PIE HERE BELOW START --%>
    <script>  
        var soldCount = '<%= soldProductCount %>';
        var unsoldCount = '<%= unsoldProductCount %>';

        const Clothingdata = {
            labels: ['Sold', 'Not Sold'],
            datasets: [{
                label: 'Art Product Sales Status',
                data: [soldCount, unsoldCount],
                backgroundColor: ['#4CAF50', '#FF9800'],  // You can change these colors as needed
                hoverBackgroundColor: ['#4CAF50', '#FF9800'],
            }]
        };

        const Clothingconfig = {
            type: 'pie',
            data: Clothingdata,
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function (tooltipItem) {
                                const value = tooltipItem.raw;
                                const total = parseInt(soldCount) + parseInt(unsoldCount);
                                const percentage = ((value / total) * 100).toFixed(2);
                                return `${value} (${percentage}%)`;
                            }
                        }
                    }
                }
            }
        };

        // Render the chart     
        const Piectx = document.getElementById('ClothingPie').getContext('2d');
        new Chart(Piectx, Clothingconfig);
    </script>


    <%-- DRAW THAT CLOTHING PIE HERE UP UP END --%>


    <%-- DRAW THAT ACCESORIES PIE HERE BELOW START --%>
    <script>  
        var soldCount = '<%= soldAccProductCount %>';
        var unsoldCount = '<%= unsoldAccProductCount %>';

        const Accessoriesdata = {
            labels: ['Sold', 'Not Sold'],
            datasets: [{
                label: 'Accessories Product Sales Status',
                data: [soldCount, unsoldCount],
                backgroundColor: ['#FFEE00', '#FF540A'],  // You can change these colors as needed
                hoverBackgroundColor: ['#FFEE00', '#FF540A'],
            }]
        };

        const Accessoriesconfig = {
            type: 'pie',
            data: Accessoriesdata,
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function (tooltipItem) {
                                const value = tooltipItem.raw;
                                const total = parseInt(soldCount) + parseInt(unsoldCount);
                                const percentage = ((value / total) * 100).toFixed(2);
                                return `${value} (${percentage}%)`;
                            }
                        }
                    }
                }
            }
        };

        // Render the chart     
        const AccessoriesPiectx = document.getElementById('AccessoriesPie').getContext('2d');
        new Chart(AccessoriesPiectx, Accessoriesconfig);
    </script>


    <%-- DRAW THAT ACCESSORIES PIE HERE UP UP END --%>

    <script>  
        var sales = '<%= sales %>';
        var registrations = '<%= registrations %>';


        const data = {
            labels: ['Sales', 'Registrations'],
            datasets: [{
                label: 'Revenue Stream',
                data: [sales, registrations],
                backgroundColor: ['#36A2EB', '#FF6384'],      //GO CRAZY ANY COLOR THAT SUITS
                hoverBackgroundColor: ['#36A2EB', '#FF6384'],
            }]
        };

        const config = {
            type: 'pie',
            data: data,
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function (tooltipItem) {
                                const value = tooltipItem.raw;
                                const total = parseFloat(sales) + parseFloat(registrations);
                                const percentage = ((value / total) * 100).toFixed(2);
                                return `${value} (${percentage}%)`;
                            }
                        }
                    }
                }
            }
        };

        // Render the chart   
        const ctx = document.getElementById('AllPie').getContext('2d');
        new Chart(ctx, config);
    </script>


    <%-- DRAW THAT ART PIE HERE BELOW START --%>
    <script>  
        var soldCount = '<%= soldArtProductCount %>';
        var unsoldCount = '<%= unsoldArtProductCount %>';

        const Artdata = {
            labels: ['Sold', 'Not Sold'],
            datasets: [{
                label: 'Clothing Product Sales Status',
                data: [soldCount, unsoldCount],
                backgroundColor: ['#0F0AFF', '#B4B3FF'],  // You can change these colors as needed
                hoverBackgroundColor: ['#0F0AFF', '#B4B3FF'],
            }]
        };

        const Artconfig = {
            type: 'pie',
            data: Artdata,
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function (tooltipItem) {
                                const value = tooltipItem.raw;
                                const total = parseInt(soldCount) + parseInt(unsoldCount);
                                const percentage = ((value / total) * 100).toFixed(2);
                                return `${value} (${percentage}%)`;
                            }
                        }
                    }
                }
            }
        };

        // Render the chart     
        const ArtPiectx = document.getElementById('ArtPie').getContext('2d');
        new Chart(ArtPiectx, Artconfig);
    </script>


    <%-- DRAW THAT CLOTHING PIE HERE UP UP END --%>
    <%-- GRAPHING MATERIAL HERE HERE WITH THE LIBRARY FOR CHART JS'S END --%>
</asp:Content>
    