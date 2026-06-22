<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${cheatsheet.title} - Cheat Sheet</title>

<style>
    *{
        margin:0;
        padding:0;
        box-sizing:border-box;
    }

    body{
        font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background:#f7f1f4;
        color:#333;
        overflow-x:hidden;
    }

    /* Whole page ကို center ချ */
    .page-wrapper{
        width:100%;
        max-width:1280px;
        margin:0 auto;
        padding:30px 24px 60px;
    }

    .header-section{
        margin-bottom:34px;
    }

    .breadcrumb{
        font-size:14px;
        color:#777;
        margin-bottom:12px;
    }

    .breadcrumb a{
        color:#b51f55;
        text-decoration:none;
        font-weight:600;
    }

    .title{
        font-size:32px;
        font-weight:800;
        color:#222;
        margin-bottom:14px;
        line-height:1.25;
    }

    .title span{
        color:#b51f55;
    }

    .description{
        max-width:880px;
        font-size:16px;
        line-height:1.7;
        color:#333;
        font-weight:500;
    }

    /* cards center ကျအောင် */
    .sections-container{
        display:grid;
        grid-template-columns:repeat(3, minmax(0, 1fr));
        gap:28px;
        justify-content:center;
        align-items:start;
        margin:0 auto;
    }

    .card{
        width:100%;
        min-height:420px;
        background:#ffffff;
        border-radius:8px;
        overflow:hidden;
        box-shadow:0 4px 14px rgba(0,0,0,0.10);
        border:1px solid #eeeeee;
        transition:0.2s ease;
    }

    /* Collapse လုပ်ရင် 3-card grid မပျက်ဘဲ section name ပဲကျန်မယ် */
    .card.collapsed{
        min-height:0;
    }

    .card.collapsed .card-body{
        display:none;
    }

    .card-title{
        cursor:pointer;
        display:flex;
        align-items:center;
        justify-content:space-between;
        gap:12px;
        user-select:none;
    }

    .collapse-icon{
        width:30px;
        height:30px;
        border-radius:50%;
        display:inline-flex;
        align-items:center;
        justify-content:center;
        font-size:18px;
        font-weight:900;
        color:${cheatsheet.themeColor};
        background:rgba(0,0,0,0.04);
        flex-shrink:0;
    }

    .card.collapsed .collapse-icon{
        transform:rotate(-90deg);
    }

    .card-title{
        font-size:32px;
        font-weight:800;
        padding:20px 22px 16px;
        color:${cheatsheet.themeColor};
        border-top:5px solid ${cheatsheet.themeColor};
        background:#fff;
        line-height:1.2;
    }

    .card-body{
        padding:0 16px 18px;
    }

    /* ပို့ထားတဲ့ reference ပုံလို table row design */
    .row-block{
        display:grid;
        grid-template-columns:1.2fr 1fr 1fr;
        align-items:center;
        gap:10px;
        padding:12px 16px;
        min-height:54px;
    }

    /* အရောင်ကွက်လေးတွေ */
    .row-block:nth-child(odd){
        background:#ffffff;
    }

    .row-block:nth-child(even){
        background:#f8eef3;
    }

    /* ရှေ့က row / def / orange / wer font ပိုကြီး */
    .cell-key-left{
        text-align:left;
        font-size:18px;
        font-weight:700;
        color:#111;
        line-height:1.3;
        word-break:break-word;
    }

    .row-title-center-bold{
        text-align:left;
        font-size:15px;
        font-weight:400;
        color:#555;
        line-height:1.3;
        word-break:break-word;
    }

    .cell-value-right{
        text-align:left;
        font-size:15px;
        font-weight:400;
        color:#555;
        line-height:1.3;
        word-break:break-word;
    }

    .highlight-box{
        margin:18px 0 0;
        background:#fff8df;
        border-left:4px solid #f0b429;
        padding:14px 16px;
        border-radius:4px;
    }

    .highlight-title{
        font-size:16px;
        font-weight:800;
        color:#9a4b00;
        margin-bottom:8px;
    }

    .highlight-content{
        font-size:15px;
        font-weight:700;
        line-height:1.55;
        color:#333;
    }

    @media(max-width:1100px){
        .sections-container{
            grid-template-columns:repeat(2, minmax(0, 1fr));
        }
    }

    @media(max-width:720px){
        .page-wrapper{
            padding:22px 14px 40px;
        }

        .sections-container{
            grid-template-columns:1fr;
            gap:22px;
        }

        .title{
            font-size:26px;
        }

        .row-block{
            grid-template-columns:64px 1fr;
        }

        .cell-value-right{
            grid-column:2;
        }

        .cell-key-left{
            font-size:18px;
        }

        .row-title-center-bold,
        .cell-value-right{
            font-size:15px;
        }
    }
    /* COMMENTS */
