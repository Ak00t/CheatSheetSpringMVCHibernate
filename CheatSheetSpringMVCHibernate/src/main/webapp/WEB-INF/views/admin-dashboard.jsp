<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DevNote Admin - Dashboard</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --bg-canvas: #f4fbfc;       
            --brand-green: #047857;     
            --brand-light: #d1fae5;     
            --text-dark: #1e293b;
            --text-gray: #64748b;
            --border-light: #e2e8f0;
            --shadow-sm: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            --shadow-hover: 0 10px 20px rgba(4, 120, 87, 0.12);
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-canvas);
            color: var(--text-dark);
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        /* --- 1. Top Navbar Styling --- */
        .top-navbar {
            background-color: #ffffff;
            border-bottom: 1px solid var(--border-light);
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .navbar-brand-custom {
            font-weight: 800;
            font-size: 22px;
            color: var(--brand-green);
            line-height: 1.2;
            text-decoration: none;
        }
        .nav-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .search-input {
            background-color: #f8fafc;
            border: 1px solid var(--border-light);
            border-radius: 12px;
            padding: 10px 16px;
            font-size: 14px;
            width: 300px;
        }
        .notification-btn {
            background: #f8fafc;
            border: 1px solid var(--border-light);
            border-radius: 12px;
            padding: 10px;
            position: relative;
            color: var(--text-gray);
            cursor: pointer;
        }
        .notification-badge {
            position: absolute;
            top: -6px;
            right: -6px;
            background-color: #ef4444;
            color: white;
            font-size: 10px;
            font-weight: bold;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .profile-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            background-color: var(--brand-green);
        }

        /* --- 2. Flex Layout Container (Very Important for side-by-side layout) --- */
        .page-wrapper {
            display: flex;
            padding: 24px;
            gap: 24px;
            align-items: flex-start; /* Keeps sidebar sticky at top */
            min-height: calc(100vh - 75px);
        }

        /* --- 3. Sidebar CSS (Applies to your included sidebar.jsp) --- */
        .sidebar-container {
            width: 250px;
            background-color: #ffffff;
            border-radius: 20px;
            padding: 20px 16px;
            box-shadow: var(--shadow-sm);
            flex-shrink: 0; /* Prevents sidebar from squishing */
        }
        .sidebar-link {
            display: flex;
            align-items: center;
            color: var(--text-gray);
            font-weight: 600;
            font-size: 15px;
            text-decoration: none;
            padding: 12px 16px;
            margin-bottom: 8px;
            border-radius: 12px;
            transition: all 0.2s ease;
        }
        .sidebar-link i {
            width: 24px;
            font-size: 16px;
        }
        .sidebar-link:hover {
            background-color: var(--brand-light);
            color: var(--brand-green);
            transform: translateX(4px);
        }
        .sidebar-link.active {
            background-color: var(--brand-green);
            color: #ffffff;
            box-shadow: 0 4px 10px rgba(4, 120, 87, 0.2);
        }
        .sidebar-link.active:hover {
            color: #ffffff;
            transform: none;
        }

        /* --- 4. Main Content CSS --- */
        .main-workspace {
            flex-grow: 1; /* Takes up remaining space */
            min-width: 0;
        }

        .dashboard-banner {
            background-color: var(--brand-green);
            border-radius: 20px;
            padding: 36px 40px;
            color: #ffffff;
            margin-bottom: 24px;
        }
        .banner-title {
            font-weight: 800;
            font-size: 32px;
            margin-bottom: 10px;
        }
        .banner-subtitle {
            font-size: 15px;
            opacity: 0.9;
            margin: 0;
        }

        /* Metric Cards */
        .metric-card {
            background-color: #ffffff;
            border-radius: 20px;
            padding: 24px;
            border: none;
            height: 100%;
            box-shadow: var(--shadow-sm);
        }
        .metric-value {
            font-size: 36px;
            font-weight: 800;
            color: var(--brand-green);
            margin-bottom: 8px;
            line-height: 1;
        }
        .metric-label {
            color: var(--text-gray);
            font-size: 14px;
            font-weight: 600;
        }

        /* Bottom Info Cards */
        .info-card {
            background-color: #ffffff;
            border-radius: 20px;
            padding: 28px;
            border: none;
            height: 100%;
            box-shadow: var(--shadow-sm);
        }
        .info-card-title {
            font-weight: 800;
            color: var(--brand-green);
            font-size: 20px;
            margin-bottom: 16px;
        }
        .info-card-text {
            color: var(--text-gray);
            font-size: 15px;
            line-height: 1.8;
            margin: 0;
        }
        
        .today-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .today-list li {
            padding: 12px 0;
            font-size: 15px;
            color: var(--text-dark);
            border-bottom: 1px solid #f1f5f9;
            display: flex;
            align-items: center;
        }
        .today-list li:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }
        .today-list span {
            font-weight: 700;
            color: var(--brand-green);
            margin-left: 8px;
        }
    </style>
