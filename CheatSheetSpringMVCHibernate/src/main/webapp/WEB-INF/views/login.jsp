<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>

    <c:if test="${param.error == 'true'}">
        <div style="color: red; margin-bottom: 15px;">
            Invalid email or password. Please try again.
        </div>
    </c:if>

    <form:form action="login" method="POST" modelAttribute="loginDto">
        
        <label>Email:</label>
        <form:input path="email" type="email" required="required" />
        
        <label>Password:</label>
        <form:password path="password" required="required" />
        
        <button type="submit">Login</button>
        
    </form:form>

</body>
</html>