.comments-section{
    margin-top:40px;
    background:#fff;
    border-radius:12px;
    padding:24px;
    box-shadow:0 4px 14px rgba(0,0,0,.08);
}

.comments-title{
    font-size:28px;
    font-weight:800;
    margin-bottom:20px;
}

.comment-form textarea,
.reply-form-wrapper textarea{
    width:100%;
    min-height:90px;
    padding:12px;
    border:1px solid #ddd;
    border-radius:8px;
    resize:vertical;
    font-family:inherit;
}

.comment-btn{
    margin-top:10px;
    padding:10px 18px;
    border:none;
    border-radius:8px;
    cursor:pointer;
    font-weight:700;
    color:#fff;
    background:${cheatsheet.themeColor};
}

.comment-card{
    margin-top:18px;
    padding:16px;
    border:1px solid #eee;
    border-radius:10px;
    background:#fafafa;
}

.comment-user{
    font-weight:700;
    margin-bottom:8px;
}

.comment-content{
    line-height:1.6;
}

.comment-date{
    margin-top:8px;
    font-size:12px;
    color:#777;
}

.reply-btn{
    margin-top:10px;
    padding:6px 12px;
    border:none;
    border-radius:6px;
    cursor:pointer;
}

.reply-form-wrapper{
    margin-top:12px;
}

.reply-card{
    margin-top:12px;
    margin-left:40px;
    padding:12px;
    border-left:4px solid #ddd;
    background:#f5f5f5;
    border-radius:8px;
}
.delete-btn{
    margin-left:8px;
    padding:6px 12px;
    border:none;
    border-radius:6px;
    cursor:pointer;
    background:#dc3545;
    color:white;
    font-weight:600;
}

    
</style>
</head>

<body>

<div class="page-wrapper">

    <div class="header-section">
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/">Home</a> >
            <a href="#">${cheatsheet.category.name}</a> >
            ${cheatsheet.title} Sheets
        </div>

        <h1 class="title">
            ${cheatsheet.title} Cheat Sheet <span>by ${cheatsheet.user.name}</span>
        </h1>

        <p class="description">${cheatsheet.description}</p>
    </div>

    <div class="sections-container">

        <c:forEach items="${cheatsheet.sections}" var="section">

            <div class="card">

                <h3 class="card-title" onclick="toggleSectionCard(this)">
                    <span><c:out value="${section.title}"/></span>
                    <span class="collapse-icon">⌄</span>
                </h3>

                <div class="card-body">

                    <c:forEach items="${section.rows}" var="row">
                        <c:forEach items="${row.cells}" var="cell">

                            <div class="row-block">
                                <div class="cell-key-left">
                                    <c:out value="${row.rowTitle}"/>
                                </div>

                                <div class="row-title-center-bold">
                                    <c:out value="${not empty cell.cellKey ? cell.cellKey : ''}"/>
                                </div>

                                <div class="cell-value-right">
                                    <c:out value="${cell.cellValue}"/>
                                </div>
                            </div>

                        </c:forEach>
                    </c:forEach>

                    <c:forEach items="${section.notes}" var="note">
                        <div class="highlight-box">
                            <c:if test="${not empty note.noteTitle}">
                                <div class="highlight-title">💡 <c:out value="${note.noteTitle}"/></div>
                            </c:if>
                            <div class="highlight-content">
                                <c:out value="${note.noteContent}"/>
                            </div>
                        </div>
                    </c:forEach>

                </div>
            </div>

        </c:forEach>

    </div>

