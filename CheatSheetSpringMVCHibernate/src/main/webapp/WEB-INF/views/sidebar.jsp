<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="uri" value="${pageContext.request.requestURI}" />

<div class="sidebar-container">
    <a href="${pageContext.request.contextPath}/admindashboard" 
       class="sidebar-link ${uri.contains('admindashboard') ? 'active' : ''}">
        <i class="fa-solid fa-chart-simple"></i> Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/admin/users" 
       class="sidebar-link ${uri.contains('/admin/users') ? 'active' : ''}">
        <i class="fa-solid fa-users"></i> Users
    </a>
    <a href="${pageContext.request.contextPath}/cheatsheet/explore" 
       class="sidebar-link ${uri.contains('cheatsheet') ? 'active' : ''}">
        <i class="fa-solid fa-file-lines"></i> Cheatsheets
    </a>
    <a href="${pageContext.request.contextPath}/admin/comments" 
       class="sidebar-link ${uri.contains('/admin/comments') ? 'active' : ''}">
        <i class="fa-regular fa-comments"></i> Comments
    </a>
    <a href="${pageContext.request.contextPath}/admin/reports" 
       class="sidebar-link ${uri.contains('/admin/reports') ? 'active' : ''}">
        <i class="fa-regular fa-flag"></i> Reports
    </a>
    <a href="${pageContext.request.contextPath}/admin/moderation" 
       class="sidebar-link ${uri.contains('/admin/moderation') ? 'active' : ''}">
        <i class="fa-solid fa-shield-halved"></i> Moderation
    </a>
    <a href="${pageContext.request.contextPath}/admin/categories" 
       class="sidebar-link ${uri.contains('/admin/categories') ? 'active' : ''}">
        <i class="fa-regular fa-folder"></i> Categories
    </a>
    <a href="${pageContext.request.contextPath}/admin/tags" 
       class="sidebar-link ${uri.contains('/admin/tags') ? 'active' : ''}">
        <i class="fa-solid fa-tags"></i> Tags
    </a>
    <a href="${pageContext.request.contextPath}/admin/notifications" 
       class="sidebar-link ${uri.contains('/admin/notifications') ? 'active' : ''}">
        <i class="fa-regular fa-bell"></i> Notifications
    </a>
    <a href="${pageContext.request.contextPath}/admin/analytics" 
       class="sidebar-link ${uri.contains('/admin/analytics') ? 'active' : ''}">
        <i class="fa-solid fa-chart-line"></i> Analytics
    </a>
    <a href="${pageContext.request.contextPath}/admin/activity-logs" 
       class="sidebar-link ${uri.contains('/admin/activity-logs') ? 'active' : ''}">
        <i class="fa-solid fa-clock-rotate-left"></i> Activity Logs
    </a>
    <a href="${pageContext.request.contextPath}/admin/settings" 
       class="sidebar-link ${uri.contains('/admin/settings') ? 'active' : ''}">
        <i class="fa-solid fa-gear"></i> Settings
    </a>
</div>