<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>要抒啦--論壇首頁</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<script
	src="<spring url value='/js/_06_article/articlePage.js' /> "></script>
</head>
<body>
	<div class="w-75 m-auto">
		天使板 <a
			href="<c:url value='/article/ShowPageArticles?categoryTitle=天使' />">全部</a>
		<a
			href="<c:url value='/article/ShowPageArticles?categoryTitle=天使&categoryName=工作' />">工作</a>
		<a
			href="<c:url value='/article/ShowPageArticles?categoryTitle=天使&categoryName=感情' />">感情</a>
		<a
			href="<c:url value='/article/ShowPageArticles?categoryTitle=天使&categoryName=生活' />">生活</a>
		<a
			href="<c:url value='/article/ShowPageArticles?categoryTitle=天使&categoryName=時事' />">時事</a>
		惡魔板 <a
			href="<c:url value='/article/ShowPageArticles?categoryTitle=惡魔' />">全部</a>
		<a
			href="<c:url value='/article/ShowPageArticles?categoryTitle=惡魔&categoryName=工作' />">工作</a>
		<a
			href="<c:url value='/article/ShowPageArticles?categoryTitle=惡魔&categoryName=感情' />">感情</a>
		<a
			href="<c:url value='/article/ShowPageArticles?categoryTitle=惡魔&categoryName=生活' />">生活</a>
		<a
			href="<c:url value='/article/ShowPageArticles?categoryTitle=惡魔&categoryName=時事' />">時事</a>

		<!-- 		搜尋======================================== -->
		<form action="<c:url value='/article/ShowPageArticles' />"
			id="searchForm">
			<input type="hidden" value="${categoryTitle}" name="categoryTitle">
			<input type="hidden" value="${categoryName}" name="categoryName">
			<div id="searchTop" class="row">
				<div class="input-group my-3 col-9 ">
					<div class="input-group-prepend">
						<span class="input-group-text">
						<img src="<spring:url value='/image/_05_product/search.png' /> " /></span>
					</div>
					<input type="search" class="form-control" placeholder="搜尋: 文章標題"
						name="search" aria-label="Sizing example input"
						aria-describedby="inputGroup-sizing-default" value="${searchStr}" />
					<div class="input-group-append">
						<button class="btn btn-outline-secondary" id="button-addon2">搜尋</button>
					</div>
				</div>
				<div id="arrange"
					class="col-3 my-3 d-flex justify-content-end align-items-center">
					<span style="font-size: 10px;">排序：</span> <select name="arrange">
						<option value="popular"
							<c:if test="${arrange=='popular'}"> selected </c:if>>熱門</option>
						<option value="time"
							<c:if test="${arrange=='time'}"> selected </c:if>>最新</option>
					</select>
				</div>
			</div>
		</form>
		<hr>
		<!-- 		文章列========================================= -->
		<c:forEach var="entry" items="${articles_map}">
			<a
				href="<spring:url value='/article/ShowArticleContent/${entry.value.articleId}'/>">
				<div class="rounded-pill border m-4">
					<div
						class="d-flex mx-auto justify-content-center align-items-center"
						style="text-align: center;">
						<img
							src="<spring:url value='/article/getArticleImage/${entry.value.articleId}' /> "
							style="max-width: 200px; max-height: 100px;" /> 
							<img
							src="<spring:url value='/personPage/getUserImage/${entry.value.authorId}' /> "
							class="rounded-circle border border-dark"
							style="height: 100px; width: 100px;" />
						<div class="ml-4 my-auto" style="height: 100px;">
							<div>${entry.value.title}
								${entry.value.category.categoryName}</div>
							<div>${entry.value.authorName}</div>
							<div>
								<fmt:formatDate value="${entry.value.publishTime}"
									pattern="yyyy-MM-dd" />
							</div>
						</div>
						<div class="d-flex">
							愛心：${entry.value.likes} 留言數：
							<c:choose>
								<c:when test="${not empty entry.value.articleComments}">
									<c:set var="i" value="0"></c:set>
									<c:forEach var="comments"
										items="${entry.value.articleComments}" varStatus="number">
										<c:if test="${comments.status=='正常'}">
											<c:set var="i" value="${i+1}"></c:set>
										</c:if>
										<c:if test="${number.last}">
											${i}
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>0</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</a>
		</c:forEach>
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
</body>
</html>