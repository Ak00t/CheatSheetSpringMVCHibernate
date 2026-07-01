<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="card p-4 mx-auto my-5 shadow-sm" style="max-width: 450px;">
    <h3 class="fw-bold mb-3">Reset New Password</h3>

    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

    <form method="post" action="${pageContext.request.contextPath}/reset-password">
        <input type="hidden" name="token" value="${token}" />
        
        <div class="mb-3">
            <label class="form-label small text-muted">Enter your new secure password</label>
            <input type="password" name="password" class="form-control p-2.5" minlength="6" required placeholder="••••••••">
        </div>
        <button type="submit" class="btn btn-primary w-100 fw-bold">Update Secure Password</button>
    </form>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>