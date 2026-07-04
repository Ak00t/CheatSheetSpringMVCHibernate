<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Access Denied - 403</title>
    <style>
        body { text-align: center; font-family: sans-serif; padding-top: 100px; background-color: #f8f9fa; }
        h1 { color: #dc3545; font-size: 50px; }
        p { color: #6c757d; font-size: 20px; }
        a { color: #007bff; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
    <h1>403 - Access Denied</h1>
    <p>You do not have permission to view this page.</p>
    <a href="${pageContext.request.contextPath}/">Return Home</a>
</body>
</html>