<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Cheatsheets</title>

<style>
/* 🌟 child-category-view ထဲက CSS အခင်းအကျင်းအတိုင်း ရာနှုန်းပြည့် ပြန်သုံးခြင်း 🌟 */
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
    margin:40px auto;
}

h1 {
    color: #2563eb;
    font-size: 32px;
    font-weight: 800;
    margin-bottom: 25px;
}

/* Flex Wrap စနစ်ဖြင့် ကတ်ပြားများကို အလယ်တွင် ထားရှိခြင်း */
.grid {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 24px;
    padding-bottom: 18px;
}

/* 🌟 ရှိပြီးသား မူရင်း .sheet-card အတိုင်း ၁ ထပ်တည်း သတ်မှတ်ခြင်း 🌟 */
.sheet-card{
    flex:0 0 380px;
    border-radius:28px;
    overflow:hidden;
    text-decoration:none;
    color: white !important;   /* စာသားအားလုံး အဖြူရောင်ပေါ်ရန် */
    border: 1px solid rgba(255, 255, 255, 0.2);
    box-shadow:0 14px 35px rgba(0,0,0,.12);
    transition:.3s;
    padding: 24px;
    display: flex;
    flex-direction: column;
    height: 520px; /* Action buttons ကြောင့် အမြင့်အား အနည်းငယ် ညှိထားပါသည် */
}

.sheet-card:hover{
    transform:translateY(-6px);
    box-shadow: 0 20px 40px rgba(0,0,0,.2);
}

.sheet-cover{
    width: 100%;
    height: 180px;
    border: 2px dashed rgba(255, 255, 255, 0.4);
    border-radius: 18px;
    display:flex;
    justify-content:center;
    align-items:center;
    color:white;
    font-size:22px;
    font-weight:800;
    overflow:hidden;
    background: rgba(0, 0, 0, 0.05);
    flex-shrink: 0;
}

.sheet-cover img{
    width:100%;
    height:100%;
    object-fit:cover;
}

.sheet-body{
    padding: 12px 0 0 0;
    display: flex;
    flex-direction: column;
    flex-grow: 1;
    overflow: hidden;
}

.category-badge{
    display:inline-block;
    padding:5px 15px;
    border-radius:999px;
    background: rgba(255, 255, 255, 0.2);
    color: white;
    font-size:13px;
    font-weight:800;
    margin-bottom:12px;
    align-self: flex-start;
    text-transform: uppercase;
}

.sheet-title{
    font-size:24px;
    color: white;
    margin-bottom:8px;
    font-weight:800;
}

.sheet-description{
    color: rgba(255, 255, 255, 0.9);
    line-height:1.6;
    max-height: 80px;
    overflow:hidden;
    font-size: 14px;
}

.see-btn{
    display:inline-block;
    margin-top:5px;
    color: white;
    text-decoration: underline;
    font-weight: 800;
    cursor:pointer;
    font-size: 14px;
}

/* 🌟 Profile View ဖြစ်၍ မူရင်း .sheet-footer နေရာတွင် Edit/Delete ခလုတ်များ အစားထိုးခြင်း 🌟 */
.sheet-footer-actions {
    margin-top: auto;
    padding-top: 14px;
    border-top: 1px solid rgba(255, 255, 255, 0.2);
    display: flex;
    gap: 12px;
}

.btn-action {
    flex: 1;
    text-align: center;
    padding: 10px 0;
    font-size: 14px;
    font-weight: bold;
    text-decoration: none;
    border-radius: 14px;
    transition: 0.2s;
    cursor: pointer;
}

.btn-profile-edit {
    background: rgba(255, 255, 255, 0.2);
    color: white !important;
    border: 1px solid rgba(255, 255, 255, 0.4);
}
.btn-profile-edit:hover {
    background: rgba(255, 255, 255, 0.35);
}

.btn-profile-delete {
    background: rgba(239, 68, 68, 0.85);
    color: white !important;
    border: 1px solid rgba(255, 255, 255, 0.2);
}
.btn-profile-delete:hover {
    background: rgba(220, 38, 38, 0.95);
}

.empty-box{
    background:white;
    border:2px dashed #cbd5e1;
    border-radius:26px;
    padding:30px;
    color:#64748b;
}
</style>

<script>
    function confirmDelete() {
        return confirm("ဤ Cheat Sheet အား ဖျက်ရန် သေချာပါသလား?");
    }
</script>
</head>

<body>

<jsp:include page="header.jsp"/>

<div class="container">

    <h1>User ${userId} Cheatsheets</h1>

    <c:choose>
        <c:when test="${not empty cheatsheets}">
            <div class="grid">

                <c:forEach items="${cheatsheets}" var="sheet">

                    <div class="sheet-card" style="background-color: ${sheet.themeColor};">
                        
                        <a href="${pageContext.request.contextPath}/profile-cheatsheets/detail/${sheet.id}" style="text-decoration: none; color: inherit; display: flex; flex-direction: column; height: 100%;">
                       <div class="sheet-cover">
    <c:choose>
        <c:when test="${not empty sheet.mediaList and not empty sheet.mediaList[0].mediaUrl}">
            <%-- mediaUrl က /uploads/cheatsheets/ နဲ့ စတဲ့အတွက် contextPath နောက်မှာ တန်းထည့်ပါ --%>
            <img src="${pageContext.request.contextPath}/uploads/cheatsheets/${sheet.mediaList[0].mediaUrl}?t=<%=System.currentTimeMillis()%>" 
                 alt="Cover" 
                 onerror="this.src='${pageContext.request.contextPath}/path/to/default-image.png';">
        </c:when>
        <c:otherwise>
            <span style="color:white; font-size:12px;">No Image</span>
        </c:otherwise>
    </c:choose>
</div>
                            <div class="sheet-body">
                                <div class="category-badge">${sheet.category.name}</div>

                                <h3 class="sheet-title">${sheet.title}</h3>
                                <p class="sheet-description">${sheet.description}</p>
                                <span class="see-btn">See More</span>
                            </div>
                        </a>

                       <%--  <div class="sheet-footer-actions">
                            <a href="${pageContext.request.contextPath}/profile-cheatsheets/edit/${sheet.id}" class="btn-action btn-profile-edit">
                                ✏️ Edit
                            </a>
                            
                            <form action="${pageContext.request.contextPath}/profile-cheatsheets/delete/${sheet.id}" method="post" style="flex: 1; display: flex;" onsubmit="return confirmDelete();">
                                <button type="submit" class="btn-action btn-profile-delete">
                                    🗑️ Delete
                                </button>
                            </form>
                        </div> --%>
                        <div class="sheet-footer">

    Created By:
    <span class="creator-link">
        ${sheet.user.name}
    </span>

    <br>

    🗓
    <%-- အရင်ရှိတဲ့ fmt:parseDate ကို ဖျက်ပြီး ဒါနဲ့ အစားထိုးလိုက်ပါ --%>
<c:set var="datePart" value="${fn:substring(sheet.createdAt, 0, 10)}" />
<c:set var="timePart" value="${fn:substring(sheet.createdAt, 11, 16)}" />

🗓 ${datePart} ${timePart}

</div>
                        
                        

                    </div>

                </c:forEach>

            </div>
        </c:when>

        <c:otherwise>
            <div class="empty-box">
                No published cheatsheets found for this user.
            </div>
        </c:otherwise>
    </c:choose>

</div>

<jsp:include page="footer.jsp"/>

</body>
</html>