<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Access Denied</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center justify-content-center" style="height: 100vh;">

<div class="card p-5 text-center shadow-lg border-0" style="max-width: 480px; border-radius: 20px;">
    <div class="text-danger mb-3">
        <i class="bi bi-exclamation-triangle-fill" style="font-size: 4rem;"></i>
    </div>
    <h3 class="fw-bold text-dark mb-2">Something went wrong</h3>
    <p class="text-muted fs-6 mb-4">${errorMessage}</p>
    
    <div class="d-flex gap-2 justify-content-center">
        <a href="javascript:history.back()" class="btn btn-secondary px-4 fw-bold rounded-3">Go Back</a>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary px-4 fw-bold rounded-3">Home</a>
    </div>
</div>

</body>
</html>