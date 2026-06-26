<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="uri" value="${pageContext.request.requestURI}" />

<style>
    .sidebar-container {
        width: 270px; /* Font ပိုကြီးလာသည့်အတွက် Sidebar Layout အချိုးကျစေရန် Width ကိုပါ ၂၇၀ သို့ အနည်းငယ် တိုးထားပါသည် */
        background-color: #ffffff;
        border-radius: 20px;
        padding: 24px 16px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        display: flex;
        flex-direction: column;
        justify-content: space-between; /* Logout အား အောက်ဆုံးသို့ ကပ်ထားရန် */
        min-height: calc(100vh - 64px); /* မျက်နှာပြင်အမြင့်အလိုက် ချိန်ညှိခြင်း */
        align-self: flex-start;
        min-width: 270px;
    }
    
    .sidebar-menu-links {
        display: flex;
        flex-direction: column;
        gap: 12px; /* 🌟 တခုနဲ့တခု ပိုမိုရှင်းလင်းသွားစေရန် ကြားအကွာအဝေး (Gap) ကို တိုးမြှင့်ထားပါသည် */
    }
    
    .sidebar-link {
        display: flex;
        align-items: center;
        gap: 14px; /* Icon နှင့် စာသား ကြားအကွာအဝေး */
        padding: 14px 20px; /* အပေါ်အောက် ဘေးဘယ်ညာ space ကို ပိုကျယ်ပေးထားပါသည် */
        color: #1e293b; 
        text-decoration: none;
        font-weight: 850; /* သာမန် Bold ထက် ပိုမိုထူထဲသော Extra Bold ပုံစံ */
        font-size: 16.5px; /* 🌟 စာလုံး Font အား ပိုမိုကြီးမား ထင်ရှားစေရန် တိုးမြှင့်လိုက်ပါသည် */
        border-radius: 14px;
        transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
    }
    
    /* 🌟 Mouse တင်လိုက်သည့်အခါ ထွက်လာမည့် "ထင်သာမြင်သာအရှိဆုံး" ဖောင်းကြွ Glow Effect */
    .sidebar-link:hover {
        background-color: #f0f7ff;
        color: #2563eb; 
        transform: translateY(-3px); /* ကြွတက်လာမှု */
        box-shadow: 0 12px 24px -4px rgba(37, 99, 235, 0.35), 0 4px 12px -2px rgba(37, 99, 235, 0.2); 
    }
    
    /* 🌟 ရွေးချယ်ထားသော စာမျက်နှာ (Active ဖြစ်ချိန်) အားပြင်း ဖောင်းကြွ Effect */
    .sidebar-link.active {
        background-color: #2563eb; /* Active ဖြစ်ပါက အပြာရောင်အပွင့် */
        color: #ffffff; /* စာသားကို အဖြူရောင် */
        box-shadow: 0 16px 28px -6px rgba(37, 99, 235, 0.5), 0 6px 16px -4px rgba(37, 99, 235, 0.3);
    }
    
    .sidebar-link i {
        font-size: 20px; /* 🌟 စာလုံးကြီးလာသည့်အတွက် Icon Size ကိုပါ လိုက်ဖက်အောင် ၂၀ သို့ မြှင့်ထားပါသည် */
        width: 24px;
        text-align: center;
        stroke-width: 2.5; /* Icon အနားသတ်လိုင်းများကိုပါ ပိုမိုထူထဲစေရန် */
    }

    /* Logout ခလုတ်အတွက် သီးသန့် Style */
    .sidebar-link-logout {
        color: #ef4444;
        border-top: 2px solid #f1f5f9; 
        padding-top: 18px;
        margin-top: 18px;
        font-weight: 850;
        font-size: 16.5px; /* Logout စာလုံးကိုပါ အတူတူ ကြီးပေးထားပါသည် */
    }
    .sidebar-link-logout:hover {
        background-color: #fef2f2;
        color: #dc2626;
        transform: translateY(-3px);
        box-shadow: 0 12px 24px -4px rgba(239, 68, 68, 0.35), 0 4px 12px -2px rgba(239, 68, 68, 0.2);
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
        
        <a href="${pageContext.request.contextPath}/admin/comments" 
           class="sidebar-link ${uri.contains('/admin/comments') ? 'active' : ''}">
            <i class="fa-regular fa-comments"></i> Comments
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
    </div>

    <div>
        <form action="${pageContext.request.contextPath}/logout" method="POST" style="margin: 0;">
            <button type="submit" class="sidebar-link sidebar-link-logout w-100 border-0 bg-transparent text-start" onclick="return confirm('Are you sure you want to logout?');">
                <i class="fa-solid fa-right-from-bracket"></i> Logout
            </button>
        </form>
    </div>
</div>