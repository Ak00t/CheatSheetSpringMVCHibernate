<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        body { background: #f1f5f9; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; font-family: sans-serif; }
        .unified-card { position: relative; width: 850px; height: 520px; background: white; border-radius: 20px; overflow: hidden; display: flex; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        
        .info-panel {
            position: absolute; width: 50%; height: 100%; top: 0; right: 0;
            background: linear-gradient(135deg, #047857, #064e3b);
            color: white; z-index: 10;
            transition: transform 1.2s ease-in-out;
            display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center;
        }
        
        .form-side { width: 50%; display: flex; justify-content: flex-start; align-items: center; padding-left: 50px; }
        .form-container { width: 300px; text-align: left; }

        /* Updated Big Title Style */
        .main-title { font-size: 28px; font-weight: 800; color: #047857; margin-bottom: 15px; line-height: 1.2; }

        .form-container h2 { margin-bottom: 20px; color: #333; font-size: 20px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; color: #666; font-size: 14px; }
        .form-group input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 6px; }
        .submit-btn { width: 100%; padding: 10px; background: #047857; color: white; border: none; border-radius: 6px; cursor: pointer; font-size: 16px; margin-top: 10px; }
    </style>
</head>
<body>
    <div class="unified-card">
        <div class="form-side">
            <div class="form-container">
                <div class="main-title">DEV-NOTE CHEATSHEET</div>
                <h2>Login</h2>
                <form:form action="login" method="POST" modelAttribute="loginDto">
                    <div class="form-group"><label>Email:</label> <form:input path="email" type="email" required="required" /></div>
                    <div class="form-group"><label>Password:</label> <form:password path="password" required="required" /></div>
                    <button type="submit" class="submit-btn">Login</button>
                </form:form>
            </div>
        </div>
        
        <div class="info-panel" id="greenPanel">
            <h3>New Here?</h3>
            <p>Sign up and discover more.</p>
            <button id="btnRegister" style="background:none; border:2px solid white; color:white; padding:10px 30px; border-radius:20px; cursor:pointer;">Sign up</button>
        </div>
    </div>

    <script>
        document.getElementById('btnRegister').addEventListener('click', function() {
            const panel = document.getElementById('greenPanel');
            panel.style.transform = "translateX(-100%)"; 
            setTimeout(() => window.location.href = "${pageContext.request.contextPath}/register", 1000);
        });
    </script>
</body>
</html>