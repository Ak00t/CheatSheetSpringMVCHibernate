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
    max-width:1450px;
    margin:auto;
}

.hero{
    margin:30px 0;
    padding:58px;
    border-radius:34px;
    background:
        radial-gradient(circle at top right,rgba(255,255,255,.24),transparent 34%),
        linear-gradient(135deg,#2563eb,#10b981);
    color:white;
    box-shadow:0 22px 48px rgba(37,99,235,.22);
}

.hero h1{
    font-size:56px;
    margin-bottom:15px;
}

.hero p{
    font-size:19px;
    line-height:1.8;
    max-width:780px;
}

.stats-row{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:20px;
    margin:25px 0 45px;
}

.stat-card{
    background:white;
    border-radius:24px;
    padding:25px;
    box-shadow:0 12px 30px rgba(15,23,42,.08);
    border:1px solid #e2e8f0;
}

.stat-card h2{
    font-size:36px;
    color:#2563eb;
}

.stat-card p{
    color:#64748b;
    font-weight:800;
}

.page-layout{
    display:grid;
    grid-template-columns:minmax(0,1fr) 340px;
    gap:30px;
    align-items:start;
}

.section{
    margin-bottom:58px;
}

.section-title{
    font-size:38px;
    font-weight:900;
    margin-bottom:10px;
}

.section-subtitle{
    color:#64748b;
    font-size:17px;
    margin-bottom:26px;
}

/* Child Categories */
.child-grid{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:24px;
}

.child-card{
    position:relative;
    min-height:220px;
    background:white;
    border-radius:30px;
    padding:30px;
    text-decoration:none;
    color:#1e293b;
    border:1px solid #e2e8f0;
    box-shadow:0 12px 30px rgba(15,23,42,.07);
    transition:.3s;
    overflow:hidden;
    display:flex;
    flex-direction:column;
    justify-content:space-between;
}

.child-card::before{
    content:'';
    position:absolute;
    width:190px;
    height:190px;
    right:-75px;
    bottom:-75px;
    border-radius:50%;
    background:radial-gradient(circle,#dbeafe,#ffffff);
    opacity:.9;
}

.child-card:hover{
    transform:translateY(-8px);
    box-shadow:0 22px 45px rgba(15,23,42,.12);
}

.child-card h3{
    position:relative;
    z-index:2;
    color:#2563eb;
    font-size:30px;
    font-weight:900;
    margin-bottom:15px;
}

.child-card p{
    position:relative;
    z-index:2;
    color:#475569;
    line-height:1.7;
}

.child-open{
    position:relative;
    z-index:2;
    color:#0f766e;
    font-weight:900;
    margin-top:20px;
}

/* Cheatsheet Cards */
.sheet-grid{
    display:grid;
    grid-template-columns:repeat(2,minmax(0,1fr));
    gap:24px;
}

.sheet-card{
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

/* Sidebar */
.sidebar{
    position:sticky;
    top:20px;
}

.sidebar-card{
    background:white;
    border-radius:26px;
    padding:24px;
    margin-bottom:24px;
    border:1px solid #e2e8f0;
    box-shadow:0 14px 35px rgba(15,23,42,.08);
}

.sidebar-card h3{
    font-size:22px;
    margin-bottom:18px;
}

.quick-item{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:14px 0;
    border-bottom:1px solid #e2e8f0;
    color:#475569;
    font-weight:800;
}

.quick-item:last-child{
    border-bottom:none;
}

.quick-value{
    color:#2563eb;
    font-size:20px;
    font-weight:900;
}

.sidebar-scroll-box{
    max-height:350px;
    overflow-y:auto;
    padding-right:6px;
    scroll-behavior:smooth;
}

.sidebar-scroll-box::-webkit-scrollbar{
    width:6px;
}

.sidebar-scroll-box::-webkit-scrollbar-thumb{
    background:#cbd5e1;
    border-radius:999px;
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
    width:78px;
    height:62px;
    border-radius:14px;
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
    margin-top:5px;
    font-size:12px;
    color:#64748b;
}

.side-chip-list{
    display:flex;
    flex-wrap:wrap;
    gap:10px;
}

.side-chip{
    padding:10px 14px;
    border-radius:999px;
    background:#eff6ff;
    color:#2563eb;
    text-decoration:none;
    font-weight:800;
    font-size:13px;
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

.empty-box{
    background:white;
    border:2px dashed #cbd5e1;
    border-radius:26px;
    padding:30px;
    color:#64748b;
}

@media(max-width:1150px){
    .page-layout{
        grid-template-columns:1fr;
    }

    .sidebar{
        position:static;
    }

    .child-grid{
        grid-template-columns:repeat(2,1fr);
    }
}

@media(max-width:768px){
    .hero{
        padding:32px;
    }

    .hero h1{
        font-size:38px;
    }

    .stats-row{
        grid-template-columns:1fr;
    }

    .child-grid,
    .sheet-grid{
        grid-template-columns:1fr;
    }
}


#quickTopicSidebar .mini-card{
    background:#f8fafc;
    border:1px solid #e2e8f0;
    border-radius:16px;
    padding:14px;
    margin-bottom:12px;
    transition:.2s;
}

#quickTopicSidebar .mini-card:hover{
    background:#eff6ff;
    transform:translateX(4px);
}

.side-chip-scroll-box{
    max-height:230px;
    overflow-y:auto;
    padding-right:6px;
    scroll-behavior:smooth;
}

.side-chip-scroll-box::-webkit-scrollbar{
    width:6px;
}

.side-chip-scroll-box::-webkit-scrollbar-thumb{
    background:#cbd5e1;
    border-radius:999px;
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

    <div class="page-layout">

        <main>
<%-- 
            <section class="section">

                <h2 class="section-title">
                    Explore Topics
                </h2>

                <p class="section-subtitle">
                    Choose a topic to view tags and public cheatsheets.
                </p>

                <c:choose>
                    <c:when test="${not empty childCategories}">
                        <div class="child-grid">

                            <c:forEach items="${childCategories}" var="child">

                                <a href="${pageContext.request.contextPath}/child-category/${child.id}"
                                   class="child-card">

                                    <div>
                                        <h3>${child.name}</h3>

                                        <p>
                                            <c:choose>
                                                <c:when test="${not empty child.description}">
                                                    ${child.description}
                                                </c:when>
                                                <c:otherwise>
                                                    View tags and cheatsheets under this topic.
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>

                                    <div class="child-open">
                                        Explore
                                    </div>

                                </a>

                            </c:forEach>

                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="empty-box">
                            No topics found.
                        </div>
                    </c:otherwise>
                </c:choose>

            </section>
 --%>
            <section class="section">

                <h2 class="section-title">
                    🔥 Popular in ${parentCategory.name}
                </h2>

                <p class="section-subtitle">
                    Popular cheatsheets from topics under ${parentCategory.name}.
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

        </main>

        <aside class="sidebar">

          <%--   <div class="sidebar-card">
                <h3>📊 Overview</h3>
                
                

                <div class="quick-item">
                    <span>Categories</span>
                    <span class="quick-value">${childCount}</span>
                </div>
                
                
                

                <div class="quick-item">
                    <span>Popular</span>
                    <span class="quick-value">${popularCheatsheets.size()}</span>
                </div>

                <div class="quick-item">
                    <span>Recent</span>
                    <span class="quick-value">${recentCheatsheets.size()}</span>
                </div>
            </div>
 --%>
            <%-- <div class="sidebar-card">
                <h3>🧭 Quick Topics</h3>

                <c:choose>
                    <c:when test="${not empty childCategories}">
                        <div class="side-chip-list">
                            <c:forEach items="${childCategories}" var="child">
                                <a href="${pageContext.request.contextPath}/child-category/${child.id}"
                                   class="side-chip">
                                    ${child.name}
                                </a>
                            </c:forEach>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="empty-box">
                            No topics.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div> --%>
            
           
            
            <%-- 
            <div class="sidebar-card">
    <h3>🧭 Quick Categories</h3>

    <c:choose>
        <c:when test="${not empty childCategories}">

            <div id="quickTopicSidebar" class="sidebar-scroll-box">

                <c:forEach items="${childCategories}" var="child">

                    <a href="${pageContext.request.contextPath}/child-category/${child.id}"
                       class="mini-card">

                        <div>
                            <div class="mini-title">
                                ${child.name}
                            </div>

                            <div class="mini-meta">
                                View tags and cheatsheets
                            </div>
                        </div>

                    </a>

                </c:forEach>

            </div>

            <div class="scroll-controls">
                <button type="button"
                        class="scroll-btn"
                        onclick="scrollBox('quickTopicSidebar', -150)">
                    ▲
                </button>

                <button type="button"
                        class="scroll-btn"
                        onclick="scrollBox('quickTopicSidebar', 150)">
                    ▼
                </button>
            </div>

        </c:when>

        <c:otherwise>
            <div class="empty-box">
                No topics.
            </div>
        </c:otherwise>
    </c:choose>
</div> --%>
<div class="sidebar-card">
    <h3>🧭 Quick Topics</h3>

    <c:choose>
        <c:when test="${not empty childCategories}">

            <div id="quickTopicSidebar"
                 class="side-chip-scroll-box">

                <div class="side-chip-list">
                    <c:forEach items="${childCategories}" var="child">
                        <a href="${pageContext.request.contextPath}/child-category/${child.id}"
                           class="side-chip">
                            ${child.name}
                        </a>
                    </c:forEach>
                </div>

            </div>

            <div class="scroll-controls">
                <button type="button"
                        class="scroll-btn"
                        onclick="scrollBox('quickTopicSidebar', -120)">
                    ▲
                </button>

                <button type="button"
                        class="scroll-btn"
                        onclick="scrollBox('quickTopicSidebar', 120)">
                    ▼
                </button>
            </div>

        </c:when>

        <c:otherwise>
            <div class="empty-box">
                No topics.
            </div>
        </c:otherwise>
    </c:choose>
</div>




            

            <div class="sidebar-card">
                <h3>🔥 Popular Picks</h3>

                <c:choose>
                    <c:when test="${not empty popularCheatsheets}">
                        <div id="popularSidebar" class="sidebar-scroll-box">

                            <c:forEach items="${popularCheatsheets}" var="sheet">
                                <a href="${pageContext.request.contextPath}/cheatsheet/${sheet.id}"
                                   class="mini-card">

                                    <div class="mini-img">
                                        <c:choose>
                                            <c:when test="${not empty sheet.mediaList}">
                                                <img src="${sheet.mediaList[0].mediaUrl}"
                                                     alt="${sheet.title}">
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
                                            👁 ${sheet.viewCount}
                                            &nbsp; ❤ ${sheet.likeCount}
                                        </div>
                                    </div>

                                </a>
                            </c:forEach>

                        </div>

                        <div class="scroll-controls">
                            <button type="button"
                                    class="scroll-btn"
                                    onclick="scrollBox('popularSidebar', -150)">
                                ▲
                            </button>

                            <button type="button"
                                    class="scroll-btn"
                                    onclick="scrollBox('popularSidebar', 150)">
                                ▼
                            </button>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="empty-box">
                            No popular items.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="sidebar-card">
                <h3>🆕 Latest</h3>

                <c:choose>
                    <c:when test="${not empty recentCheatsheets}">
                        <div id="recentSidebar" class="sidebar-scroll-box">

                            <c:forEach items="${recentCheatsheets}" var="sheet">
                                <a href="${pageContext.request.contextPath}/cheatsheet/${sheet.id}"
                                   class="mini-card">

                                    <div class="mini-img">
                                        <c:choose>
                                            <c:when test="${not empty sheet.mediaList}">
                                                <img src="${sheet.mediaList[0].mediaUrl}"
                                                     alt="${sheet.title}">
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
                            <button type="button"
                                    class="scroll-btn"
                                    onclick="scrollBox('recentSidebar', -150)">
                                ▲
                            </button>

                            <button type="button"
                                    class="scroll-btn"
                                    onclick="scrollBox('recentSidebar', 150)">
                                ▼
                            </button>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="empty-box">
                            No recent items.
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
