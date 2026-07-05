<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MMM d, h:mm a");
    request.setAttribute("dateFormatter", dateFormatter);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>System Notifications</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #f8fafc; }
        .wrapper { display: flex; min-height: 100vh; }
        .content-area { flex-grow: 1; padding: 32px; }
        
        .gmail-container { 
            background: #ffffff; 
            border-radius: 20px; 
            box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1); 
            max-width: 1200px; 
            margin: 0 auto; 
            border: 1px solid #e2e8f0;
            display: flex;
            flex-direction: column;
        }
        
        /* Progress Bar Container */
        .progress-header { padding: 20px 24px; border-bottom: 1px solid #e2e8f0; }
        .progress { height: 6px; border-radius: 3px; background-color: #e2e8f0; margin-top: 8px; }
        
        /* Scrollable Logs Area */
        .log-scroll-area {
            max-height: 500px; /* အပေါ်တက်အောက်ဆင်းလုပ်နိုင်ဖို့ ဒီနေရာမှာ အမြင့်သတ်မှတ်ပေးပါ */
            overflow-y: auto;
        }
        
        .log-row { display: flex; align-items: center; padding: 18px 24px; border-bottom: 1px solid #f1f5f9; }
        .log-main-content { flex-grow: 1; font-size: 15px; font-weight: 600; color: #1e293b; }
        .log-timestamp { font-size: 14px; font-weight: 600; color: #64748b; }
    </style>
</head>
<body>

    <jsp:include page="header.jsp" />

    <div class="wrapper">
        <jsp:include page="sidebar.jsp" />

        <div class="content-area">
            <div class="gmail-container">
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

                <!-- Scrollable Content -->
                <div class="log-scroll-area">
                    <c:forEach var="log" items="${adminActivityLogs}">
                        <div class="log-row">
                            <div class="log-main-content">
                                <span class="text-primary me-2">•</span> <c:out value="${log.description}" />
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

    <jsp:include page="footer.jsp" />

</body>
</html>