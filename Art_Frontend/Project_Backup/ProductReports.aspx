<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductReports.aspx.cs" Inherits="Project_Backup.ProductReports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div class="profile-page common-typography mt-5">
        <!-- Profile Area Starts -->
        <section class="profile-area pt-5">
            <div class="container">
                <div class="row">
                    <div class="col-lg-10 mx-auto">
                        <div class="tab-content">
                            <div class="tab-one-content lost active">
                                <div class="contact-bg">
                                    <div class="form-border">
                                        <%-- Reports start here --%>
                                       <%-- DRAW CLOTHING --%>
                                        <div class="form-title mb-5">
                                            <h4>Product Reports</h4>
                                        </div>
                                        <div style="width: 300px; height: 300px; margin-top: 50px;" runat="server" id="clothing">
                                            <div>
                                                <h6>Percentage of sold and unsold  Clothing Products </h6>
                                            </div>
                                            <canvas id="ClothingPie"></canvas>
                                        </div>

                                        <%-- DRAW ACCESSORIES --%>

                                        <div style="width: 300px; height: 300px; margin-top: 150px;" runat="server" id="accessories" >
                                            <div>
                                                <h6>Percentage of sold and unsold  Accessories Products </h6>
                                            </div>
                                            <canvas id="AccessoriesPie"></canvas>
                                        </div>

                                        <%-- DRAW ART --%>

                                        <div style="width: 300px; height: 300px; margin-top: 150px;" runat="server" id="products" >
                                            <div>
                                                <h6>Percentage of sold and unsold  Art Products </h6>
                                            </div>
                                            <canvas id="ArtPie"></canvas>
                                        </div>
                                        <%-- STYLING HERE FOR WIDTH AND HEIGHT END --%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
           
         </section>
    </div>

      <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


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

    <%--<script>  
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
    </script>--%>


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

</asp:Content>
