<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>User Profile</title></head>
<body>
    <h2>User Profile</h2>
    
<form action="${pageContext.request.contextPath}/profile/update" method="POST" enctype="multipart/form-data">
    <input type="hidden" name="id" value="${user.id}">

    <div>
        <label>Current Photo:</label>
        <img src="${pageContext.request.contextPath}/uploads/${user.profileImg}" 
             style="width: 150px; height: 150px; border-radius: 50%;" 
             alt="Profile Photo">
    </div>

    <div>
        <label>Change Photo:</label>
        <input type="file" name="profileImg">
    </div>

    <div>
        <label>Name:</label>
        <input type="text" name="name" value="${user.name}">
    </div>

    <div>
        <label>Bio:</label>
        <textarea name="bio">${user.bio}</textarea>
    </div>

    <button type="submit">Save Changes</button>
</form>
</body>
</html>