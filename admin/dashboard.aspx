<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/admin/adminMasterPage.master" AutoEventWireup="true" CodeFile="dashboard.aspx.cs" Inherits="dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        /* Dashboard Container */
        .dashboard-container {
            padding: 30px;
            background-color: #f8f9fa;
            min-height: 90vh;
        }

        /* Page Title */
        .dashboard-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: rgb(0 51 132 / 90%);
            margin-bottom: 25px;
        }

        /* Stats Cards */
        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            padding: 25px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-4px);
        }

        .stat-card i {
            font-size: 32px;
            color: rgb(0 51 132 / 90%);
        }

        .stat-info {
            text-align: right;
        }

        .stat-info h4 {
            font-size: 1.5rem;
            margin: 0;
            font-weight: 700;
            color: rgb(0 51 132 / 90%);
        }

        .stat-info span {
            color: #555;
            font-size: 0.9rem;
        }

        /* Chart Section */
        .chart-section {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            padding: 25px;
        }

        .chart-section h5 {
            color: rgb(0 51 132 / 90%);
            margin-bottom: 15px;
            font-weight: 600;
        }

        canvas {
            width: 100% !important;
            height: 300px !important;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .dashboard-title {
                font-size: 1.4rem;
                text-align: center;
            }
        }
    </style>

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="dashboard-container">
        <h2 class="dashboard-title">Admin Dashboard</h2>

        <!-- Stats Section -->
        <div class="dashboard-stats">
            <div class="stat-card">
                <i class="fas fa-box"></i>
                <div class="stat-info">
                    <h4><asp:Label ID="lblTotalProducts" runat="server" Text="0"></asp:Label></h4>
                    <span>Total Products</span>
                </div>
            </div>

            <div class="stat-card">
                <i class="fas fa-list"></i>
                <div class="stat-info">
                    <h4><asp:Label ID="lblTotalCategories" runat="server" Text="0"></asp:Label></h4>
                    <span>Total Categories</span>
                </div>
            </div>

         
            </div>
        
        <!-- Chart Section -->
        <div class="chart-section">
            <h5>Monthly Sales Overview</h5>
            <canvas id="salesChart"></canvas>
        </div>
    </div>

    <script>
        // Example Chart.js Script (Static Data)
        const ctx = document.getElementById('salesChart');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [{
                    label: 'Sales',
                    data: [1200, 1900, 1700, 2500, 2000, 2700],
                    borderColor: 'rgb(0, 51, 132)',
                    backgroundColor: 'rgba(0, 51, 132, 0.2)',
                    fill: true,
                    tension: 0.3,
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: { beginAtZero: true }
                }
            }
        });
    </script>
</asp:Content>
