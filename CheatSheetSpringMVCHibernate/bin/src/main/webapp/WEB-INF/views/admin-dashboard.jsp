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
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --bg-canvas: #f4fbfc;       
            --brand-green: #047857;     
            --brand-light: #d1fae5;     
            --text-dark: #1e293b;
            --text-gray: #64748b;
            --border-light: #e2e8f0;
            --banner-gradient: linear-gradient(105deg, #064e3b 0%, #047857 35%, #0f766e 70%, #115e59 100%);
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-canvas);
            color: var(--text-dark);
            overflow-x: hidden;
        }

        .top-navbar {
            background-color: #ffffff;
            border-bottom: 1px solid var(--border-light);
            padding: 15px 40px;
        }
        .navbar-brand-custom {
            font-weight: 700;
            font-size: 24px;
            color: var(--brand-green) !important;
            line-height: 1.2;
        }
        .top-nav-link {
            color: var(--text-gray);
            font-weight: 600;
            font-size: 15px;
            text-decoration: none;
            padding: 8px 16px;
            transition: all 0.2s ease;
        }
        .top-nav-link:hover {
            color: var(--brand-green);
        }
        .top-nav-link.active-pill {
            background-color: var(--brand-light);
            color: var(--brand-green);
            border-radius: 8px;
        }
        .search-input {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 8px 16px;
            font-size: 14px;
            width: 240px;
        }
        .notification-btn {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 10px;
            position: relative;
        }
        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background-color: #ef4444;
            color: white;
            font-size: 10px;
            padding: 3px 6px;
            border-radius: 50%;
        }
        .profile-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            object-fit: cover;
        }

        .sidebar-container {
            width: 260px;
            background-color: #ffffff;
            border-radius: 24px;
            padding: 24px 16px;
            margin-top: 24px;
            margin-left: 24px;
            align-self: flex-start;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }
        .sidebar-link {
            display: flex;
            align-items: center;
            color: var(--text-gray);
            font-weight: 600;
            font-size: 15px;
            text-decoration: none;
            padding: 12px 16px;
            margin-bottom: 6px;
            border-radius: 14px;
            transition: all 0.2s ease;
        }
        .sidebar-link i {
            width: 24px;
            font-size: 16px;
        }
        .sidebar-link:hover, .sidebar-link.active {
            background-color: var(--brand-light);
            color: var(--brand-green);
        }

        .main-workspace {
            padding: 24px;
            flex: 1;
        }

        .dashboard-banner {
            background: var(--banner-gradient);
            border-radius: 24px;
            padding: 40px;
            color: #ffffff;
            margin-bottom: 24px;
        }
        .banner-title {
            font-weight: 700;
            font-size: 36px;
            margin-bottom: 12px;
        }
        .banner-subtitle {
            font-size: 15px;
            font-weight: 400;
            opacity: 0.9;
            max-width: 800px;
            line-height: 1.6;
        }

        .metric-card {
            background-color: #ffffff;
            border-radius: 24px;
            padding: 28px 24px;
            border: none;
            height: 100%;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }
        .metric-value {
            font-size: 38px;
            font-weight: 700;
            color: var(--brand-green);
            margin-bottom: 8px;
            line-height: 1;
        }
        .metric-label {
            color: var(--text-gray);
            font-size: 14px;
            font-weight: 500;
        }

        .info-card {
            background-color: #ffffff;
            border-radius: 24px;
            padding: 32px;
            border: none;
            height: 100%;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }
        .info-card-title {
            font-weight: 700;
            color: var(--brand-green);
            font-size: 22px;
            margin-bottom: 20px;
        }
        .info-card-text {
            color: var(--text-gray);
            font-size: 15px;
            line-height: 1.8;
        }
        .today-list {
            list-style: none;
            padding-left: 0;
            margin-bottom: 0;
        }
        .today-list li {
            padding: 10px 0;
            font-size: 15px;
            color: var(--text-dark);
            border-bottom: 1px solid #f1f5f9;
        }
        .today-list li:last-child {
            border-bottom: none;
        }
        .today-list span {
            font-weight: 600;
            color: var(--brand-green);
        }
    </style>
