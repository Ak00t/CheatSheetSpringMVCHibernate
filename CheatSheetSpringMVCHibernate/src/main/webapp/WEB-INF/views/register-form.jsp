<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <style>
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; }
        .error-message { color: red; font-size: 0.85em; display: block; margin-top: 5px; }
    </style>
</head>
<body>

    <h2>Registration Form</h2>

    <form:form action="${pageContext.request.contextPath}/register" method="POST" modelAttribute="registerDto">
        
        <div class="form-group">
            <label for="name">Name:</label>
            <form:input path="name" id="name" />
            <form:errors path="name" cssClass="error-message" />
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <form:input path="email" id="email" />
            <form:errors path="email" cssClass="error-message" />
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <form:password path="password" id="password" />
            <form:errors path="password" cssClass="error-message" />
        </div>

        <div class="form-group">
            <label for="confirmPassword">Confirm Password:</label>
            <form:password path="confirmPassword" id="confirmPassword" />
            <form:errors path="confirmPassword" cssClass="error-message" />
        </div>

        <button type="submit">Submit</button>

    </form:form>

</body>
</html>