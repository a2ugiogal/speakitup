<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>要抒啦--文章內容</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
</head>
<body>
	<div class="w-75 border">
		<div>
			<div style="text-align: right;">
			<c:if test="${not empty LoginOK}">
				<input type="button" class="report" value="檢舉"
					onclick="showReportModal('')" />
			</c:if>
			</div>
			<img
				src="${pageContext.request.contextPath}/init/getUserImage?id=${article.authorId}"
				class="rounded-circle border border-dark"
				style="float: left; height: 100px; width: 100px;">
			<div class="ml-4 my-auto" style="float: left; height: 100px;">
				<div>${article.title}${article.category.categoryName}</div>
				<div>${article.authorName}</div>
				<div>
					<fmt:formatDate value="${article.publishTime}"
						pattern="yyyy-MM-dd HH:mm" />
				</div>
			</div>
			<img
				src="${pageContext.request.contextPath}/init/getArticleImage?id=${article.articleId}"
				style="max-width: 200px; max-height: 100px;">
			<div class="" style="clear: both;">${content}</div>

			<div class="d-flex">
				<c:set var="articleIds"
					value="${fn:split(LoginOK.likeArticles, ',')}"></c:set>
				<a href="<c:url value='/article/LikeArticle?login=true'/>"><input
					type="button" value="愛心"
					<c:forEach var="entry" items="${articleIds}">${entry}
					<c:if test="${entry==''+article.articleId}"> disabled="disabled" style="border:1px solid red;color: red;" </c:if>
				</c:forEach>></a>${article.likes}
				留言數：
				<c:choose>
					<c:when test="${not empty comments_set}">
						<c:forEach var="comments" items="${comments_set}"
							varStatus="number">
							<c:if test="${number.last}">${number.count}</c:if>
						</c:forEach>
					</c:when>
					<c:otherwise>0</c:otherwise>
				</c:choose>
			</div>
		</div>
		<!-- 		留言區=========================================== -->
		<c:forEach var="entry" varStatus="number" items="${comments_set}">
			<hr>
			<div style="text-align: right;">
				<c:if test="${not empty LoginOK}">
					<input type="button" class="report" value="檢舉"
						onclick="showReportModal('${entry.commentId}')" />
				</c:if>
			</div>
			<img
				src="${pageContext.request.contextPath}/init/getUserImage?id=${entry.authorId}"
				class="rounded-circle border border-dark"
				style="float: left; height: 100px; width: 100px;">
			<div class="ml-4 my-auto" style="float: left; height: 100px;">
				<div>${entry.authorName}</div>
				<div>
					B${number.index+1}
					<fmt:formatDate value="${entry.publishTime}"
						pattern="yyyy-MM-dd HH:mm" />
				</div>
			</div>
			<div class="" style="clear: both;">${entry.content}</div>
		</c:forEach>
	</div>
	<!-- 	可留言處============================ -->
	<form method="POST" action="<c:url value='/article/AddComment'/>">
		<div class="border w-75 d-flex" style="position: fixed; bottom: 2%;">
			<img class="rounded-circle border-dark border my-auto"
				style="width: 50px; height: 50px;"
				src="${pageContext.request.contextPath}/init/getUserImage?id=${LoginOK.id}">
			<p>留言：</p>
			<textarea class="w-75" name="content" id="" cols="" rows="2"></textarea>
			<input class="ml-1 my-auto" type="submit" style="height: 40px;"
				value="送出">
		</div>
	</form>

	<!-- 檢舉 浮動視窗========== -->
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog"
		aria-labelledby="reportModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="reportModalLabel">檢舉</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<input type="radio" name="reportItem" value="惡意洗版" checked />惡意洗版<br />
					<input type="radio" name="reportItem" value="惡意攻擊他人" />惡意攻擊他人<br />
					<input type="radio" name="reportItem" value="包含色情、血腥等，令人不舒服之內容" />包含色情、血腥等，令人不舒服之內容<br />
					<input type="radio" name="reportItem" value="包含廣告、商業宣傳之內容" />包含廣告、商業宣傳之內容<br />
					<input type="radio" name="reportItem" value="與本板主題無關" />與本板主題無關
				</div>
				<input type="hidden" id="commentIdInput" value="">
				<div class="modal-footer">
					<input type="button" class="btn btn-primary" value="送出"
						id="sendReport" />
				</div>
			</div>
		</div>
	</div>


	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
		integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
		integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
		crossorigin="anonymous"></script>
	<script
		src="${pageContext.request.contextPath}/js/_06_article/articleContext.js"></script>

</body>
</html>