</head>
<body>
<nav class="top-navbar">
        <a href="${pageContext.request.contextPath}/admindashboard" class="navbar-brand-custom">
            DEV-NOTE<br>CHEATSHEET
        </a>
        
       <div class="nav-right">
    <input type="text" class="search-input d-none d-md-block" placeholder="Search users, reports, tags...">
    
    <div class="notification-btn">
        <i class="fa-regular fa-bell"></i>
        <span class="notification-badge"><c:out value="${not empty pendingReports ? pendingReports : '0'}"/></span>
    </div>
    
<div class="d-flex align-items-center gap-3 ms-2 ps-3 border-start">
    <a href="${pageContext.request.contextPath}/admin/profile" style="text-decoration: none;">
        <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" 
             class="profile-avatar" 
             alt="Profile" 
             style="width: 40px; height: 40px; cursor: pointer; border: 2px solid #e2e8f0; object-fit: cover; background-color: #ffffff;">
    </a>
</div>
</div>
    </nav>

    <div class="page-wrapper">
        
        <jsp:include page="/WEB-INF/views/sidebar.jsp" />

        <div class="main-workspace">
            
            <div class="dashboard-banner">
                <h1 class="banner-title">Admin Dashboard</h1>
                <p class="banner-subtitle">Monitor users, cheatsheets, reports, warning/ban thresholds, categories, tags and platform analytics.</p>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-3">
                    <div class="metric-card">
                        <div class="metric-value"><c:out value="${not empty totalUsers ? totalUsers : '1'}"/></div>
                        <div class="metric-label">Total Users</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="metric-card">
                        <div class="metric-value"><c:out value="${not empty totalCheatsheets ? totalCheatsheets : '0'}"/></div>
                        <div class="metric-label">Cheatsheets</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="metric-card">
                        <div class="metric-value"><c:out value="${not empty pendingReports ? pendingReports : '0'}"/></div>
                        <div class="metric-label">Pending Reports</div>
                    </div>
                </div>
            <div class="col-md-3">
    <div class="metric-card">
        <div class="metric-value" style="color: #dc3545;">
            <c:out value="${not empty bannedContents ? bannedContents : '0'}"/>
        </div>
        <div class="metric-label">Banned Contents</div>
    </div>
</div>
            </div>

            <div class="row g-4">
                <div class="col-md-7">
                    <div class="info-card">
                        <h3 class="info-card-title">Report Threshold Rule</h3>
                        <p class="info-card-text">
                            <c:out value="${not empty warningThreshold ? warningThreshold : '5'}"/> reports = warning notification.<br>
                            <c:out value="${not empty banThreshold ? banThreshold : '10'}"/> reports = ban notification.<br><br>
                            Admin can manually ban anytime with reason.
                        </p>
                    </div>
                </div>

                <div class="col-md-5">
                    <div class="info-card">
                        <h3 class="info-card-title">Today</h3>
                        <ul class="today-list">
                            <li>New users: <span><c:out value="${not empty newUsersToday ? newUsersToday : '1'}"/></span></li>
                            <li>New cheatsheets: <span><c:out value="${not empty newCheatsheetsToday ? newCheatsheetsToday : '0'}"/></span></li>
                            <li>New reports: <span><c:out value="${not empty newReportsToday ? newReportsToday : '0'}"/></span></li>
                            <li>Warnings sent: <span><c:out value="${not empty warningsSentToday ? warningsSentToday : '0'}"/></span></li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>

</body>
</html>