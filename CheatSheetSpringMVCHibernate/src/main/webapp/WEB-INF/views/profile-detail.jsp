<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<body>
    <div class="profile-container">
        <img src="${pageContext.request.contextPath}/uploads/profiles/${user.profileImg}" 
             style="width: 200px; height: 200px; border-radius: 50%; object-fit: cover;">
        
        <h1>${user.name}</h1>
        <p>${user.bio}</p>
        
        </div>
</body>
</html>