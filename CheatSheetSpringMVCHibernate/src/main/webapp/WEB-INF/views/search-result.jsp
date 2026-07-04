<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results for "${query}" - CheatSheet Hub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8fafc;
        }
        .result-card {
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            border-radius: 12px;
        }
        .result-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.06) !important;
        }
        .badge-category { background-color: #ecfdf5; color: #065f46; }
        .badge-user { background-color: #fef3c7; color: #92400e; }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

    <jsp:include page="header.jsp"/>

    <main class="container my-5 flex-grow-1">
        <div class="row">
            <div class="col-12 mb-4">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/" class="text-decoration-none">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Search</li>
                    </ol>
                </nav>
                <h3 class="fw-bold text-dark">
                    Search Results for: <span class="text-primary">"<c:out value="${query}"/>"</span>
                </h3>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty results.cheatsheets && empty results.categories && empty results.users}">
                <div class="card border-0 shadow-sm text-center p-5 rounded-4 mt-2">
                    <div class="card-body">
                        <i class="bi bi-search-heart text-muted display-1"></i>
                        <h4 class="fw-bold mt-4 text-dark">No matching entries discovered</h4>
                        <p class="text-muted mx-auto" style="max-width: 500px;">
                            We couldn't find matches for "${query}". Double-check your spelling, search by broad tags, or browse alternative categories.
                        </p>
                        <a href="${pageContext.request.contextPath}/" class="btn btn-primary px-4 fw-bold rounded-pill mt-2">
                            Return Home
                        </a>
                    </div>
                </div>
            </c:when>
            
            <c:otherwise>
                <div class="row g-4">
                    
                    <c:if test="${not empty results.cheatsheets}">
                        <div class="col-12 mt-4">
                            <h5 class="fw-bold text-secondary border-bottom pb-2 mb-3">
                                <i class="bi bi-file-earmark-text me-2 text-primary"></i>Cheatsheets (${results.cheatsheets.size()})
                            </h5>
                            <div class="row g-3">
                                <c:forEach var="cs" items="${results.cheatsheets}">
                                    <div class="col-md-6 col-lg-4">
                                        <div class="card h-100 border-0 shadow-sm result-card">
                                            <div class="card-body p-4 d-flex flex-column">
                                                <h5 class="card-title fw-bold text-dark text-truncate mb-2">${cs.title}</h5>
                                                <p class="card-text text-muted small flex-grow-1 line-clamp-3">
                                                    ${cs.description}
                                                </p>
                                                <div class="d-flex justify-content-between align-items-center mt-3 pt-2 border-top">
                                                    <span class="small text-secondary"><i class="bi bi-person me-1"></i>${cs.user.name}</span>
                                                    <a href="${pageContext.request.contextPath}/cheatsheet/${cs.id}" class="btn btn-sm btn-outline-primary px-3 rounded-pill fw-bold">View Hub</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${not empty results.categories}">
                        <div class="col-12 mt-5">
                            <h5 class="fw-bold text-secondary border-bottom pb-2 mb-3">
                                <i class="bi bi-folder me-2 text-success"></i>Categories (${results.categories.size()})
                            </h5>
                            <div class="row g-3">
                                <c:forEach var="cat" items="${results.categories}">
                                    <div class="col-md-6 col-lg-4">
                                        <div class="card border-0 shadow-sm result-card bg-white">
                                            <div class="card-body p-3 d-flex align-items-center justify-content-between">
                                                <div class="d-flex align-items-center text-truncate">
                                                    <div class="p-2 badge-category rounded-3 me-3">
                                                        <i class="bi bi-folder2-open fs-4"></i>
                                                    </div>
                                                    <div class="text-truncate">
                                                        <h6 class="mb-0 fw-bold text-dark text-truncate">${cat.name}</h6>
                                                        <span class="small text-muted text-truncate d-block">${cat.description}</span>
                                                    </div>
                                                </div>
                                                <a href="${pageContext.request.contextPath}/category/${cat.id}" class="btn btn-sm btn-light border rounded-circle p-2 ms-2">
                                                    <i class="bi bi-arrow-right-short fs-5 lh-1"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${not empty results.users}">
                        <div class="col-12 mt-5">
                            <h5 class="fw-bold text-secondary border-bottom pb-2 mb-3">
                                <i class="bi bi-person me-2 text-warning"></i>Creators (${results.users.size()})
                            </h5>
                            <div class="row g-3">
                                <c:forEach var="usr" items="${results.users}">
                                    <div class="col-md-6 col-lg-4">
                                        <div class="card border-0 shadow-sm result-card bg-white">
                                            <div class="card-body p-3 d-flex align-items-center">
                                                <div class="p-2 badge-user rounded-circle me-3 d-flex align-items-center justify-content-center" style="width: 45px; height: 45px;">
                                                    <i class="bi bi-person-fill fs-4"></i>
                                                </div>
                                                <div class="flex-grow-1 text-truncate">
                                                    <h6 class="mb-0 fw-bold text-dark text-truncate">${usr.name}</h6>
                                                    <span class="small text-muted d-block text-truncate">${usr.email}</span>
                                                </div>
                                                <a href="${pageContext.request.contextPath}/user/${usr.id}" class="btn btn-sm btn-outline-secondary rounded-pill px-3 fw-bold ms-2">Profile</a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>

                </div>
            </c:otherwise>
        </c:choose>
    </main>

    <footer class="bg-dark text-white text-center py-3 mt-auto border-top border-secondary">
        <div class="container">
            <span class="small text-secondary">&copy; 2026 CheatSheet Hub. All search indexes optimized.</span>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>