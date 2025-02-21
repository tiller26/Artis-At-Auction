<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserReports.aspx.cs" Inherits="Project_Backup.UserReports" %>
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
                                        <div class="form-title">
                                            <h4>User Reports</h4>
                                        </div>
                                        <%-- Reports start here --%>
                                        <div style="width: 900px; height: 900px; margin-top: 120px;" runat="server" id="users">
                                            <div>
                                                <h6>Number of registered users per month </h6>
                                            </div>
                                            <canvas id="RegisterLine"></canvas>
                                        </div>

                                        <div style="width: 950px; height: 950px; margin-top: -330px;" runat="server" id="regusers">
                                            <div>
                                                <h6>Number of registered users per province </h6>
                                            </div>
                                            <canvas id="ProvinceLine"></canvas>
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

     <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
</asp:Content>
