<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DevNote Admin - Monthly Cheatsheet Report</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
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

        .filter-panel { 
            background-color: #f8fafc; 
            border: 1px solid #e2e8f0; 
            border-radius: 16px; 
            padding: 20px; 
        }
        
        .report-paper {
            background: #ffffff;
            border: 1px solid #cbd5e1;
            padding: 50px;
            margin-top: 24px;
            border-radius: 4px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
        .report-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .report-table th {
            background-color: #1e293b; 
            color: #ffffff;
            font-weight: 600;
            padding: 12px 10px;
            text-align: center;
            font-size: 14px;
            border: 1px solid #1e293b;
        }
        .report-table td {
            padding: 12px 10px;
            border: 1px solid #cbd5e1;
            font-size: 14px;
            text-align: center;
            color: #1e293b;
        }
        .summary-box {
            margin-top: 30px;
            border-top: 2px solid #1e293b;
            padding-top: 15px;
            font-size: 14px;
            color: #000000;
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
        <!-- Unified Header Layout -->
        <header style="background:white; padding:20px 50px; display:flex; justify-content:space-between; align-items:center; box-shadow:0 2px 20px rgba(0,0,0,.05);">
            <h2 style="color:#2563eb; margin: 0;">CheatSheet Hub</h2>
            <nav style="display:flex; align-items:center; gap:25px;">
                <a href="${pageContext.request.contextPath}/admin/profile" style="text-decoration:none; color:#334155; font-weight: 600;">Profile</a>
            </nav>
        </header>

        <!-- Main Structure matching dashboard framework exactly -->
        <div class="page-wrapper">
            
            <jsp:include page="/WEB-INF/views/sidebar.jsp" />

            <div class="main-workspace">
                
                <!-- Unified Dashboard Banner style wrapper -->
                <div class="dashboard-banner">
                    <h1 class="banner-title">Monthly Report Framework</h1>
                    <p class="banner-subtitle">View on-screen execution metrics before running output report prints.</p>
                </div>

                <!-- Interactive Filters panel wrapped in info-card grid structure -->
                <div class="row g-4 mb-4">
                    <div class="col-12">
                        <div class="info-card">
                            <h3 class="info-card-title"><i class="fa-solid fa-filter me-2"></i>Report Parameters Selection</h3>
                            <div class="filter-panel mt-3">
                                <form action="${pageContext.request.contextPath}/admin/reports/monthly" method="GET" class="row align-items-end g-3">
<div class="col-md-6">
    <label class="form-label fw-semibold text-dark">Select Target Month</label>
    <input type="month" 
           name="targetMonth" 
           class="form-control form-control-lg" 
           value="${selectedMonth}" 
           onclick="this.showPicker()"
           onkeydown="return false" 
           required>
</div>
                                    <div class="col-md-6 d-flex gap-2">
                                        <button type="submit" class="btn btn-primary btn-lg w-100 fw-semibold">
                                            <i class="fa-solid fa-magnifying-glass me-2"></i> Show Report
                                        </button>
                                        <a href="${pageContext.request.contextPath}/admin/reports/monthly/download?targetMonth=${selectedMonth}" 
                                           class="btn btn-outline-success btn-lg w-100 fw-semibold ${empty reportList ? 'disabled' : ''}">
                                            <i class="fa-solid fa-file-pdf me-2"></i> Download PDF
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Canvas Paper Analytics -->
                <div class="row">
                    <div class="col-12">
                        <c:choose>
                            <c:when test="${not empty reportList}">
                                <div class="report-paper">
                                    <div class="text-center position-relative mb-5">
                                        <h3 class="fw-bold text-dark m-0">Cheatsheets Performance Report</h3>
                                        <div class="position-absolute end-0 bottom-0 fw-bold text-dark" style="font-size: 15px;">
                                            <span class="me-4">${viewingMonthLabel}</span> <span>${viewingYear}</span>
                                        </div>
                                    </div>

                                    <div class="table-responsive">
                                        <table class="report-table">
                                            <thead>
                                                <tr>
                                                    <th style="width: 6%;">NO.</th>
                                                    <th class="text-start" style="padding-left: 15px;">Cheatsheet Title</th>
                                                    <th style="width: 18%;">Author Name</th>
                                                    <th style="width: 15%;">Posted At</th>
                                                    <th style="width: 10%;">Likes</th>
                                                    <th style="width: 10%;">Rating</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${reportList}" var="report" varStatus="status">
                                                    <tr>
                                                        <td>${status.index + 1}</td>
                                                        <td class="text-start" style="padding-left: 15px;">${report.title}</td>
                                                        <td>${report.name}</td>
                                                        <td>
                                                            <fmt:formatDate value="${report.date}" pattern="dd/MM/yyyy"/>
                                                        </td>
                                                        <td>${report.likes}</td>
                                                        <td><fmt:formatNumber value="${report.rating}" minFractionDigits="1" maxFractionDigits="1"/></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                    <!-- Interactive report summary block -->
                                    <div class="summary-box fw-bold d-flex gap-2">
                                        <span>Total:</span>
                                        <span class="text-center mx-2 text-primary" style="min-width: 20px;">${reportList.size()}</span>
                                        <span class="text-muted fw-normal">cheatsheets were posted by</span>
                                        <span class="text-center mx-2 text-primary" style="min-width: 20px;">${uniqueUsersCount}</span>
                                        <span class="text-muted fw-normal">users.</span>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="info-card text-center py-5 text-muted">
                                    <i class="fa-regular fa-folder-open fa-3x mb-3 text-secondary"></i>
                                    <p class="fs-5 m-0 fw-medium">No operational performance logs recorded inside this cycle parameters.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>