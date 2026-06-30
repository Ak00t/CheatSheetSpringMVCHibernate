<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Account Settings | CheatSheet Hub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap');
        
        :root { 
            --emerald: #059669; 
            --emerald-hover: #047857; 
            --emerald-light: #ecfdf5;
            --slate-base: #0f172a;
            --bg-canvas: #f4fbfc; 
            --amber-button: #facc15;
            --amber-hover: #eab308;
            --amber-text: #1e293b;
        }
        
        body { 
            background-color: var(--bg-canvas); 
            font-family: 'Plus Jakarta Sans', 'Inter', sans-serif; 
            color: var(--slate-base);
            -webkit-font-smoothing: antialiased;
            margin: 0;
            padding: 0;
        }
        
        /* Layout Configuration */
        .page-container { display: flex; flex-direction: column; min-height: 100vh; }
        .content-body-wrapper { display: flex; padding: 28px; gap: 28px; flex: 1; align-items: flex-start; }
        .main-workspace { flex-grow: 1; min-width: 0; }

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
            background: var(--bg-canvas);
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

<div class="page-container">
    <!-- ၁။ Header ကို Include လုပ်ခြင်း -->
    <jsp:include page="header.jsp" />

    <div class="content-body-wrapper">
        <!-- ၂။ Sidebar ကို Include လုပ်ခြင်း -->
        <jsp:include page="sidebar.jsp" />
        
        <!-- Main Workspace Workspace Area -->
        <div class="main-workspace">
            <div class="row g-4 align-items-stretch">
                
                <!-- Left Profile Card -->
                <div class="col-lg-5 col-xl-4">
                    <div class="premium-card profile-side d-flex flex-column align-items-center justify-content-between text-center">
                        <div class="w-100 d-flex flex-column align-items-center">
                            
                            <form action="${pageContext.request.contextPath}/admin/profile/upload-photo" method="POST" enctype="multipart/form-data" id="photoForm">
                                <div class="avatar-wrapper mb-4 mx-auto">
                                    <c:choose>
                                        <c:when test="${not empty admin.profileImg}">
                                            <img src="${admin.profileImg.startsWith('/') && !admin.profileImg.startsWith(pageContext.request.contextPath) ? pageContext.request.contextPath : ''}${admin.profileImg}" class="avatar-image" alt="User Image">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/resources/images/default-avatar.png" class="avatar-image" alt="Default Avatar">
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

                <!-- Right Security Settings Form -->
                <div class="col-lg-7 col-xl-8">
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
                                    <a href="${pageContext.request.contextPath}/" class="btn btn-cancel px-4">Back to Dashboard</a>
                                    <button type="submit" class="btn btn-premium px-4">Update Password</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
    </div>

    <!-- ၃။ Footer ကို Include လုပ်ခြင်း -->
    <jsp:include page="footer.jsp" />
</div>

<script>
    lucide.createIcons();
</script>
</body>
</html>