<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Followed Categories</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f8fafc; font-family: 'Segoe UI', sans-serif; color: #1e293b; }
        .page-header { margin-top: 40px; margin-bottom: 30px; }
        .category-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 24px; }
        .category-card { 
            background: #ffffff; border-radius: 20px; border: 1px solid #e2e8f0; 
            padding: 24px; display: flex; align-items: center; gap: 16px; 
            text-decoration: none; color: #1e293b !important;
            box-shadow: 0 4px 15px rgba(15, 23, 42, 0.02);
            transition: transform 0.3s ease, box-shadow 0.3s ease; cursor: pointer;
        }
        .category-card:hover { transform: translateY(-4px); box-shadow: 0 12px 25px rgba(15, 23, 42, 0.08); border-color: #3b82f6; }
        .icon-box { 
            width: 52px; height: 52px; border-radius: 14px; 
            background: #eff6ff; color: #2563eb; 
            display: flex; align-items: center; justify-content: center; font-size: 22px;
        }
        .category-name { font-size: 18px; font-weight: 700; margin: 0; color: #0f172a; }
        .empty-box { background: white; border: 2px dashed #cbd5e1; color: #64748b; padding: 50px; border-radius: 24px; text-align: center; }
    </style>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container">
    
    <div class="d-flex justify-content-between align-items-center page-header">
        <div>
            <h2 class="fw-bold m-0 text-dark">
                <i class="bi bi-grid-fill text-primary me-2"></i> Followed Categories
            </h2>
            <p class="text-muted m-0 mt-1">Quick access to cheatsheets within your favorited topics</p>
        </div>
        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary btn-sm rounded-3 px-3 fw-semibold">
            <i class="bi bi-house-door"></i> Home
        </a>
    </div>

    <c:choose>
        <c:when test="${not empty followedCategories}">
            <div class="category-grid mb-5">
                <c:forEach items="${followedCategories}" var="cat">
                    
                    <a href="${pageContext.request.contextPath}/child-category/${cat.id}" class="category-card">
                        <div class="icon-box">
                            <i class="bi bi-tags-fill"></i>
                        </div>
                        <div>
                            <h3 class="category-name">${cat.name}</h3>
                            <small class="text-muted">View Cheatsheets</small>
                        </div>
                    </a>

                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-box my-4 shadow-sm">
                <i class="bi bi-grid text-muted" style="font-size: 3.5rem;"></i>
                <h4 class="fw-bold mt-3 text-secondary">No Categories Followed</h4>
                <p class="text-muted m-0">Explore topics on Home and click follow to add them here!</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="footer.jsp"/>

</body>
</html>