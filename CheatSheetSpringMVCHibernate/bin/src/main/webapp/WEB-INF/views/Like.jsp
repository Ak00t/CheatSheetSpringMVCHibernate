<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<body>
    <h1>${cheatsheet.title}</h1>
    <p>${cheatsheet.content}</p>

    <div class="like-container">
        <form action="${pageContext.request.contextPath}/likes/toggle" method="POST">
            <input type="hidden" name="cheatsheetId" value="${cheatsheet.id}" />
            
            <button type="submit" class="btn ${isLiked ? 'btn-danger' : 'btn-outline-primary'}">
                <c:choose>
                    <c:when test="${isLiked}">
                        <i class="fa fa-heart"></i> Unlike
                    </c:when>
                    <c:otherwise>
                        <i class="fa fa-heart-o"></i> Like
                    </c:otherwise>
                </c:choose>
            </button>
        </form>
    </div>
</body>
</html>