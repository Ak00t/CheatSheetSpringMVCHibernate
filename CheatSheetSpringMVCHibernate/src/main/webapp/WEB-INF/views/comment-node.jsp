<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="reply-card">

    <div class="comment-user">
        User #${node.user.id}
    </div>

    <div class="comment-content">
        <c:out value="${node.content}" />
    </div>

    <div class="comment-date">
        ${node.createdAt}
    </div>

    <button type="button"
            class="reply-btn"
            onclick="toggleReplyForm(${node.id})">
        Reply
    </button>

    <button type="button"
            class="reply-btn"
            onclick="toggleEditForm(${node.id})">
        Edit
    </button>

    <form method="post"
          action="${pageContext.request.contextPath}/comment/delete"
          style="display:inline;">

        <input type="hidden"
               name="commentId"
               value="${node.id}" />

        <input type="hidden"
               name="cheatsheetId"
               value="${cheatsheet.id}" />

        <button type="submit"
                class="delete-btn"
                onclick="return confirm('Delete this reply?')">
            Delete
        </button>
    </form>

    <div id="reply-form-${node.id}"
         class="reply-form-wrapper"
         style="display:none;">

        <form method="post"
              action="${pageContext.request.contextPath}/comment/reply">

            <input type="hidden"
                   name="cheatsheetId"
                   value="${cheatsheet.id}" />

            <input type="hidden"
                   name="parentCommentId"
                   value="${node.id}" />

            <textarea name="content"
                      placeholder="Write a reply..."
                      required></textarea>

            <button type="submit"
                    class="comment-btn">
                Post Reply
            </button>
        </form>
    </div>

    <div id="edit-form-${node.id}"
         class="reply-form-wrapper"
         style="display:none;">

        <form method="post"
              action="${pageContext.request.contextPath}/comment/edit">

            <input type="hidden"
                   name="commentId"
                   value="${node.id}" />

            <input type="hidden"
                   name="cheatsheetId"
                   value="${cheatsheet.id}" />

            <textarea name="content" required>${node.content}</textarea>

            <button type="submit"
                    class="comment-btn">
                Update
            </button>
        </form>
    </div>

    <c:if test="${not empty node.replies}">
        <button type="button"
                class="reply-btn"
                onclick="toggleNestedReplies(${node.id})">
            View More Replies (${node.replies.size()})
        </button>

        <div id="nested-${node.id}"
             style="display:none; margin-top:10px; margin-left:30px;">

            <c:forEach items="${node.replies}" var="child">
                <c:set var="node" value="${child}" scope="request" />
                <jsp:include page="comment-node.jsp" />
            </c:forEach>

        </div>
    </c:if>

</div>