<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
    <style>
        body { background-color: #f4f7f6; color: #4a5568; font-family: 'Segoe UI', sans-serif; }
        .profile-card { 
            background: #ffffff; 
            border-radius: 20px; 
            box-shadow: 0 10px 25px rgba(0,0,0,0.05); 
            padding: 2rem; 
            margin-top: 50px; 
        }
        .profile-img { 
            width: 150px; height: 150px; 
            object-fit: cover; 
            border: 4px solid #f8f9fa;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        label { font-weight: 600; color: #718096; margin-bottom: 0.5rem; }
        .form-control { border-radius: 10px; border: 1px solid #e2e8f0; padding: 0.75rem; }
        .btn-save { 
            background-color: #4a90e2; color: white; 
            border-radius: 10px; padding: 0.75rem 2rem; 
            transition: 0.3s; width: 100%; 
        }
        .btn-save:hover { background-color: #357abd; color: white; }
        
        
        .profile-img { 
    width: 150px !important;    /* အကျယ် 150px */
    height: 150px !important;   /* အမြင့် 150px */
    object-fit: cover;          /* ပုံကို အချိုးအစားမပျက်အောင်ဖြတ်ညှပ်ပေးမယ် */
    border-radius: 50%;         /* ပုံကို အဝိုင်းဖြစ်စေမယ် */
    border: 4px solid #f8f9fa;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    display: block;             /* ပုံကို center ကျအောင်လုပ်ပေးမယ် */
    margin: 0 auto;             /* ပုံကို အလယ်တည့်တည့်ရောက်အောင်လုပ်ပေးမယ် */
}
.btn-outline-danger { border-radius: 20px; transition: 0.3s; }
.btn-primary { border-radius: 20px; transition: 0.3s; }
        
        
        
        
        .btn-outline-secondary {
        border: 1px solid #ced4da;
        cursor: pointer;
        padding: 0.5rem;
        border-radius: 10px;
        text-align: center;
        display: block;
    }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 profile-card">
            <h2 class="text-center mb-4 fw-bold" style="color: #2d3748;">Edit Profile</h2>
            
            <%-- Login ဝင်ထားတဲ့သူရဲ့ ID နဲ့ Profile ပိုင်ရှင် ID ကို နှိုင်းယှဉ်ပြီး variable တစ်ခု သတ်မှတ်ပါ --%>
<c:set var="isOwner" value="${currentUser.id == user.id}" />

<form action="${pageContext.request.contextPath}/profile/update" method="POST" enctype="multipart/form-data">
    <input type="hidden" name="id" value="${user.id}">

    <div class="text-center mb-4">
        <label class="d-block mb-3">Current Photo:</label>
        <img src="${pageContext.request.contextPath}/uploads/profiles/${user.profileImg}" class="profile-img" alt="Profile Photo">            
    </div>

    <%-- ဤနေရာတွင် c:if ကိုသုံးပြီး ပိုင်ရှင်မှသာ "Choose File" အပိုင်းကို မြင်ရအောင်လုပ်ပါ --%>
    <c:if test="${isOwner}">
        <div class="mb-3">
            <label>Change Photo:</label>
            <input type="file" name="profileImg" class="form-control">
        </div>
    </c:if>
    
    <%-- ကျန်တဲ့ Name, Bio နဲ့ Save button တွေကိုလည်း အပေါ်ကအတိုင်း လိုအပ်သလို c:if ခံပေးနိုင်ပါတယ် --%>
    ...


                <div class="mb-3">
                    <label>Name:</label>
                    <input type="text" name="name" class="form-control" value="${user.name}">
                </div>

                <div class="mb-3">
                    <label>Bio:</label>
                    <textarea name="bio" class="form-control" rows="4">${user.bio}</textarea>
                    
                    
                    
                    
                </div>
                
             <div class="text-center mt-3">
    <c:if test="${currentUser.id != user.id}">
    <button type="button" 
            onclick="toggleFollow(${user.id})" 
            class="btn ${isFollowing ? 'btn-outline-danger' : 'btn-primary'} w-100">
        ${isFollowing ? 'Unfollow' : 'Follow'}
    </button>
</c:if>
</div>
<%-- ပြင်ဆင်ချက် --%>
<%-- ပြင်ဆင်ချက် --%>
<div class="d-flex gap-3 mt-4">
    <a href="${pageContext.request.contextPath}" class="btn btn-secondary flex-grow-1 text-center">Back</a>
    
    <c:if test="${currentUser.id == user.id}">
        <div class="mt-4">
            <button type="submit" class="btn btn-save">Save Changes</button>
        </div>
    </c:if>
</div>
            </form>
        </div>
    </div>
</div>




<script>


function toggleFollow(followingId) {
    const token = document.querySelector('meta[name="_csrf"]').getAttribute('content');
    const header = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

    fetch('${pageContext.request.contextPath}/follow/toggle?followingId=' + followingId, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded', // JSON အစား ဒါကို သုံးပါ
            [header]: token
        }
    })
    .then(response => {
        if(response.ok) {
            location.reload();
        } else {
            alert('Error: အဆင်မပြေမှုတစ်ခုဖြစ်ပေါ်နေသည်။');
        }
    })
    .catch(error => console.error('Error:', error));
}


document.getElementById('file-upload').addEventListener('change', function() {
    var fileName = this.files[0].name;
    // label စာသားကို ဖိုင်နာမည်နဲ့ အစားထိုးမယ်
    this.previousElementSibling.textContent = fileName;
});
</script>
</body>
</html>