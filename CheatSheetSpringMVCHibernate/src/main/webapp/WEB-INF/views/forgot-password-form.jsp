<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password - CheatSheet Hub</title>
    <style>
        .auth-bg {
            background-color: #f8f9fa;
            min-height: 70vh;
        }
        .auth-card {
            border: none;
            border-radius: 12px;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="auth-bg d-flex align-items-center py-5">
    <div class="container">
        <div class="card p-4 mx-auto shadow auth-card" style="max-width: 420px; background: #ffffff;">
            
            <div class="text-center mb-4">
                <h3 class="fw-bold text-dark mb-1">Forgot Password</h3>
                <p class="text-muted small">No worries! Enter your email below and we'll send you a link to reset it.</p>
            </div>
            
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show d-flex justify-content-between align-items-center small py-2 px-3 mb-3" role="alert">
                    <span><i class="bi bi-check-circle-fill me-2"></i>${message}</span>
                    <button type="button" class="btn-close small shadow-none m-0" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show d-flex justify-content-between align-items-center small py-2 px-3 mb-3" role="alert">
                    <span><i class="bi bi-exclamation-triangle-fill me-2"></i>${error}</span>
                    <button type="button" class="btn-close small shadow-none m-0" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/forgot-password">
                <div class="mb-4">
                    <label class="form-label small fw-semibold text-secondary">Email Address</label>
                    <input type="email" name="email" class="form-control form-control-lg fs-6" required placeholder="name@domain.com" style="border-radius: 8px;">
                </div>
                
                <button type="submit" class="btn btn-dark w-100 fw-bold py-2.5 mb-3" style="border-radius: 8px; letter-spacing: 0.3px;">
                    Send Reset Link
                </button>
                
                <div class="text-center">
                    <a href="${pageContext.request.contextPath}/?login=true" class="small text-decoration-none fw-semibold text-muted">
                        <i class="bi bi-arrow-left me-1"></i>Back to Sign In
                    </a>
                </div>
            </form>
            
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>
</body>
</html>