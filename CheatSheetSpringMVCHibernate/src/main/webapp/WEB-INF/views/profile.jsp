<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>User Profile</title></head>
<body>
    <h2>User Profile</h2>
    
    <img src="${user.profileImg}" alt="Profile Image" width="150"><br>
    
   <form action="${pageContext.request.contextPath}/profile/update" method="POST">
    <input type="hidden" name="id" value="${user.id}">
    
    <input type="text" name="profileImg" value="${user.profileImg}">
    
    <label>Name:</label>
    <input type="text" name="name" value="${user.name}"><br>
    
    <label>Bio:</label>
    <textarea name="bio">${user.bio}</textarea><br>
    
    <button type="submit">Update Profile</button>
</form>
</body>
</html>