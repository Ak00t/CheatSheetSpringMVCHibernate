<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="p-3 my-2 border-start border-3 bg-white rounded shadow-sm ms-3 ms-md-4">
    <div class="d-flex justify-content-between align-items-center mb-2">
        <div class="d-flex align-items-center gap-2">
            <div class="bg-dark-subtle rounded-circle d-flex align-items-center justify-content-center text-dark fw-bold text-uppercase" style="width:28px; height:28px; font-size:10px;">
                ${node.user.name.substring(0,2)}
            </div>
            <div>
                <span class="fw-bold text-dark small">${node.user.name}</span>
                <span class="text-muted ms-2" style="font-size:10px;"><i class="bi bi-clock me-1"></i>${node.relativeTime}</span>
            </div>
        </div>

        <div class="dropdown">
            <button class="btn btn-link text-secondary p-0 shadow-none" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="bi bi-three-dots"></i>
            </button>
            <ul class="dropdown-menu dropdown-menu-end shadow border-0 py-2">
                <c:choose>
                    <c:when test="${node.user.id == sessionScope.currentUser.id}">
                        <li>
                            <a class="dropdown-item d-flex align-items-center gap-2 text-primary py-1" href="javascript:void(0);" onclick="toggleEditForm(${node.id})">
                                <i class="bi bi-pencil-square"></i> Edit Reply
                            </a>
                        </li>
                        <li><hr class="dropdown-divider my-1"></li>
                        <li>
                            <form method="post" action="${pageContext.request.contextPath}/comment/delete">
                                <input type="hidden" name="commentId" value="${node.id}" />
                                <input type="hidden" name="cheatsheetId" value="${cheatsheet.id}" />
                                <button type="submit" class="dropdown-item d-flex align-items-center gap-2 text-danger py-1" onclick="return confirm('Delete this reply?')">
                                    <i class="bi bi-trash3-fill"></i> Delete Reply
                                </button>
                            </form>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li>
                            <a class="dropdown-item d-flex align-items-center gap-2 text-warning py-1" href="javascript:void(0);" onclick="triggerReportAction(${node.id})">
                                <i class="bi bi-exclamation-triangle-fill"></i> Report Abuse
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
                <li><hr class="dropdown-divider my-1"></li>
                <li>
                    <a class="dropdown-item d-flex align-items-center gap-2 text-success py-1" href="javascript:void(0);" onclick="translateComment(${node.id}, 'my')">
                        <i class="bi bi-translate"></i> Translate
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <div class="small text-secondary px-1 mb-2 fs-6" id="comment-text-${node.id}">
        <c:out value="${node.content}" />
    </div>

    <div class="d-flex align-items-center gap-2">
        <button type="button" class="btn btn-sm btn-link text-decoration-none text-muted p-0 small fw-bold" style="font-size:12px;" onclick="toggleReplyForm(${node.id})">
            <i class="bi bi-reply-fill"></i> Reply
        </button>
    </div>

    <div id="edit-form-${node.id}" class="mt-2 p-2 bg-light rounded border" style="display:none;">
        <form method="post" action="${pageContext.request.contextPath}/comment/edit">
            <input type="hidden" name="commentId" value="${node.id}" />
            <input type="hidden" name="cheatsheetId" value="${cheatsheet.id}" />
            <div class="mb-2">
                <textarea class="form-control form-control-sm" name="content" required>${node.content}</textarea>
            </div>
            <div class="d-flex gap-1 justify-content-end">
                <button type="button" class="btn btn-secondary py-1 px-2 text-uppercase fw-bold" style="font-size:10px;" onclick="toggleEditForm(${node.id})">Cancel</button>
                <button type="submit" class="btn btn-primary py-1 px-2 text-uppercase fw-bold" style="font-size:10px;">Update</button>
            </div>
        </form>
    </div>

    <div id="reply-form-${node.id}" class="mt-2 p-2 bg-light rounded border" style="display:none;">
        <form method="post" action="${pageContext.request.contextPath}/comment/post">
            <input type="hidden" name="cheatsheetId" value="${cheatsheet.id}" />
            <input type="hidden" name="parentCommentId" value="${node.id}" />
            <div class="mb-2">
                <textarea class="form-control form-control-sm" placeholder="Write a reply..." name="content" required></textarea>
            </div>
            <div class="d-flex gap-1 justify-content-end">
                <button type="button" class="btn btn-secondary py-1 px-2 text-uppercase fw-bold" style="font-size:10px;" onclick="toggleReplyForm(${node.id})">Cancel</button>
                <button type="submit" class="btn btn-dark py-1 px-2 text-uppercase fw-bold" style="font-size:10px;">Post</button>
            </div>
        </form>
    </div>

    <c:if test="${not empty node.replies}">
        <div class="mt-2">
            <button type="button" class="btn btn-sm btn-link p-0 text-decoration-none small text-primary fw-bold" style="font-size:11px;" onclick="toggleNestedReplies(${node.id})">
                <i class="bi bi-arrows-expand me-1"></i> View More Replies (${node.replies.size()})
            </button>
            <div id="nested-${node.id}" style="display:none;">
                <c:forEach items="${node.replies}" var="child">
                    <c:set var="node" value="${child}" scope="request" />
                    <jsp:include page="comment-node.jsp" />
                </c:forEach>
            </div>
        </div>
    </c:if>
</div>
