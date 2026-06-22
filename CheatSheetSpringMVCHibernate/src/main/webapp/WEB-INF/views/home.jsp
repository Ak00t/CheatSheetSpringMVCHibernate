
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
    padding:60px;
    border-radius:30px;
    background:linear-gradient(135deg,#2563eb,#10b981);
    color:white;
}

.hero-badge{
    display:inline-block;
    background:#d1fae5;
    color:#065f46;
    padding:10px 18px;
    border-radius:999px;
    font-size:14px;
    font-weight:600;
    margin-bottom:20px;
}

.hero h1{
    font-size:60px;
    margin-bottom:20px;
}

.hero p{
    font-size:20px;
    line-height:1.8;
    max-width:750px;
}

/* ================= SECTION ================= */

.section-title{
    font-size:44px;
    font-weight:800;
    margin-bottom:10px;
}

.section-subtitle{
    color:#64748b;
    font-size:18px;
    margin-bottom:30px;
}

/* ================= CATEGORY ================= */

.category-section{
    margin-top:60px;
}

.category-grid{
    display:flex;
    gap:25px;

    overflow-x:auto;
    overflow-y:hidden;

    padding-bottom:15px;
    scroll-behavior:smooth;
}

.category-grid::-webkit-scrollbar{
    height:10px;
}

.category-grid::-webkit-scrollbar-track{
    background:#dbeafe;
    border-radius:999px;
}

.category-grid::-webkit-scrollbar-thumb{
    background:linear-gradient(90deg,#2563eb,#10b981);
    border-radius:999px;
}

.category-card{
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

.category-card:hover{
    transform:translateY(-8px);
}

.category-card h3{
    color:#2563eb;
    font-size:32px;
    margin-bottom:15px;
}

.category-card p{
    color:#475569;
    line-height:1.7;
}

/* ================= POPULAR ================= */

.placeholder-section{
    margin-top:80px;
}

.placeholder-grid{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:25px;
}

.placeholder-card{
    background:white;
    border:2px dashed #cbd5e1;
    border-radius:30px;
    padding:30px;
    min-height:220px;
}

.placeholder-card h3{
    color:#10b981;
    margin-bottom:15px;
}

.placeholder-card p{
    color:#64748b;
    line-height:1.8;
}

/* ================= MOBILE ================= */

@media(max-width:768px){

    .hero{
        padding:30px;
    }

    .hero h1{
        font-size:38px;
    }

    .placeholder-grid{
        grid-template-columns:1fr;
    }

}

</style>

</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container">

    <!-- HERO -->

    <section class="hero">

        <span class="hero-badge">
            Learn Faster
        </span>

        <h1>
            Explore Public Cheatsheets
        </h1>

        <p>
            Browse cheatsheets by category, discover organized learning notes,
            and find useful references quickly.
        </p>

    </section>

    <!-- CATEGORY -->

    <section class="category-section">

        <h2 class="section-title">
            Browse Categories
        </h2>

        <p class="section-subtitle">
            Choose a category to view public cheatsheets.
        </p>

        <div class="category-grid">

            <c:forEach items="${parentCategories}" var="category">

                <a href="${pageContext.request.contextPath}/category/${category.id}"
                   class="category-card">

                    <h3>${category.name}</h3>

                    <p>

                        <c:choose>

                            <c:when test="${not empty category.description}">
                                ${category.description}
                            </c:when>

                            <c:otherwise>
                                Explore child categories and related cheatsheets.
                            </c:otherwise>

                        </c:choose>

                    </p>

                </a>

            </c:forEach>

        </div>

    </section>

    <!-- POPULAR -->

    <section class="placeholder-section">

        <h2 class="section-title">
            Popular Cheatsheets
        </h2>

        <div class="placeholder-grid">

            <div class="placeholder-card">

                <h3>Coming Soon</h3>

                <p>
                    Popular cheatsheets will appear after rating,
                    view count and recommendation features are completed.
                </p>

            </div>

            <div class="placeholder-card">

                <h3>Featured Content</h3>

                <p>
                    Placeholder card for future popular cheatsheet content.
                </p>

            </div>

            <div class="placeholder-card">

                <h3>Top Rated</h3>

                <p>
                    Rating based cheatsheets will be displayed here later.
                </p>

            </div>

        </div>

    </section>

    <!-- RECENT -->

    <section class="placeholder-section">

        <h2 class="section-title">
            Recent Cheatsheets
        </h2>

        <div class="placeholder-grid">

            <div class="placeholder-card">

                <h3>Recent #1</h3>

                <p>
                    Latest public cheatsheet placeholder.
                </p>

            </div>

            <div class="placeholder-card">

                <h3>Recent #2</h3>

                <p>
                    Latest public cheatsheet placeholder.
                </p>

            </div>

            <div class="placeholder-card">

                <h3>Recent #3</h3>

                <p>
                    Latest public cheatsheet placeholder.
                </p>

            </div>

        </div>

    </section>

</div>

<jsp:include page="footer.jsp"/>

</body>
</html>
