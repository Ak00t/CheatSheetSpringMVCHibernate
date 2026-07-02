<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${childCategory.name}</title>

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
    font-size:54px;
    margin-bottom:15px;
}

.hero p{
    font-size:18px;
    line-height:1.8;
    max-width:750px;
}

.section{
    margin-top:55px;
}

.section-title{
    font-size:38px;
    font-weight:800;
    margin-bottom:12px;
}

.section-subtitle{
    color:#64748b;
    margin-bottom:25px;
    font-size:17px;
}

.tag-scroll,
.sheet-scroll{
    display:flex;
    gap:18px;
    overflow-x:auto;
    overflow-y:hidden;
    padding-bottom:18px;
    scroll-behavior:smooth;
}

.tag-scroll::-webkit-scrollbar,
.sheet-scroll::-webkit-scrollbar{
    height:10px;
}

.tag-scroll::-webkit-scrollbar-track,
.sheet-scroll::-webkit-scrollbar-track{
    background:#dbeafe;
    border-radius:999px;
}

.tag-scroll::-webkit-scrollbar-thumb,
.sheet-scroll::-webkit-scrollbar-thumb{
    background:linear-gradient(90deg,#2563eb,#10b981);
    border-radius:999px;
}

.tag-card{
    flex:0 0 auto;
    padding:14px 24px;
    border-radius:999px;
    background:white;
    color:#2563eb;
    text-decoration:none;
    font-weight:700;
    border:1px solid #bfdbfe;
    box-shadow:0 8px 20px rgba(0,0,0,.06);
}

.sheet-card{
    flex:0 0 380px;
    border-radius:28px;
    overflow:hidden;
    text-decoration:none;
    color:white !important;
    border:1px solid rgba(255,255,255,0.2);
    box-shadow:0 14px 35px rgba(0,0,0,.12);
    transition:.3s;
    padding:24px;
    display:flex;
    flex-direction:column;
    height:500px;
}

.sheet-card:hover{
    transform:translateY(-6px);
    box-shadow:0 20px 40px rgba(0,0,0,.2);
}

.sheet-cover{
    width:100%;
    height:180px;
    border:2px dashed rgba(255,255,255,0.4);
    border-radius:18px;
    display:flex;
    justify-content:center;
    align-items:center;
    color:white;
    font-size:22px;
    font-weight:800;
    overflow:hidden;
    background:rgba(0,0,0,0.05);
    flex-shrink:0;
}

.sheet-cover img{
    width:100%;
    height:100%;
    object-fit:cover;
}

.sheet-body{
    padding:12px 0 0 0;
    display:flex;
    flex-direction:column;
    flex-grow:1;
    overflow:hidden;
}

.category-badge{
    display:inline-block;
    padding:5px 15px;
    border-radius:999px;
    background:rgba(255,255,255,0.2);
    color:white;
    font-size:13px;
    font-weight:800;
    margin-bottom:12px;
    align-self:flex-start;
}

.sheet-title{
    font-size:24px;
    color:white;
    margin-bottom:8px;
    font-weight:800;
}

.sheet-description{
    color:rgba(255,255,255,0.9);
    line-height:1.6;
    max-height:100px;
    overflow:hidden;
}

.see-btn{
    display:inline-block;
    margin-top:5px;
    color:white;
    text-decoration:underline;
    font-weight:800;
    cursor:pointer;
}

.sheet-footer{
    margin-top:auto;
    padding-top:12px;
    border-top:1px solid rgba(255,255,255,0.2);
    color:rgba(255,255,255,0.8);
    font-size:13px;
    line-height:1.6;
}

.creator-link{
    color:white;
    text-decoration:none;
    font-weight:800;
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
        padding:30px;
    }

    .hero h1{
        font-size:36px;
    }

    .sheet-card{
        flex-basis:320px;
    }
}
</style>
</head>

<body>

<jsp:include page="header.jsp"/>

<div class="container">

    <section class="hero">
        <h1>${childCategory.name}</h1>

        <p>
            <c:choose>
                <c:when test="${not empty childCategory.description}">
                    ${childCategory.description}
                </c:when>

                <c:otherwise>
                    Browse tags and cheatsheets under this category.
                </c:otherwise>
            </c:choose>
        </p>
    </section>

    <section class="section">
        <h2 class="section-title">Tags</h2>
        <p class="section-subtitle">Explore tags under ${childCategory.name}.</p>

        <c:choose>
            <c:when test="${not empty tags}">
                <div class="tag-scroll">

                    <c:forEach items="${tags}" var="tag">
                        <a href="${pageContext.request.contextPath}/tag/${tag.id}" class="tag-card">
                            #${tag.name}
                        </a>
                    </c:forEach>

                </div>
            </c:when>

            <c:otherwise>
                <div class="empty-box">
                    No tags found for this category.
                </div>
            </c:otherwise>
        </c:choose>
    </section>

    <section class="section">
        <h2 class="section-title">Cheatsheets</h2>
        <p class="section-subtitle">Public cheatsheets from ${childCategory.name}.</p>

        <c:choose>
            <c:when test="${not empty cheatsheets}">
                <div class="sheet-scroll">

                    <c:forEach items="${cheatsheets}" var="sheet">

                        <a href="${pageContext.request.contextPath}/cheatsheet/${sheet.id}"
                           class="sheet-card"
                           style="background-color:${sheet.themeColor};">

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

                            <div class="sheet-body">

                                <div class="category-badge">
                                    ${sheet.category.name}
                                </div>

                                <h3 class="sheet-title">
                                    ${sheet.title}
                                </h3>

                                <p class="sheet-description">
                                    ${sheet.description}
                                </p>

                                <span class="see-btn">
                                    See More
                                </span>

                                <div class="sheet-footer">
                                    Created By:
                                    <span class="creator-link">
                                        ${sheet.user.name}
                                    </span>

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

                            </div>
                        </a>

                    </c:forEach>

                </div>
            </c:when>

            <c:otherwise>
                <div class="empty-box">
                    No published cheatsheets found for this category.
                </div>
            </c:otherwise>
        </c:choose>
    </section>

</div>

<jsp:include page="footer.jsp"/>

<script>
document.querySelectorAll(".see-btn").forEach(function(btn){

    btn.addEventListener("click", function(e){
        e.preventDefault();
        e.stopPropagation();

        const desc = this.previousElementSibling;

        if(desc.style.maxHeight === "none"){
            desc.style.maxHeight = "100px";
            this.innerText = "See More";
        }else{
            desc.style.maxHeight = "none";
            this.innerText = "See Less";
        }
    });

});
</script>

</body>
</html>