<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="uri" value="${pageContext.request.requestURI}" />

<style>
    .sidebar-container {
        width: 270px; 
        background-color: #ffffff;
        border-radius: 20px;
        padding: 24px 16px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        display: flex;
        flex-direction: column;
        min-height: calc(100vh - 64px); 
        align-self: flex-start;
        min-width: 270px;
    }
    
    .sidebar-menu-links {
        display: flex;
        flex-direction: column;
        gap: 12px; 
    }
    
    .sidebar-link {
        display: flex;
        align-items: center;
        gap: 14px; 
        padding: 14px 20px; 
        color: #1e293b; 
        text-decoration: none;
        font-weight: 850; 
        font-size: 16.5px; 
        border-radius: 14px;
        transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
    }
    
    /* Hover Glow Effect */
    .sidebar-link:hover {
        background-color: #f0f7ff;
        color: #2563eb; 
        transform: translateY(-3px); 
        box-shadow: 0 12px 24px -4px rgba(37, 99, 235, 0.35), 0 4px 12px -2px rgba(37, 99, 235, 0.2); 
    }
    
    /* Active Link State */
    .sidebar-link.active {
        background-color: #2563eb; 
        color: #ffffff; 
        box-shadow: 0 16px 28px -6px rgba(37, 99, 235, 0.5), 0 6px 16px -4px rgba(37, 99, 235, 0.3);
    }
    
    .sidebar-link i {
        font-size: 20px; 
        width: 24px;
        text-align: center;
        stroke-width: 2.5; 
    }

    /* Logout Button Styling */
    .sidebar-link-logout {
        color: #ef4444;
        border-top: 2px solid #f1f5f9; 
        padding-top: 18px;
        margin-top: 18px;
        font-weight: 850;
        font-size: 16.5px; 
        border-radius: 0px; /* Reset border radius for flat separator look */
    }
    .sidebar-link-logout:hover {
        background-color: #fef2f2;
        color: #dc2626;
        transform: translateY(-3px);
        box-shadow: 0 12px 24px -4px rgba(239, 68, 68, 0.35), 0 4px 12px -2px rgba(239, 68, 68, 0.2);
        border-radius: 14px;
    }
</style>

<div class="sidebar-container">
    <div class="sidebar-menu-links">
        <a href="${pageContext.request.contextPath}/admindashboard" 
           class="sidebar-link ${uri.contains('admindashboard') ? 'active' : ''}">
            <i class="fa-solid fa-chart-simple"></i> Dashboard
        </a>
        
        <a href="${pageContext.request.contextPath}/usermanagement/list" 
           class="sidebar-link ${uri.contains('usermanagement') || uri.contains('profile') ? 'active' : ''}">
            <i class="fa-solid fa-users"></i> Users
        </a>
        
        <a href="${pageContext.request.contextPath}/admin/reports" 
           class="sidebar-link ${uri.contains('/admin/reports') ? 'active' : ''}">
            <i class="fa-regular fa-flag"></i> Reports
        </a>
        
        <a href="${pageContext.request.contextPath}/admin/taxonomy" 
           class="sidebar-link ${uri.contains('admin/taxonomy') || uri.contains('category-tags') || uri.contains('category-list') ? 'active' : ''}">
            <i class="fa-solid fa-boxes-stacked"></i> Taxonomy
        </a>
        
        <a href="${pageContext.request.contextPath}/admin/analytics" 
           class="sidebar-link ${uri.contains('/admin/analytics') ? 'active' : ''}">
            <i class="fa-solid fa-chart-line"></i> Analytics
        </a>
        
        <a href="${pageContext.request.contextPath}/admin/activity-logs" 
           class="sidebar-link ${uri.contains('/admin/activity-logs') ? 'active' : ''}">
            <i class="fa-solid fa-clock-rotate-left"></i> Activity Logs
        </a>

        <!-- Logout button placed naturally inside the stack right below Activity Logs -->
        <form action="${pageContext.request.contextPath}/logout" method="POST" style="margin: 0;">
            <button type="submit" class="sidebar-link sidebar-link-logout w-100 border-0 bg-transparent text-start" onclick="return confirm('Are you sure you want to logout?');">
                <i class="fa-solid fa-right-from-bracket"></i> Logout
            </button>
        </form>
    </div>
</div>