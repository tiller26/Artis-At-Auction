<%@ Page Title="" EnableEventValidation="false" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FinanceReports.aspx.cs" Inherits="Project_Backup.FinanceReports" %>

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
                                        <h3>Finances Of The Company</h3>
                                        <div class="row mt-5">
                                            <h4>Business Revenue</h4>
                                        </div>
                                        <div class="row mt-5" style="width: 330px; height: 330px; margin-bottom: 120px;">
                                            <div>
                                                <h6>Money Made from sales and registrations</h6>
                                            </div>

                                            <canvas id="AllPie"></canvas>
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

</asp:Content>
