<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MMM d, h:mm a");
    request.setAttribute("dateFormatter", dateFormatter);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Notifications</title>
    
    <!-- Unified CDN Stylesheets -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        /* Shared Design Token System from Admin Dashboard */
        :root {
            --bg-canvas: #f4fbfc;       
            --brand-blue: #2563eb;     
            --brand-light: #eff6ff;     
            --text-dark: #1e293b;
            --text-gray: #64748b;
            --border-light: #e2e8f0;
            --shadow-sm: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg-canvas);
            color: var(--text-dark);
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        /* Unified Layout Containers */
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
        
        /* Unified Card Spacing & Sizing rules */
        .activity-log-card { 
            background-color: #ffffff; 
            border-radius: 20px; 
            box-shadow: var(--shadow-sm); 
            border: none;
            display: flex;
            flex-direction: column;
            width: 100%;
        }
        
        /* Inner Component Layouts */
        .progress-header { 
            padding: 28px; 
            border-bottom: 1px solid #f1f5f9; 
        }
        
        .progress { 
            height: 6px; 
            border-radius: 3px; 
            background-color: #e2e8f0; 
        }
        
        /* Scrollable Configuration */
        .log-scroll-area {
            max-height: 500px; 
            overflow-y: auto;
        }
        
        .log-row { 
            display: flex; 
            align-items: center; 
            padding: 18px 28px; 
            border-bottom: 1px solid #f1f5f9; 
        }
        
        .log-row:last-child {
            border-bottom: none;
        }
        
        .log-main-content { 
            flex-grow: 1; 
            font-size: 15px; 
            font-weight: 600; 
            color: var(--text-dark); 
        }
        
        .log-timestamp { 
            font-size: 14px; 
            font-weight: 600; 
            color: var(--text-gray); 
        }

        /* Standardized Footer Layout */
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
        <!-- Standardized Header Component -->
        <header style="background:white; padding:20px 50px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 20px rgba(0,0,0,.05);">
            <h2 style="color:#2563eb; margin: 0;">CheatSheet Hub</h2>
            <nav style="display:flex; align-items:center; gap:25px;">
                <a href="${pageContext.request.contextPath}/admin/profile" style="text-decoration:none; color:#334155; font-weight: 600;">Profile</a>
            </nav>
        </header>

        <!-- Standardized Layout Wrapper -->
        <div class="page-wrapper">
            
            <!-- Standardized Sidebar Include Path -->
            <jsp:include page="/WEB-INF/views/sidebar.jsp" />

            <!-- Main Dynamic Workspace Sizing -->
            <div class="main-workspace">
                
                <!-- Activity Log Container (Standardized to Card Sizing Rules) -->
                <div class="activity-log-card">
                    
                    <!-- Progress Bar Section -->
                    <div class="progress-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <span class="fw-bold text-dark">System Activity</span>
                                <span class="badge bg-success-subtle text-success ms-2 rounded-pill">Active</span>
                            </div>
                            <span class="text-muted fw-bold small">Latest update: Just now</span>
                        </div>
                        <div class="progress mt-2">
                            <div class="progress-bar bg-primary" style="width: 85%"></div>
                        </div>
                    </div>

                    <!-- Scrollable Logs Content Area -->
                    <div class="log-scroll-area">
                        <c:forEach var="log" items="${adminActivityLogs}">
                            <div class="log-row">
                                <div class="log-main-content">
                                    <span class="text-primary me-2">•</span> 
                                    <c:out value="${log.description}" />
                                </div>
                                <div class="log-timestamp">
                                    <c:out value="${log.createdAt.format(dateFormatter)}" />
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                </div>
            </div>
        </div>

        <!-- Standardized Footer Component -->
        <footer class="site-footer">
            <div class="footer-container">
                <h3>CheatSheet Hub</h3>
                <p>Learn Faster. Share Knowledge. Build Better.</p>
                <p class="copyright">© 2026 CheatSheet Hub. All Rights Reserved.</p>
            </div>
        </footer>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>