</div>


<!-- COMMENTS SECTION -->

<div class="comments-section">

    <div class="comments-title">
        Comments
    </div>

    <!-- CREATE COMMENT -->

    <form class="comment-form"
          method="post"
          action="${pageContext.request.contextPath}/comment/create">

        <input type="hidden"
               name="cheatsheetId"
               value="${cheatsheet.id}" />

        <textarea name="content"
                  placeholder="Write a comment..."
                  required></textarea>

        <button type="submit"
                class="comment-btn">
            Post Comment
        </button>

    </form>

    <!-- COMMENT LIST -->

    <c:forEach items="${comments}" var="comment">

        <div class="comment-card">

            <div class="comment-user">
                User #${comment.user.id}
            </div>

            <div class="comment-content">
                <c:out value="${comment.content}" />
            </div>

            <div class="comment-date">
                ${comment.createdAt}
            </div>

            <!-- ACTIONS -->

            <button type="button"
                    class="reply-btn"
                    onclick="toggleReplyForm(${comment.id})">
                Reply
            </button>

            <button type="button"
                    class="reply-btn"
                    onclick="toggleEditForm(${comment.id})">
                Edit
            </button>

            <form method="post"
                  action="${pageContext.request.contextPath}/comment/delete"
                  style="display:inline;">

                <input type="hidden"
                       name="commentId"
                       value="${comment.id}" />

                <input type="hidden"
                       name="cheatsheetId"
                       value="${cheatsheet.id}" />

                <button type="submit"
                        class="delete-btn">
                    Delete
                </button>

            </form>

            <!-- EDIT FORM -->

            <div id="edit-form-${comment.id}"
                 class="reply-form-wrapper"
                 style="display:none;">

                <form method="post"
                      action="${pageContext.request.contextPath}/comment/edit">

                    <input type="hidden"
                           name="commentId"
                           value="${comment.id}" />

                    <input type="hidden"
                           name="cheatsheetId"
                           value="${cheatsheet.id}" />

                    <textarea name="content"
                              required>${comment.content}</textarea>

                    <button type="submit"
                            class="comment-btn">
                        Update
                    </button>

                </form>

            </div>

            <!-- REPLY FORM -->

            <div id="reply-form-${comment.id}"
                 class="reply-form-wrapper"
                 style="display:none;">

                <form method="post"
                      action="${pageContext.request.contextPath}/comment/reply">

                    <input type="hidden"
                           name="cheatsheetId"
                           value="${cheatsheet.id}" />

                    <input type="hidden"
                           name="parentCommentId"
                           value="${comment.id}" />

                    <textarea name="content"
                              required></textarea>

                    <button type="submit"
                            class="comment-btn">
                        Post Reply
                    </button>

                </form>

            </div>

            <!-- REPLIES -->
            <c:forEach items="${comment.replies}" var="reply">

                <c:set var="node" value="${reply}" scope="request" />

                <jsp:include page="comment-node.jsp" />

            </c:forEach>
        </div>

    </c:forEach>

</div>





<script>
function toggleSectionCard(titleElement){
    var card = titleElement.closest('.card');
    if(card){
        card.classList.toggle('collapsed');
    }
}

function toggleReplyForm(commentId){
    var form = document.getElementById('reply-form-' + commentId);

    if(form){
        form.style.display =
            form.style.display === 'none' || form.style.display === ''
                ? 'block'
                : 'none';
    }
}

function toggleEditForm(commentId){
    var form = document.getElementById('edit-form-' + commentId);

    if(form){
        form.style.display =
            form.style.display === 'none' || form.style.display === ''
                ? 'block'
                : 'none';
    }
}

function toggleNestedReplies(replyId){
    var el = document.getElementById('nested-' + replyId);

    if(el){
        el.style.display =
            el.style.display === 'none' || el.style.display === ''
                ? 'block'
                : 'none';
    }
}
</script>

</body>
</html>