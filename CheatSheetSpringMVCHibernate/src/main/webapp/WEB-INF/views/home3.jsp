<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CheatSheet Hub</title>

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
    border-radius:32px;
    background:linear-gradient(135deg,#2563eb,#10b981);
    color:white;
    box-shadow:0 20px 45px rgba(37,99,235,.25);
}

.hero h1{
    font-size:56px;
    margin-bottom:15px;
}

.hero p{
    font-size:18px;
    line-height:1.8;
    max-width:780px;
}

.hero-stats{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(180px,1fr));
    gap:20px;
    margin-top:35px;
}

.stat-card{
    background:rgba(255,255,255,.18);
    border:1px solid rgba(255,255,255,.25);
    padding:24px;
    border-radius:22px;
    backdrop-filter:blur(10px);
}

.stat-card h2{
    font-size:38px;
    margin-bottom:6px;
}

.stat-card span{
    font-weight:700;
    opacity:.95;
}

.section{
    margin-top:60px;
}

.section-head{
    display:flex;
    justify-content:space-between;
    align-items:end;
    gap:20px;
    margin-bottom:25px;
}

.section-title{
    font-size:34px;
    font-weight:900;
}

.section-subtitle{
    color:#64748b;
    margin-top:8px;
}

.grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
    gap:24px;
}

.category-card,
.user-card{
    background:white;
    border-radius:24px;
    padding:28px;
    text-decoration:none;
    color:#1e293b;
    box-shadow:0 12px 30px rgba(15,23,42,.08);
    border:1px solid #e2e8f0;
    transition:.3s;
}

.category-card:hover,
.user-card:hover{
    transform:translateY(-7px);
    box-shadow:0 20px 45px rgba(15,23,42,.14);
}

.category-icon{
    width:58px;
    height:58px;
    border-radius:18px;
    background:linear-gradient(135deg,#2563eb,#10b981);
    color:white;
    display:flex;
    justify-content:center;
    align-items:center;
    font-size:28px;
    margin-bottom:18px;
}

.category-card h3,
.user-card h3{
    font-size:23px;
    margin-bottom:10px;
}

.category-card p,
.user-card p{
    color:#64748b;
    line-height:1.6;
}

.sheet-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(300px,1fr));
    gap:24px;
}

.sheet-card{
    min-height:460px;
    border-radius:26px;
    padding:22px;
    text-decoration:none;
    color:white !important;
    box-shadow:0 14px 35px rgba(0,0,0,.14);
    transition:.3s;
    display:flex;
    flex-direction:column;
}

.sheet-card:hover{
    transform:translateY(-7px);
    box-shadow:0 22px 45px rgba(0,0,0,.22);
}

.sheet-cover{
    height:170px;
    border-radius:18px;
    overflow:hidden;
    background:rgba(0,0,0,.08);
    border:2px dashed rgba(255,255,255,.4);
    display:flex;
    justify-content:center;
    align-items:center;
    font-weight:800;
    margin-bottom:15px;
}

.sheet-cover img{
    width:100%;
    height:100%;
    object-fit:cover;
}

.badge{
    display:inline-block;
    padding:6px 14px;
    border-radius:999px;
    background:rgba(255,255,255,.24);
    font-size:12px;
    font-weight:900;
    margin-bottom:12px;
}

.sheet-card h3{
    font-size:22px;
    line-height:1.35;
    margin-bottom:10px;
}

.sheet-desc{
    color:rgba(255,255,255,.9);
    line-height:1.6;
    max-height:82px;
    overflow:hidden;
}

.sheet-footer{
    margin-top:auto;
    padding-top:13px;
    border-top:1px solid rgba(255,255,255,.25);
    font-size:13px;
    line-height:1.7;
    color:rgba(255,255,255,.9);
}

.empty-box{
    background:white;
    border:2px dashed #cbd5e1;
    color:#64748b;
    padding:28px;
    border-radius:22px;
}

