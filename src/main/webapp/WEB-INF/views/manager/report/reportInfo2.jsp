<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>要抒啦管理員--文章檢舉內容</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
</head>
<body>
	<div class="w-75 border my-5 mx-auto p-4">
		<table class="table table-bordered table-hover">
			<thead>
				<tr>
					<th scope="col" class="text-center">檢舉內容</th>
					<th scope="col" class="text-center">檢舉人數</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th scope="row" class="text-center">惡意洗版</th>
					<td class="text-center">${item0}</td>
				</tr>
				<tr>
					<th scope="row" class="text-center">惡意攻擊他人</th>
					<td class="text-center">${item1}</td>
				</tr>
				<tr>
					<th scope="row" class="text-center">包含色情、血腥等，令人不舒服之內容</th>
					<td class="text-center">${item2}</td>
				</tr>
				<tr>
					<th scope="row" class="text-center">包含廣告、商業宣傳之內容</th>
					<td class="text-center">${item3}</td>
				</tr>
				<tr>
					<th scope="row" class="text-center">與本板主題無關</th>
					<td class="text-center">${item4}</td>
				</tr>
			</tbody>
		</table>
		<!-- 文章============================= -->
		<div class="my-4 border border-dark p-4"
			style="height: 500px; overflow-y: scroll;">
			<c:choose>
				<c:when test="${cmd=='article'|| cmd=='deleteArticle'}">
					<img
						src="<spring:url value='/personPage/getUserImage/${article.authorId}' /> "
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
						src="<spring:url value='/article/getArticleImage/${article.articleId}' /> "
						style="max-width: 200px; max-height: 100px;">
					<div class="" style="clear: both;">${content}</div>

					<div class="d-flex">
						愛心：${article.likes} 留言數：
						<c:choose>
							<c:when test="${not empty article.articleComments}">
								<c:forEach var="comments" items="${article.articleComments}"
									varStatus="number">
									<c:if test="${number.last}">${number.count}</c:if>
								</c:forEach>
							</c:when>
							<c:otherwise>0</c:otherwise>
						</c:choose>
					</div>
				</c:when>
				<c:when test="${cmd == 'comment'|| cmd == 'deleteComment'}">
					<img
						src="<spring:url value='/personPage/getUserImage/${comment.authorId}' /> "
						class="rounded-circle border border-dark"
						style="float: left; height: 100px; width: 100px;">
					<div class="ml-4 my-auto" style="float: left; height: 100px;">
						<div>${comment.authorName}</div>
						<div>
							<fmt:formatDate value="${comment.publishTime}"
								pattern="yyyy-MM-dd HH:mm" />
						</div>
					</div>
					<div style="clear: both;">${comment.content}</div>
				</c:when>
			</c:choose>

		</div>
		<div class="mb-2">
			<div class="row">
				<div
					class="col-8 d-flex justify-content-center align-items-center my-2"></div>
				<div
					class="col-2 d-flex justify-content-center align-items-center my-2">
					<a href="<c:url value='/article/deleteArticle/${cmd}/${id}'/>">
					<input type="button" value="刪除"></a>
				</div>
				<div
					class="col-2 d-flex justify-content-center align-items-center my-2">
					<a href="<c:url value='/article/reserveArticle/${cmd}/${id}'/>">
					<input type="button" value="保留"></a>
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
		src="<spring:url value='/js/article/articleContext.js' /> "></script>

</body>
</html>