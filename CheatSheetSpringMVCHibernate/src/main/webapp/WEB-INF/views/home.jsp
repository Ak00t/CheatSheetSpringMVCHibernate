<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home</title>
</head>
<body>
    <b>WELCOME ${sessionScope.currentUser.name}</b>
    <p> Email : ${sessionScope.currentUser.email}</p>
    <p> Role : ${sessionScope.currentUser.role}</p>
    
    <table border="1">
        <tr>
            <th>CheatSheet Title</th>
            <th>CheatSheet Description</th>
            <th>By</th>
        </tr>
        <tr>
            <td>${cObj.title}</td>
            <td>${cObj.description}</td>
            <td>${cObj.user.name}</td>
        </tr>
    </table>

    <hr/>

<h3>Comments Section</h3>
<c:choose>
    <c:when test="${empty commentObj}">
        <p><em>No comments yet. Be the first to write one!</em></p>
    </c:when>
    <c:otherwise>
        <ul>
            <c:forEach var="comment" items="${commentObj}">
                <c:if test="${empty comment.parentComment}">
                    <li style="margin-bottom: 15px;">
                        <strong>${comment.user.name}:</strong> ${comment.content}
                        
                        
                        <c:if test="${comment.user.id == sessionScope.currentUser.id}">
                <div style="margin-top: 5px;">
                    <form:form action="comment/edit" method="post" style="display:inline-block;">
                        <input type="hidden" name="commentId" value="${comment.id}" />
                        
                        <input type="text" name="content" value="${comment.content}" required="required" style="font-size: 12px; width: 250px;"/>
                        <input type="submit" value="Save Edit" style="font-size: 11px; padding: 2px 5px;"/>
						
                    </form:form>
                </div>
            </c:if>
                        
                        <ul style="list-style-type: circle; margin-left: 20px; color: #555;">
                            <c:forEach var="reply" items="${comment.replies}">
                                <li>
                                    <strong>${reply.user.name}:</strong> ${reply.content}
                                </li>
                            </c:forEach>
                        </ul>
                        
                        <div style="margin-left: 20px; margin-top: 5px;">
                            <form:form action="comment/post" method="post">
                                <input type="hidden" name="cheatsheetId" value="${cObj.id}" />
                                <input type="hidden" name="parentId" value="${comment.id}" />
                                
                                <input type="text" name="content" placeholder="Reply to this comment..." required="required" style="width: 200px; font-size: 12px;" />
                                <input type="submit" value="Reply" style="font-size: 12px;">
                                <form:form action="comment/delete">delete</form:form>
                            </form:form>
                        </div>
                       
                        
                    </li>
                </c:if>
            </c:forEach>
        </ul>
    </c:otherwise>
</c:choose>

<hr/>

<h3>Leave a New Comment</h3>
<form:form action="comment/post" method="post">
    <input type="hidden" name="cheatsheetId" value="${cObj.id}" />
    <input type="text" name="content" placeholder="Write a comment..." required="required" style="width: 300px;" />
    <input type="submit" value="Submit Comment">
</form:form>
    <form:form action="logout" method="post">
        <input type="submit" value="Logout">
    </form:form>
</body>
