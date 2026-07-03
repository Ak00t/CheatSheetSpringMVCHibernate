<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
    box-shadow:0 20px 45px rgba(37,99,235,.22);
}

.hero h1{
    font-size:54px;
    margin-bottom:15px;
}

.hero p{
    font-size:18px;
    line-height:1.8;
    max-width:820px;
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
}

.stat-card h2{
    font-size:38px;
    margin-bottom:6px;
}

.page-layout{
    display:grid;
    grid-template-columns:1fr 330px;
    gap:28px;
    align-items:start;
    margin-top:45px;
}

.section{
    margin-bottom:55px;
}

.section-title{
    font-size:34px;
    font-weight:900;
    margin-bottom:8px;
}

.section-subtitle{
    color:#64748b;
    margin-bottom:25px;
}

.category-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
    gap:24px;
}

.category-card{
    min-height:220px;
    border-radius:28px;
    padding:30px;
    text-decoration:none;
    color:white;
    display:flex;
    flex-direction:column;
    justify-content:space-between;
    box-shadow:0 15px 35px rgba(0,0,0,.14);
    transition:.3s;
}

.category-card:hover{
    transform:translateY(-8px);
}

.gradient-0{background:linear-gradient(135deg,#2563eb,#06b6d4);}
.gradient-1{background:linear-gradient(135deg,#9333ea,#ec4899);}
.gradient-2{background:linear-gradient(135deg,#f97316,#ef4444);}
.gradient-3{background:linear-gradient(135deg,#10b981,#22c55e);}
.gradient-4{background:linear-gradient(135deg,#4f46e5,#8b5cf6);}
.gradient-5{background:linear-gradient(135deg,#0f172a,#475569);}

.category-card h3{
    font-size:34px;
    margin-bottom:14px;
}

.category-card p{
    line-height:1.7;
    opacity:.95;
}

.category-count{
    margin-top:25px;
    font-weight:900;
    opacity:.95;
}

.sheet-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(290px,1fr));
    gap:24px;
}

.sheet-card{
    min-height:440px;
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
}

.sheet-cover{
    height:165px;
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
    align-self:flex-start;
}

.sheet-card h3{
    font-size:21px;
    line-height:1.35;
    margin-bottom:10px;
}

.sheet-desc{
    color:rgba(255,255,255,.9);
    line-height:1.6;
    max-height:80px;
    overflow:hidden;
}

.sheet-footer{
    margin-top:auto;
    padding-top:13px;
    border-top:1px solid rgba(255,255,255,.25);
    font-size:13px;
    line-height:1.7;
}

.sidebar-card{
    background:white;
    border-radius:24px;
    padding:24px;
    margin-bottom:24px;
    box-shadow:0 12px 30px rgba(15,23,42,.08);
    border:1px solid #e2e8f0;
}

.sidebar-card h3{
    font-size:22px;
    margin-bottom:20px;
}

.sidebar-scroll-box{
    max-height:330px;
    overflow-y:auto;
    scroll-behavior:smooth;
    padding-right:6px;
}

.sidebar-scroll-box::-webkit-scrollbar{
    width:6px;
}

.sidebar-scroll-box::-webkit-scrollbar-thumb{
    background:#cbd5e1;
    border-radius:999px;
}

.scroll-controls{
    display:flex;
    gap:10px;
    margin-top:14px;
}

.scroll-btn{
    flex:1;
    border:none;
    padding:10px;
    border-radius:12px;
    background:#eff6ff;
    color:#2563eb;
    font-weight:900;
    cursor:pointer;
}

.author-item{
    display:flex;
    gap:14px;
    align-items:center;
    padding:14px 0;
    border-bottom:1px solid #e2e8f0;
    text-decoration:none;
    color:#1e293b;
}

.avatar{
    width:48px;
    height:48px;
    border-radius:50%;
    background:linear-gradient(135deg,#2563eb,#10b981);
    color:white;
    display:flex;
    justify-content:center;
    align-items:center;
    font-weight:900;
    overflow:hidden;
}

.avatar img{
    width:100%;
    height:100%;
    object-fit:cover;
}

.author-name{
    font-weight:900;
}

.author-count{
    color:#64748b;
    font-size:13px;
    margin-top:3px;
}

.mini-card{
    display:flex;
    gap:12px;
    text-decoration:none;
    color:#1e293b;
    margin-bottom:16px;
    align-items:center;
}

.mini-img{
    width:72px;
    height:58px;
    border-radius:12px;
    overflow:hidden;
    background:#e2e8f0;
    flex-shrink:0;
}

.mini-img img{
    width:100%;
    height:100%;
    object-fit:cover;
}

.mini-title{
    font-size:14px;
    font-weight:900;
    line-height:1.4;
}

.mini-meta{
    margin-top:4px;
    font-size:12px;
    color:#64748b;
}

.empty-box{
    background:white;
    border:2px dashed #cbd5e1;
    color:#64748b;
    padding:25px;
    border-radius:20px;
}

@media(max-width:950px){
    .page-layout{
        grid-template-columns:1fr;
    }
}

@media(max-width:768px){
    .hero{
        padding:32px;
    }

    .hero h1{
        font-size:38px;
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
                <span>Community Members</span>
            </div>
        </div>
    </section>

    <div class="page-layout">

        <main>

            <section class="section">
                <h2 class="section-title">Explore Categories</h2>
                <p class="section-subtitle">
                    Choose a main category and browse related topics.
                </p>

                <c:choose>
                    <c:when test="${not empty parentCategories}">
                        <div class="category-grid">
                            <c:forEach items="${parentCategories}" var="cat" varStatus="st">
                                <a href="${pageContext.request.contextPath}/category/${cat.id}"
                                   class="category-card gradient-${st.index % 6}">

                                    <div>
                                        <h3>${cat.name}</h3>

                                        <p>
                                            <c:choose>
                                                <c:when test="${not empty cat.description}">
                                                    ${cat.description}
                                                </c:when>
                                                <c:otherwise>
                                                    Explore related topics and public cheatsheets.
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>

                                    <div class="category-count">
                                        Explore →
                                    </div>

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
                <h2 class="section-title">🔥 Popular Cheatsheets</h2>
                <p class="section-subtitle">
                    Most viewed and liked public cheatsheets.
                </p>

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
                                                <img src="${sheet.mediaList[0].mediaUrl}" alt="${sheet.title}">
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

        </main>

        <aside>

            <div class="sidebar-card">
                <h3>🏆 Top Contributors</h3>

                <c:choose>
                    <c:when test="${not empty topContributors}">
                        <div id="authorSidebar" class="sidebar-scroll-box">
                            <c:forEach items="${topContributors}" var="row">
                                <a href="${pageContext.request.contextPath}/profile/${row[0].id}"
                                   class="author-item">

                                    <div class="avatar">
                                        <c:choose>
                                            <c:when test="${not empty row[0].profileImg}">
                                                <img src="${row[0].profileImg}" alt="${row[0].name}">
                                            </c:when>
                                            <c:otherwise>
                                                ${row[0].name.substring(0,1)}
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div>
                                        <div class="author-name">
                                            ${row[0].name}
                                        </div>
                                        <div class="author-count">
                                            ${row[1]} public cheatsheets
                                        </div>
                                    </div>

                                </a>
                            </c:forEach>
                        </div>

                        <div class="scroll-controls">
                            <button type="button" class="scroll-btn"
                                    onclick="scrollBox('authorSidebar', -160)">
                                ▲
                            </button>

                            <button type="button" class="scroll-btn"
                                    onclick="scrollBox('authorSidebar', 160)">
                                ▼
                            </button>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="empty-box">
                            No contributors found.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="sidebar-card">
                <h3>🆕 Recent Cheatsheets</h3>

                <c:choose>
                    <c:when test="${not empty recentCheatsheets}">
                        <div id="recentSidebar" class="sidebar-scroll-box">
                            <c:forEach items="${recentCheatsheets}" var="sheet">
                                <a href="${pageContext.request.contextPath}/cheatsheet/${sheet.id}"
                                   class="mini-card">

                                    <div class="mini-img">
                                        <c:choose>
                                            <c:when test="${not empty sheet.mediaList}">
                                                <img src="${sheet.mediaList[0].mediaUrl}" alt="${sheet.title}">
                                            </c:when>
                                            <c:otherwise>
                                                <div></div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div>
                                        <div class="mini-title">
                                            ${sheet.title}
                                        </div>

                                        <div class="mini-meta">
                                            👤 ${sheet.user.name}
                                        </div>
                                    </div>

                                </a>
                            </c:forEach>
                        </div>

                        <div class="scroll-controls">
                            <button type="button" class="scroll-btn"
                                    onclick="scrollBox('recentSidebar', -160)">
                                ▲
                            </button>

                            <button type="button" class="scroll-btn"
                                    onclick="scrollBox('recentSidebar', 160)">
                                ▼
                            </button>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="empty-box">
                            No recent cheatsheets yet.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

        </aside>

    </div>

</div>

<jsp:include page="footer.jsp"/>

<script>
function scrollBox(id, amount){
    const box = document.getElementById(id);

    if(box){
        box.scrollBy({
            top:amount,
            behavior:"smooth"
        });
    }
}
</script>

</body>
</html>