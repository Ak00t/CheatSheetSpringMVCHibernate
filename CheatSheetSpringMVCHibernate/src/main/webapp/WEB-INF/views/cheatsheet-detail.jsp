<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Cheatsheet Detail</title>
</head>
<body>
   
    <div class="card" style="border: 1px solid ${cheatsheet.themeColor}">
        
        <p>Author: ${cheatsheet.authorName}</p>
        <p>Description: ${cheatsheet.description}</p>
        <div>
            <span>Views: ${cheatsheet.viewCount}</span>
            <span>Likes: ${cheatsheet.likeCount}</span>
        </div>
    </div>
<form action="${pageContext.request.contextPath}/like/toggle/${cheatsheet.id}" method="POST">
    <button type="submit" class="btn">
        ${userLiked ? 'Unlike' : 'Like'}
    </button>
</form>

<p>Likes: ${cheatsheet.likeCount}</p>
</body>
</html>