</head>
<body>

    <nav class="top-navbar d-flex justify-content-between align-items-center">
        <div class="d-flex align-items-center gap-4">
            <div class="navbar-brand-custom">DevNote<br>Admin</div>
            <div class="d-flex align-items-center ms-4">
                <a href="<c:url value='/admin/dashboard'/>" class="top-nav-link active-pill">Dashboard</a>
                <a href="#" class="top-nav-link">Users</a>
                <a href="#" class="top-nav-link">Reports</a>
                <a href="#" class="top-nav-link">Moderation</a>
                <a href="#" class="top-nav-link">Categories</a>
                <a href="#" class="top-nav-link">Tags</a>
                <a href="#" class="top-nav-link">Analytics</a>
            </div>
        </div>
        
        <div class="d-flex align-items-center gap-3">
            <input type="text" class="search-input" placeholder="Search users, reports, tags...">
            <button class="notification-btn">
                <i class="fa-regular fa-bell text-secondary"></i>
                <span class="notification-badge">9</span>
            </button>
            <div class="d-flex align-items-center gap-2 border-start ps-3">
                <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=100&q=80" class="profile-avatar" alt="Admin Avatar">
                <span class="fw-bold small text-secondary">Admin</span>
            </div>
        </div>
    </nav>

    <div class="d-flex container-fluid p-0">
        <div class="sidebar-container">
            <a href="<c:url value='/admin/dashboard'/>" class="sidebar-link active">
                <i class="fa-solid fa-chart-simple"></i> Dashboard
            </a>
            <a href="#" class="sidebar-link"><i class="fa-solid fa-users"></i> Users</a>
            <a href="#" class="sidebar-link"><i class="fa-solid fa-file-lines"></i> Cheatsheets</a>
            <a href="#" class="sidebar-link"><i class="fa-regular fa-comments"></i> Comments</a>
            <a href="#" class="sidebar-link"><i class="fa-regular fa-flag"></i> Reports</a>
            <a href="#" class="sidebar-link"><i class="fa-solid fa-shield-halved"></i> Moderation</a>
            <a href="#" class="sidebar-link"><i class="fa-regular fa-folder"></i> Categories</a>
            <a href="#" class="sidebar-link"><i class="fa-solid fa-tags"></i> Tags</a>
            <a href="#" class="sidebar-link"><i class="fa-regular fa-bell"></i> Notifications</a>
            <a href="#" class="sidebar-link"><i class="fa-solid fa-chart-line"></i> Analytics</a>
            <a href="#" class="sidebar-link"><i class="fa-solid fa-clock-rotate-left"></i> Activity Logs</a>
            <a href="#" class="sidebar-link"><i class="fa-solid fa-gear"></i> Settings</a>
        </div>

        <div class="main-workspace">
            <div class="dashboard-banner">
                <h1 class="banner-title">Admin Dashboard</h1>
                <p class="banner-subtitle mb-0">Monitor users, cheatsheets, reports, warning/ban thresholds, categories, tags and platform analytics.</p>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-3">
                    <div class="metric-card shadow-sm">
                        <div class="metric-value">
                            <c:out value="${not empty totalUsers ? totalUsers : '1,240'}"/>
                        </div>
                        <div class="metric-label">Total Users</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="metric-card shadow-sm">
                        <div class="metric-value">
                            <c:out value="${not empty totalCheatsheets ? totalCheatsheets : '850'}"/>
                        </div>
                        <div class="metric-label">Cheatsheets</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="metric-card shadow-sm">
                        <div class="metric-value">
                            <c:out value="${not empty pendingReports ? pendingReports : '32'}"/>
                        </div>
                        <div class="metric-label">Pending Reports</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="metric-card shadow-sm">
                        <div class="metric-value">
                            <c:out value="${not empty bannedContents ? bannedContents : '12'}"/>
                        </div>
                        <div class="metric-label">Banned Contents</div>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-md-7">
                    <div class="info-card shadow-sm">
                        <h3 class="info-card-title">Report Threshold Rule</h3>
                        <p class="info-card-text mb-0">
                            5 reports = warning notification. 10 reports = ban notification.<br>
                            Admin can manually ban anytime with reason.
                        </p>
                    </div>
                </div>

                <div class="col-md-5">
                    <div class="info-card shadow-sm">
                        <h3 class="info-card-title">Today</h3>
                        <ul class="today-list">
                            <li>New users: <span><c:out value="${not empty newUsersToday ? newUsersToday : '24'}"/></span></li>
                            <li>New cheatsheets: <span><c:out value="${not empty newCheatsheetsToday ? newCheatsheetsToday : '18'}"/></span></li>
                            <li>New reports: <span><c:out value="${not empty newReportsToday ? newReportsToday : '9'}"/></span></li>
                            <li>Warnings sent: <span><c:out value="${not empty warningsSentToday ? warningsSentToday : '3'}"/></span></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>