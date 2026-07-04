<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Category Tree</title>

<style>
body{
    margin:0;
    padding:35px;
    font-family:'Segoe UI', Arial, sans-serif;
    background:linear-gradient(135deg,#f0fdf4,#dcfce7,#ecfdf5);
}

.container{
    max-width:1100px;
    margin:auto;
}

.header{
    background:linear-gradient(135deg,#10b981,#22c55e);
    color:white;
    padding:30px;
    border-radius:22px;
    margin-bottom:25px;
}

.header h1{
    margin:0;
    font-size:36px;
}

.card{
    background:white;
    padding:30px;
    border-radius:22px;
    box-shadow:0 15px 35px rgba(0,0,0,.08);
}

details{
    margin-bottom:14px;
}

summary{
    cursor:pointer;
    list-style:none;
    padding:16px 18px;
    border-radius:14px;
    background:#ecfdf5;
    border:1px solid #bbf7d0;
    font-size:20px;
    font-weight:bold;
    color:#065f46;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

summary::-webkit-details-marker{
    display:none;
}

summary::before{
    content:"▶";
    margin-right:12px;
    color:#059669;
}

details[open] > summary::before{
    content:"▼";
}

.child-box{
    margin-left:35px;
    margin-top:10px;
}

.row{
    padding:12px 16px;
    margin:8px 0;
    border-radius:12px;
    background:#f8fafc;
    border:1px solid #e5e7eb;
    display:flex;
    justify-content:space-between;
    align-items:center;
    font-size:17px;
}

.child-summary{
    background:#eff6ff;
    color:#1e40af;
    border:1px solid #bfdbfe;
}

.actions a{
    text-decoration:none;
    padding:7px 13px;
    border-radius:9px;
    font-size:14px;
    margin-left:6px;
    font-weight:bold;
}

.edit{
    background:#dbeafe;
    color:#1d4ed8;
}

.delete{
    background:#fee2e2;
    color:#dc2626;
}
</style>
</head>

<body>

<div class="container">

    <div class="header">
        <h1>Category List</h1>
    </div>

    <div class="card">

        <c:forEach items="${categories}" var="parent">

            <c:if test="${parent.parent == null}">

                <details>

                    <summary>
                        <span>📁 ${parent.name}</span>

                        <span class="actions">
                            <a class="edit"
                               href="${pageContext.request.contextPath}/admin/category/edit/${parent.id}">
                                Edit
                            </a>

                            <a class="delete"
                               href="${pageContext.request.contextPath}/admin/category/delete/${parent.id}"
                               onclick="return confirm('Delete this category?');">
                                Delete
                            </a>
                        </span>
                    </summary>

                    <div class="child-box">

                        <c:forEach items="${tags}" var="tag">

                            <c:if test="${tag.category.id == parent.id}">

                                <div class="row">
                                    <span>🏷 ${tag.name}</span>

                                    <span class="actions">
                                        <a class="edit"
                                           href="${pageContext.request.contextPath}/admin/tag/edit/${tag.id}">
                                            Edit
                                        </a>

                                        <a class="delete"
                                           href="${pageContext.request.contextPath}/admin/tag/delete/${tag.id}"
                                           onclick="return confirm('Delete this tag?');">
                                            Delete
                                        </a>
                                    </span>
                                </div>

                            </c:if>

                        </c:forEach>

                        <c:forEach items="${categories}" var="child">

                            <c:if test="${child.parent != null && child.parent.id == parent.id}">

                                <details>

                                    <summary class="child-summary">
                                        <span>📂 ${child.name}</span>

                                        <span class="actions">
                                            <a class="edit"
                                               href="${pageContext.request.contextPath}/admin/category/edit/${child.id}">
                                                Edit
                                            </a>

                                            <a class="delete"
                                               href="${pageContext.request.contextPath}/admin/category/delete/${child.id}"
                                               onclick="return confirm('Delete this category?');">
                                                Delete
                                            </a>
                                        </span>
                                    </summary>

                                    <div class="child-box">

                                        <c:forEach items="${tags}" var="tag">

                                            <c:if test="${tag.category.id == child.id}">

                                                <div class="row">
                                                    <span>🏷 ${tag.name}</span>

                                                    <span class="actions">
                                                        <a class="edit"
                                                           href="${pageContext.request.contextPath}/admin/tag/edit/${tag.id}">
                                                            Edit
                                                        </a>

                                                        <a class="delete"
                                                           href="${pageContext.request.contextPath}/admin/tag/delete/${tag.id}"
                                                           onclick="return confirm('Delete this tag?');">
                                                            Delete
                                                        </a>
                                                    </span>
                                                </div>

                                            </c:if>

                                        </c:forEach>

                                    </div>

                                </details>

                            </c:if>

                        </c:forEach>

                    </div>

                </details>

            </c:if>

        </c:forEach>

    </div>

</div>

</body>
</html>