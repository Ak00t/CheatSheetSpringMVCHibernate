<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body{
            background-color:#f4f7f6;
            color:#4a5568;
            font-family:'Segoe UI',sans-serif;
        }

        .profile-card{
            background:#ffffff;
            border-radius:20px;
            box-shadow:0 10px 25px rgba(0,0,0,0.05);
            padding:2rem;
            margin-top:50px;
        }

        .profile-img{
            width:150px !important;
            height:150px !important;
            object-fit:cover;
            border-radius:50%;
            border:4px solid #f8f9fa;
            box-shadow:0 4px 10px rgba(0,0,0,0.1);
            display:block;
            margin:0 auto;
        }

        label{
            font-weight:600;
            color:#718096;
            margin-bottom:0.5rem;
        }

        .form-control{
            border-radius:10px;
            border:1px solid #e2e8f0;
            padding:0.75rem;
        }

        .btn-save{
            background-color:#4a90e2;
            color:white;
            border-radius:10px;
            padding:0.75rem 2rem;
            transition:0.3s;
            width:100%;
            border:none;
        }

        .btn-save:hover{
            background-color:#357abd;
            color:white;
        }

        .btn-back{
            background:#6b7280;
            color:white;
            border-radius:10px;
            padding:0.75rem 2rem;
            text-decoration:none;
            display:flex;
            align-items:center;
            justify-content:center;
        }

        .btn-back:hover{
            background:#4b5563;
            color:white;
        }
    </style>
</head>

<body>

<div class="container">

    <div class="row justify-content-center">

        <div class="col-md-6 profile-card">

            <h2 class="text-center mb-4 fw-bold"
                style="color:#2d3748;">
                Edit Profile
            </h2>

            <form action="${pageContext.request.contextPath}/profile/update"
                  method="POST"
                  enctype="multipart/form-data">

                <input type="hidden"
                       name="id"
                       value="${user.id}">

                <!-- Current Photo -->

                <div class="text-center mb-4">

                    <label class="d-block mb-3">
                        Current Photo:
                    </label>

                    <c:choose>

                        <c:when test="${not empty user.profileImg}">

                            <img
                                src="${pageContext.request.contextPath}/profile/uploads/${user.profileImg}"
                                class="profile-img"
                                alt="Profile Photo">

                        </c:when>

                        <c:otherwise>

                            <img
                                src="https://via.placeholder.com/150"
                                class="profile-img"
                                alt="No Profile">

                        </c:otherwise>

                    </c:choose>

                </div>

                <!-- Upload -->

                <div class="mb-3">

                    <label>
                        Change Photo:
                    </label>

                    <input type="file"
                           name="profileImg"
                           class="form-control">

                </div>

                <!-- Name -->

                <div class="mb-3">

                    <label>
                        Name:
                    </label>

                    <input type="text"
                           name="name"
                           class="form-control"
                           value="${user.name}">

                </div>

                <!-- Bio -->

                <div class="mb-3">

                    <label>
                        Bio:
                    </label>

                    <textarea name="bio"
                              class="form-control"
                              rows="4">${user.bio}</textarea>

                </div>

                <!-- Buttons -->

                <div class="d-flex gap-3 mt-4">

                    <a href="javascript:history.back()"
                       class="btn btn-back flex-grow-1">
                        Back
                    </a>

                    <button type="submit"
                            class="btn btn-save flex-grow-1">
                        Save Changes
                    </button>

                </div>

            </form>

        </div>

    </div>

</div>

</body>
</html>