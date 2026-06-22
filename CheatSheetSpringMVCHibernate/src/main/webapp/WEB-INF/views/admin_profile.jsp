<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Account Settings | Enterprise Suite</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        
        :root { 
            --emerald: #059669; 
            --emerald-hover: #047857; 
            --emerald-light: #ecfdf5;
            --slate-base: #0f172a;
            --bg-light: #f8fafc;
            --amber-button: #facc15;
            --amber-hover: #eab308;
            --amber-text: #1e293b;
        }
        
        body { 
            background-color: var(--bg-light); 
            font-family: 'Inter', sans-serif; 
            color: var(--slate-base);
            -webkit-font-smoothing: antialiased;
        }
        
        .premium-card { 
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 24px;
            padding: 3rem;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.02);
            min-height: 520px;
            display: flex;
            flex-direction: column;
            transition: all 0.3s ease;
        }
        
        .premium-card:hover { box-shadow: 0 25px 30px -5px rgba(0, 0, 0, 0.04); }
        .profile-side { background: #ffffff; border: 1px solid #e2e8f0; }
        
        /* Interactive Real Photo Avatar Styling */
        .avatar-wrapper {
            position: relative;
            width: 110px;
            height: 110px;
            border-radius: 50%;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            border: 3px solid #ffffff;
            outline: 2px solid var(--emerald);
            transition: all 0.3s ease;
        }

        .avatar-image { width: 100%; height: 100%; object-fit: cover; }
        
        .avatar-hover-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(15, 23, 42, 0.65);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.25s ease;
            cursor: pointer;
        }
        .avatar-wrapper:hover .avatar-hover-overlay { opacity: 1; }

        .form-label {
            font-weight: 600;
            color: #475569;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .form-control { 
            background: var(--bg-light);
            border: 1px solid #cbd5e1;
            color: var(--slate-base);
            padding: 0.85rem 1rem;
            border-radius: 12px;
            font-weight: 500;
            transition: all 0.2s ease;
        }
        .form-control:focus { 
            background: #ffffff; 
            border-color: var(--emerald); 
            box-shadow: 0 0 0 4px rgba(5, 150, 105, 0.12); 
        }

        .btn-premium {
            background: linear-gradient(135deg, var(--emerald), var(--emerald-hover));
            color: #ffffff;
            font-weight: 600;
            border-radius: 12px;
            padding: 0.85rem 2rem;
            border: none;
            transition: all 0.2s;
        }
        .btn-premium:hover { transform: translateY(-1px); box-shadow: 0 10px 15px -3px rgba(5, 150, 105, 0.2); color: #ffffff; }
        
        /* Custom Amber Yellow Dashboard Button */
        .btn-cancel {
            background: var(--amber-button);
            color: var(--amber-text);
            font-weight: 600;
            border-radius: 12px;
            padding: 0.85rem 2rem;
            border: 1px solid rgba(0, 0, 0, 0.05);
            text-decoration: none;
            text-align: center;
            transition: all 0.2s ease;
        }
        .btn-cancel:hover { 
            background: var(--amber-hover);
            color: var(--amber-text);
            transform: translateY(-1px);
            box-shadow: 0 10px 15px -3px rgba(234, 179, 8, 0.3);
        }
        
        .alert-premium {
            background: #fef2f2;
            border: 1px solid #fee2e2;
            border-left: 4px solid #ef4444;
            color: #991b1b;
            border-radius: 14px;
            padding: 1rem 1.25rem;
            font-weight: 500;
        }
    </style>
</head>
<body>

<div class="container py-5 mt-4">
    <div class="row g-4 justify-content-center align-items-stretch">
        
        <div class="col-lg-4">
            <div class="premium-card profile-side d-flex flex-column align-items-center justify-content-between text-center">
                <div class="w-100 d-flex flex-column align-items-center">
                    
                 <!-- Seamless Asynchronous Image Uploader Form -->
<form action="${pageContext.request.contextPath}/admin/profile/upload-photo" method="POST" enctype="multipart/form-data" id="photoForm">
    <div class="avatar-wrapper mb-4 mx-auto">
        <c:choose>
            <%-- FIXED: Changed c:if to c:when inside the c:choose block --%>
            <c:when test="${not empty admin.profileImg}">
                <img src="${admin.profileImg}" class="avatar-image" alt="User Image">
            </c:when>
            <c:otherwise>
                <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=256" class="avatar-image" alt="Default Avatar">
            </c:otherwise>
        </c:choose>
        <label for="imageUpload" class="avatar-hover-overlay">
            <i data-lucide="camera" style="width: 24px; height: 24px; color: #ffffff;"></i>
        </label>
        <input type="file" id="imageUpload" name="profilePhoto" class="d-none" accept="image/*" onchange="document.getElementById('photoForm').submit();">
    </div>
</form>
                 
                 
                    
                    <h3 class="fw-bold mb-1" style="letter-spacing: -0.02em;">${admin.name}</h3>
                    <span class="badge px-3 py-2 rounded-pill mb-4" style="background: var(--emerald-light); color: var(--emerald); font-weight: 600; font-size: 0.8rem;">
                        ${admin.role}
                    </span>
                </div>
                
                <div class="w-100 border-top pt-4 text-start">
                    <div class="d-flex align-items-center gap-3">
                        <div class="p-2 rounded-3 bg-light text-muted">
                            <i data-lucide="mail" style="width: 18px; height: 18px;"></i>
                        </div>
                        <div>
                            <p class="text-muted small mb-0" style="font-size: 0.75rem; font-weight: 500;">EMAIL ADDRESS</p>
                            <p class="fw-semibold m-0 text-dark" style="font-size: 0.95rem;">${admin.email}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-7">
            <div class="premium-card d-flex flex-column justify-content-between">
                <div>
                    <h2 class="fw-bold mb-1" style="letter-spacing: -0.02em;">Security Settings</h2>
                    <p class="text-muted mb-4" style="font-size: 0.95rem;">Manage your credentials and keep your account secure.</p>
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-premium d-flex align-items-center mb-4" role="alert">
                            <i data-lucide="alert-circle" class="me-3 flex-shrink-0" style="width: 20px; height: 20px;"></i>
                            <div>${error}</div>
                        </div>
                    </c:if>
                    
                    <form action="${pageContext.request.contextPath}/admin/profile/update-password" method="POST" class="mt-2">
                        <div class="mb-4">
                            <label class="form-label mb-2">Current Password</label>
                            <input type="password" name="currentPassword" class="form-control" required placeholder="Enter current account password">
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label class="form-label mb-2">New Password</label>
                                <input type="password" name="newPassword" class="form-control" required placeholder="Minimum 8 characters">
                            </div>
                            <div class="col-md-6 mb-4">
                                <label class="form-label mb-2">Confirm New Password</label>
                                <input type="password" name="confirmPassword" class="form-control" required placeholder="Re-enter new password">
                            </div>
                        </div>
                        
                        <div class="d-flex align-items-center justify-content-end gap-3 pt-4 border-top mt-4">
                            <a href="${pageContext.request.contextPath}/admindashboard" class="btn btn-cancel px-4">Back to Dashboard</a>
                            <button type="submit" class="btn btn-premium px-4">Update Password</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
    </div>
</div>

<script>
    lucide.createIcons();
</script>
</body>
</html>