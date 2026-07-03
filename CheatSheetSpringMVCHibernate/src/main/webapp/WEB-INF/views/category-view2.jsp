<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${parentCategory.name}</title>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Segoe UI',sans-serif;
}

body{
    background:#f8fafc;
    color:#1e293b;
}

.container{
    width:95%;
    max-width:1400px;
    margin:auto;
}

.hero{
    margin:30px 0;
    padding:55px;
    border-radius:30px;
    background:linear-gradient(135deg,#2563eb,#10b981);
    color:white;
}

.hero h1{
    font-size:56px;
    margin-bottom:15px;
}

.hero p{
    font-size:19px;
    line-height:1.8;
    max-width:750px;
}

.section-title{
    font-size:42px;
    font-weight:800;
    margin-bottom:10px;
}

.section-subtitle{
    color:#64748b;
    font-size:18px;
    margin-bottom:30px;
}

.child-grid{
    display:flex;
    gap:25px;
    overflow-x:auto;
    overflow-y:hidden;
    padding-bottom:15px;
    scroll-behavior:smooth;
}

.child-grid::-webkit-scrollbar{
    height:10px;
}

.child-grid::-webkit-scrollbar-track{
    background:#dbeafe;
    border-radius:999px;
}

.child-grid::-webkit-scrollbar-thumb{
    background:linear-gradient(90deg,#2563eb,#10b981);
    border-radius:999px;
}

.child-card{
    min-width:280px;
    height:220px;
    flex-shrink:0;
    background:white;
    border-radius:30px;
    padding:30px;
    text-decoration:none;
    border:1px solid #dbeafe;
    box-shadow:0 10px 30px rgba(0,0,0,.08);
    transition:.3s;
    display:flex;
    flex-direction:column;
    justify-content:center;
}

.child-card:hover{
    transform:translateY(-8px);
}

.child-card h3{
    color:#2563eb;
    font-size:32px;
    margin-bottom:15px;
}

.child-card p{
    color:#475569;
    line-height:1.7;
}

.placeholder-section{
    margin-top:80px;
}

.placeholder-card{
    background:white;
    border:2px dashed #cbd5e1;
    border-radius:30px;
    padding:30px;
    min-height:180px;
}

.placeholder-card h3{
    color:#10b981;
    margin-bottom:15px;
}

.placeholder-card p{
    color:#64748b;
    line-height:1.8;
}
</style>
</head>

<body>

<jsp:include page="header.jsp"/>

<div class="container">

    <section class="hero">
        <h1>${parentCategory.name}</h1>

        <p>
            <c:choose>
                <c:when test="${not empty parentCategory.description}">
                    ${parentCategory.description}
                </c:when>
                <c:otherwise>
                    Browse child categories and discover related cheatsheets.
                </c:otherwise>
            </c:choose>
        </p>
    </section>

    <section>

        <h2 class="section-title">
            Child Categories
        </h2>

        <p class="section-subtitle">
            Choose a child category to view tags and cheatsheets.
        </p>

        <div class="child-grid">

            <c:forEach items="${childCategories}" var="child">

                <a href="${pageContext.request.contextPath}/child-category/${child.id}"
                   class="child-card">

                    <h3>${child.name}</h3>

                    <p>
                        <c:choose>
                            <c:when test="${not empty child.description}">
                                ${child.description}
                            </c:when>
                            <c:otherwise>
                                View tags and cheatsheets under this category.
                            </c:otherwise>
                        </c:choose>
                    </p>

                </a>

            </c:forEach>

        </div>

    </section>

    <section class="placeholder-section">

        <h2 class="section-title">
            Popular Cheatsheets
        </h2>

        <div class="placeholder-card">
            <h3>Coming Soon</h3>
            <p>
                Popular cheatsheets from this parent category's child categories
                will appear here later.
            </p>
        </div>

    </section>

</div>

<jsp:include page="footer.jsp"/>

</body>
</html>
