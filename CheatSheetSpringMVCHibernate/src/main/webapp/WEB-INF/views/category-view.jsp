<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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

.stats-row{
    display:flex;
    gap:20px;
    margin:25px 0 55px;
}

.stat-card{
    flex:1;
    background:white;
    border-radius:22px;
    padding:24px;
    box-shadow:0 10px 28px rgba(15,23,42,.08);
    border:1px solid #e2e8f0;
}

.stat-card h2{
    font-size:34px;
    color:#2563eb;
}

.stat-card p{
    color:#64748b;
    font-weight:700;
}

.section{
    margin-top:65px;
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

.child-grid::-webkit-scrollbar,
.sheet-scroll::-webkit-scrollbar{
    height:10px;
}

.child-grid::-webkit-scrollbar-track,
.sheet-scroll::-webkit-scrollbar-track{
    background:#dbeafe;
    border-radius:999px;
}

.child-grid::-webkit-scrollbar-thumb,
.sheet-scroll::-webkit-scrollbar-thumb{
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

.sheet-scroll{
    display:flex;
    gap:24px;
    overflow-x:auto;
    overflow-y:hidden;
    padding-bottom:18px;
    scroll-behavior:smooth;
}

.sheet-card{
    flex:0 0 360px;
    min-height:470px;
    border-radius:28px;
    overflow:hidden;
    text-decoration:none;
    color:white !important;
    box-shadow:0 14px 35px rgba(0,0,0,.14);
    transition:.3s;
    padding:22px;
    display:flex;
    flex-direction:column;
}

.sheet-card:hover{
    transform:translateY(-7px);
    box-shadow:0 22px 45px rgba(0,0,0,.22);
}

.sheet-cover{
    width:100%;
    height:180px;
    border:2px dashed rgba(255,255,255,.45);
    border-radius:18px;
    display:flex;
    justify-content:center;
    align-items:center;
    color:white;
    font-size:18px;
    font-weight:800;
    overflow:hidden;
    background:rgba(0,0,0,.06);
    flex-shrink:0;
    margin-bottom:14px;
}

.sheet-cover img{
    width:100%;
    height:100%;
    object-fit:cover;
}

.category-badge{
    display:inline-block;
    padding:6px 14px;
    border-radius:999px;
    background:rgba(255,255,255,.25);
    color:white;
    font-size:12px;
    font-weight:900;
    margin-bottom:12px;
    align-self:flex-start;
}

.sheet-title{
    font-size:22px;
    color:white;
    margin-bottom:8px;
    font-weight:900;
    line-height:1.35;
}

.sheet-description{
    color:rgba(255,255,255,.92);
    line-height:1.55;
    max-height:95px;
    overflow:hidden;
    font-size:15px;
}

.sheet-footer{
    margin-top:auto;
    padding-top:12px;
    border-top:1px solid rgba(255,255,255,.25);
    color:rgba(255,255,255,.9);
    font-size:13px;
    line-height:1.7;
}

.empty-box{
    background:white;
    border:2px dashed #cbd5e1;
    border-radius:26px;
    padding:30px;
    color:#64748b;
}

@media(max-width:768px){
    .hero{
        padding:32px;
    }

    .hero h1{
        font-size:38px;
    }

    .stats-row{
        flex-direction:column;
    }

    .sheet-card{
        flex-basis:310px;
    }
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

    <div class="stats-row">
        <div class="stat-card">
            <h2>${childCount}</h2>
            <p>Categories</p>
        </div>

        <div class="stat-card">
            <h2>${popularCheatsheets.size()}</h2>
            <p>Popular Cheatsheets</p>
        </div>

        <div class="stat-card">
            <h2>${recentCheatsheets.size()}</h2>
            <p>Recent Cheatsheets</p>
        </div>
    </div>

    <section class="section">

        <h2 class="section-title">
            Child Categories
        </h2>

        <p class="section-subtitle">
            Choose a child category to view tags and cheatsheets.
        </p>

        <c:choose>
            <c:when test="${not empty childCategories}">
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
            </c:when>

            <c:otherwise>
                <div class="empty-box">
                    No child categories found.
                </div>
            </c:otherwise>
        </c:choose>

    </section>

    <section class="section">

        <h2 class="section-title">
            🔥 Popular in ${parentCategory.name}
        </h2>

        <p class="section-subtitle">
            Popular cheatsheets from child categories under ${parentCategory.name}.
        </p>

        <c:choose>
            <c:when test="${not empty popularCheatsheets}">
                <div class="sheet-scroll">

                    <c:forEach items="${popularCheatsheets}" var="sheet">

                        <a href="${pageContext.request.contextPath}/cheatsheet/${sheet.id}"
                           class="sheet-card"
                           style="background-color:${not empty sheet.themeColor ? sheet.themeColor : '#2563eb'};">

                            <div class="sheet-cover">
                                <c:choose>
                                    <c:when test="${not empty sheet.mediaList}">
                                        <img src="${sheet.mediaList[0].mediaUrl}"
                                             alt="${sheet.title}">
                                    </c:when>
                                    <c:otherwise>
                                        No Cover
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="category-badge">
                                ${sheet.category.name}
                            </div>

                            <h3 class="sheet-title">
                                ${sheet.title}
                            </h3>

                            <p class="sheet-description">
                                ${sheet.description}
                            </p>

                            <div class="sheet-footer">
                                👤 ${sheet.user.name}
                                <br>
                                👁 ${sheet.viewCount}
                                &nbsp; ❤ ${sheet.likeCount}
                                &nbsp; 🔖 ${sheet.bookmarkCount}
                            </div>

                        </a>

                    </c:forEach>

                </div>
            </c:when>

            <c:otherwise>
                <div class="empty-box">
                    No popular cheatsheets found.
                </div>
            </c:otherwise>
        </c:choose>

    </section>

    <section class="section">

        <h2 class="section-title">
            🆕 Recent in ${parentCategory.name}
        </h2>

        <p class="section-subtitle">
            Recently published cheatsheets from this parent category.
        </p>

        <c:choose>
            <c:when test="${not empty recentCheatsheets}">
                <div class="sheet-scroll">

                    <c:forEach items="${recentCheatsheets}" var="sheet">

                        <a href="${pageContext.request.contextPath}/cheatsheet/${sheet.id}"
                           class="sheet-card"
                           style="background-color:${not empty sheet.themeColor ? sheet.themeColor : '#10b981'};">

                            <div class="sheet-cover">
                                <c:choose>
                                    <c:when test="${not empty sheet.mediaList}">
                                        <img src="${sheet.mediaList[0].mediaUrl}"
                                             alt="${sheet.title}">
                                    </c:when>
                                    <c:otherwise>
                                        No Cover
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="category-badge">
                                ${sheet.category.name}
                            </div>

                            <h3 class="sheet-title">
                                ${sheet.title}
                            </h3>

                            <p class="sheet-description">
                                ${sheet.description}
                            </p>

                            <div class="sheet-footer">
                                👤 ${sheet.user.name}
                                <br>
                                🗓
                                <fmt:parseDate
                                        value="${sheet.createdAt}"
                                        pattern="yyyy-MM-dd'T'HH:mm:ss"
                                        var="createdDate"/>

                                <fmt:formatDate
                                        value="${createdDate}"
                                        pattern="dd MMM yyyy"/>
                            </div>

                        </a>

                    </c:forEach>

                </div>
            </c:when>

            <c:otherwise>
                <div class="empty-box">
                    No recent cheatsheets found.
                </div>
            </c:otherwise>
        </c:choose>

    </section>

</div>

<jsp:include page="footer.jsp"/>

</body>
</html>