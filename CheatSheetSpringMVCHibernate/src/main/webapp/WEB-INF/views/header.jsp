<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css" rel="stylesheet">

<header class="bg-white px-4 py-3 d-flex justify-content-between align-items-center shadow-sm">
    <h2 class="m-0" style="color:#2563eb; font-weight: 700;">
    <a href="${pageContext.request.contextPath}/" class="text-decoration-none">
            CheatSheet Hub
        </a>
       
    </h2>
		<form action="${pageContext.request.contextPath}/search" method="GET" class="d-flex mx-4" style="width: 45%; max-width: 600px;">
        <div class="input-group">
            <span class="input-group-text bg-light border-end-0 rounded-start-pill ps-3 text-muted">
                <i class="bi bi-search"></i>
            </span>
            <input type="text" name="query" class="form-control bg-light border-start-0 rounded-end-pill py-2 shadow-none" 
                   placeholder="Search for cheatsheets, tags, or categories..." 
                   value="<c:out value='${param.query}' />" required="required" />
        </div>
    </form>
    <nav class="d-flex align-items-center gap-4">
        <a href="${pageContext.request.contextPath}/" class="text-decoration-none text-secondary fw-semibold">
            Home
        </a>

        <c:choose>
            <c:when test="${not empty sessionScope.currentUser}">
                <a href="${pageContext.request.contextPath}/admin/cheatsheet/create" class="text-decoration-none text-secondary fw-semibold">
                    Create Cheatsheet
                </a>
                <a href="#" class="text-decoration-none text-secondary fw-semibold">
                    Profile
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm fw-bold px-3 rounded-2">
                    Logout
                </a>
            </c:when>
            <c:otherwise>
                <button type="button" class="btn btn-outline-primary btn-sm fw-bold px-3 rounded-2" data-bs-toggle="modal" data-bs-target="#loginModal">
                    Login
                </button>
                <button type="button" class="btn btn-primary btn-sm fw-bold px-3 rounded-2" data-bs-toggle="modal" data-bs-target="#registerModal">
                    Register
                </button>
            </c:otherwise>
        </c:choose>
    </nav>
</header>

<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-light">
                <h5 class="modal-title fw-bold text-dark" id="loginModalLabel"><i class="bi bi-box-arrow-in-right me-2"></i>Account Login</h5>
                <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                
                <c:if test="${param.error == 'true'}">
                    <div class="alert alert-danger py-2 small" role="alert">
                        Invalid email or password. Please try again.
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="POST">
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-secondary">Email Address</label>
                        <input type="email" name="email" class="form-control" required="required" placeholder="name@example.com" />
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-secondary">Password</label>
                        <input type="password" name="password" class="form-control" required="required" placeholder="••••••••" />
                    </div>
                    
                    <div class="mb-4 form-check">
                        <input type="checkbox" class="form-check-input" id="rememberMeCheck" name="remember-me">
                        <label class="form-check-label small text-muted" for="rememberMeCheck">Remember me on this machine</label>
                    </div>
                    
                    <button type="submit" class="btn btn-primary w-100 fw-bold">Sign In</button>
                </form>
                
            </div>
            <div class="modal-footer bg-light justify-content-center border-0 py-3">
                <span class="small text-muted">New here? <a href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#registerModal" class="fw-bold text-decoration-none">Create an account</a></span>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="registerModal" tabindex="-1" aria-labelledby="registerModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-light">
                <h5 class="modal-title fw-bold text-dark" id="registerModalLabel"><i class="bi bi-person-plus-fill me-2"></i>Join Cheatsheet Hub</h5>
                <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">

                <c:if test="${not empty param.regError}">
                    <div class="alert alert-danger py-2 small" role="alert">
                        ⚠️ <c:out value="${sessionScope.regErrorMessage}" />
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/register" method="POST">
                    
                    <div class="mb-3">
                        <label class="form-label small fw-bold text-secondary">Full Name</label>
                        <input type="text" name="name" class="form-control" placeholder="John Doe" required="required" value="${param.prevName}" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-bold text-secondary">Email Address</label>
                        <input type="email" name="email" class="form-control" placeholder="john@example.com" required="required" value="${param.prevEmail}" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-bold text-secondary">Password</label>
                        <input type="password" name="password" class="form-control" placeholder="Create password" required="required" />
                    </div>

                    <div class="mb-4">
                        <label class="form-label small fw-bold text-secondary">Confirm Password</label>
                        <input type="password" name="confirmPassword" class="form-control" placeholder="Repeat password" required="required" />
                    </div>

                    <button type="submit" class="btn btn-success w-100 fw-bold">Create Account</button>

                </form>

            </div>
            <div class="modal-footer bg-light justify-content-center border-0 py-3">
                <span class="small text-muted">Already registered? <a href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#loginModal" class="fw-bold text-decoration-none">Log in here</a></span>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    // If Spring Security returns an explicit error query param, pop open the login modal
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('error') === 'true') {
        var loginModal = new bootstrap.Modal(document.getElementById('loginModal'));
        loginModal.show();
    }
    
    // Optional: If form verification fails on submission registration, auto-show the target modal
    <c:if test="${pageContext.request.method == 'POST' and not empty requestScope['org.springframework.validation.BindingResult.registerDto']}">
        var regModal = new bootstrap.Modal(document.getElementById('registerModal'));
        regModal.show();
    </c:if>
});
</script>