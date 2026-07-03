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
            --brand-blue: #2563eb;     
            --brand-blue-gradient: linear-gradient(135deg, #1e40af, #2563eb);
            --brand-light: #eff6ff;     
            --text-dark: #1e293b;
            --text-gray: #64748b;
            --border-light: #e2e8f0;
            --shadow-sm: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            --shadow-hover: 0 10px 20px rgba(37, 99, 235, 0.12);
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-canvas);
            color: var(--text-dark);
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        .page-container {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .page-wrapper {
            display: flex;
            padding: 24px;
            gap: 24px;
            align-items: flex-start;
            flex: 1;
        }

        .main-workspace {
            flex-grow: 1;
            min-width: 0;
        }

        .dashboard-banner {
            background: var(--brand-blue-gradient);
            border-radius: 24px;
            padding: 45px 60px; 
            color: #ffffff;
            margin-bottom: 28px;
            box-shadow: 0 10px 20px -5px rgba(37, 99, 235, 0.3);
        }
        .banner-title {
            font-weight: 800;
            font-size: 50px; 
            margin-bottom: 12px;
            letter-spacing: -0.5px;
        }
        .banner-subtitle {
            font-size: 24px; 
            opacity: 0.95;
            margin: 0;
            max-width: 800px;
            line-height: 1.6;
        }

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
            color: var(--brand-blue); 
            margin-bottom: 8px;
            line-height: 1;
        }
        .metric-label {
            color: var(--text-gray);
            font-size: 14px;
            font-weight: 600;
        }

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
            color: var(--brand-blue); 
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
            color: var(--brand-blue); 
            margin-left: 8px;
        }

        .site-footer {
            background: #111827;
            color: white;
            margin-top: 60px;
            padding: 40px 20px;
        }
        .footer-container {
            max-width: 1200px;
            margin: auto;
            text-align: center;
        }
        .footer-container h3 {
            margin-bottom: 10px;
            font-size: 24px;
        }
        .footer-container p {
            color: #d1d5db;
            margin-bottom: 8px;
        }
        .copyright {
            margin-top: 15px;
            font-size: 14px;
            color: #9ca3af;
        }
    </style>
</head>
<body>

    <div class="page-container">
        <header style="background:white; padding:20px 50px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 20px rgba(0,0,0,.05);">
            <h2 style="color:#2563eb; margin: 0;">CheatSheet Hub</h2>
            <nav style="display:flex; gap:25px;">
                <a href="${pageContext.request.contextPath}/" style="text-decoration:none; color:#334155; font-weight: 600;">Home</a>
                <a href="${pageContext.request.contextPath}/admin/cheatsheet/create" style="text-decoration:none; color:#334155; font-weight: 600;">Create Cheatsheet</a>
                <a href="${pageContext.request.contextPath}/admin/profile" style="text-decoration:none; color:#334155; font-weight: 600;">Profile</a>
            </nav>
        </header>

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

        <footer class="site-footer">
            <div class="footer-container">
                <h3>CheatSheet Hub</h3>
                <p>Learn Faster. Share Knowledge. Build Better.</p>
                <p class="copyright">© 2026 CheatSheet Hub. All Rights Reserved.</p>
            </div>
        </footer>
    </div>

</body>
</html>