.rank{
    width:42px;
    height:42px;
    border-radius:14px;
    background:#eff6ff;
    color:#2563eb;
    display:flex;
    justify-content:center;
    align-items:center;
    font-weight:900;
    margin-bottom:15px;
}

@media(max-width:768px){
    .hero{
        padding:32px;
    }

    .hero h1{
        font-size:38px;
    }

    .section-head{
        display:block;
    }
}
</style>
</head>

<body>

<jsp:include page="header.jsp"/>

<div class="container">

    <section class="hero">
        <h1>Explore Public Cheatsheets</h1>

        <p>
            Discover useful cheatsheets shared by the community.
            Browse categories, learn faster, and find quick references
            for your study and development work.
        </p>

        <div class="hero-stats">
            <div class="stat-card">
                <h2>${totalCheatsheets}</h2>
                <span>Public Cheatsheets</span>
            </div>

            <div class="stat-card">
                <h2>${totalCategories}</h2>
                <span>Categories</span>
            </div>

            <div class="stat-card">
                <h2>${totalUsers}</h2>
                <span>Active Users</span>
            </div>
        </div>
    </section>

    <section class="section">
        <div class="section-head">
            <div>
                <h2 class="section-title">Explore Categories</h2>
                <p class="section-subtitle">
                    Choose a main category and browse related topics.
                </p>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty parentCategories}">
                <div class="grid">
                    <c:forEach items="${parentCategories}" var="cat">
                        <a href="${pageContext.request.contextPath}/category/${cat.id}"
                           class="category-card">
                            <div class="category-icon">📚</div>

                            <h3>${cat.name}</h3>

                            <p>
                                <c:choose>
                                    <c:when test="${not empty cat.description}">
                                        ${cat.description}
                                    </c:when>
                                    <c:otherwise>
                                        Explore child categories and cheatsheets.
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </a>
                    </c:forEach>
                </div>
            </c:when>

            <c:otherwise>
                <div class="empty-box">
                    No parent categories found.
                </div>
            </c:otherwise>
        </c:choose>
    </section>

    <section class="section">
        <div class="section-head">
            <div>
                <h2 class="section-title">🔥 Popular Cheatsheets</h2>
                <p class="section-subtitle">
                    Most viewed and liked public cheatsheets.
                </p>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty popularCheatsheets}">
                <div class="sheet-grid">
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

                            <span class="badge">
                                ${sheet.category.name}
                            </span>

                            <h3>${sheet.title}</h3>

                            <p class="sheet-desc">
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
                    No popular cheatsheets yet.
                </div>
            </c:otherwise>
        </c:choose>
    </section>

    <section class="section">
        <div class="section-head">
            <div>
                <h2 class="section-title">🆕 Recent Cheatsheets</h2>
                <p class="section-subtitle">
                    Newly published cheatsheets from the community.
                </p>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty recentCheatsheets}">
                <div class="sheet-grid">
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

                            <span class="badge">
                                ${sheet.category.name}
                            </span>

                            <h3>${sheet.title}</h3>

                            <p class="sheet-desc">
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
                    No recent cheatsheets yet.
                </div>
            </c:otherwise>
        </c:choose>
    </section>

    <section class="section">
        <div class="section-head">
            <div>
                <h2 class="section-title">🏆 Top Contributors</h2>
                <p class="section-subtitle">
                    Users with the most public cheatsheets.
                </p>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty topContributors}">
                <div class="grid">
                    <c:forEach items="${topContributors}" var="row" varStatus="st">
                        <div class="user-card">
                            <div class="rank">
                                #${st.index + 1}
                            </div>

                            <h3>
                                ${row[0].name}
                            </h3>

                            <p>
                                ${row[1]} public cheatsheets
                            </p>
                        </div>
                    </c:forEach>
                </div>
            </c:when>

            <c:otherwise>
                <div class="empty-box">
                    No contributors found yet.
                </div>
            </c:otherwise>
        </c:choose>
    </section>

</div>

<jsp:include page="footer.jsp"/>

</body>
</html>