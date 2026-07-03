<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    // Clean notification layout time display configuration (e.g., Jul 3, 9:04 AM)
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MMM d, h:mm a");
    request.setAttribute("dateFormatter", dateFormatter);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>System Notifications</title>
    <style>
        body {
            font-family: 'Segoe UI', Roboto, Arial, sans-serif;
            background-color: #f6f8fc;
            margin: 0;
            padding: 24px;
        }
        .gmail-container {
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05), 0 1px 2px rgba(0,0,0,0.1);
            max-width: 1200px;
            margin: 0 auto;
            overflow: hidden;
        }
        .gmail-tabs {
            display: flex;
            border-bottom: 1px solid #f1f3f4;
            padding-left: 16px;
            background-color: #ffffff;
        }
        .gmail-tab {
            display: flex;
            align-items: center;
            padding: 16px 20px;
            font-size: 15px;
            font-weight: 600;
            color: #0b57d0;
            gap: 12px;
            border-bottom: 3px solid #0b57d0;
        }
        .log-row {
            display: flex;
            align-items: center;
            padding: 14px 24px;
            border-bottom: 1px solid #f1f3f4;
            font-size: 14px;
            color: #202124;
            background-color: #ffffff;
            transition: background-color 0.1s;
        }
        .log-row:hover {
            background-color: #f8f9fa;
        }
        .noti-icon {
            margin-right: 16px;
            color: #1a73e8;
            display: flex;
            align-items: center;
        }
        .log-main-content {
            flex-grow: 1;
            color: #3c4043;
            font-weight: 500;
        }
        .log-timestamp {
            margin-left: auto;
            font-size: 13px;
            color: #5f6368;
            white-space: nowrap;
            flex-shrink: 0;
            text-align: right;
        }
    </style>
</head>
<body>

<div class="gmail-container">
    <div class="gmail-tabs">
        <div class="gmail-tab">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor"><path d="M12 22c1.1 0 2-.9 2-2h-4c0 1.1.89 2 2 2zm6-6v-5c0-3.07-1.64-5.64-4.5-6.32V4c0-.83-.67-1.5-1.5-1.5s-1.5.67-1.5 1.5v.68C7.63 5.36 6 7.92 6 11v5l-2 2v1h16v-1l-2-2z"/></svg>
            Recent System Notifications
        </div>
    </div>
    
    <c:forEach var="log" items="${adminActivityLogs}">
        <div class="log-row">
            <!-- Informative Activity Icon -->
            <div class="noti-icon">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><path d="M12 16v-4"/><path d="M12 8h.01"/></svg>
            </div>

            <!-- Pure Clean Notification Sentence Output -->
            <div class="log-main-content">
                <c:out value="${log.description}" />
            </div>

            <!-- Execution Time Element -->
            <div class="log-timestamp">
                <c:out value="${log.createdAt.format(dateFormatter)}" />
            </div>
        </div>
    </c:forEach>
</div>

</body>
</html>