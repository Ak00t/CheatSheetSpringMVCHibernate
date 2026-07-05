<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Following Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body { background: #f8fafc; color: #1e293b; font-family: 'Segoe UI', sans-serif; }
        .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 24px; }
    </style>
</head>
<body>

    <!-- 🟢 Header အား လှမ်းထည့်ခြင်း -->
    <jsp:include page="header.jsp"/>

    <div class="container my-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="fw-bold" style="color: #dc2626;">🤝 Following Users</h1>
            <a href="${pageContext.request.contextPath}/profile-cheatsheets" class="btn btn-outline-secondary rounded-pill px-4 fw-bold">
                <i class="bi bi-arrow-left me-1"></i> Back to Cheatsheets
            </a>
        </div>

        <div id="followFeedArea">
            <div id="followContainer" class="grid">
                <!-- Ajax ကနေ ရလာမယ့် Following Card တွေ ဒီထဲမှာ ပေါ်လာပါမယ် -->
            </div>
        </div>
    </div>

    <script>
        // စာမျက်နှာပွင့်တာနဲ့ ၎င်းရဲ့ သက်ဆိုင်ရာ API ကို ချက်ချင်း Ajax လှမ်းခေါ်ခိုင်းခြင်း
        document.addEventListener("DOMContentLoaded", function() {
            if(typeof loadFollowSystemFeed === 'function') {
                loadFollowSystemFeed('following');
            }
        });
    </script>
</body>
</html>