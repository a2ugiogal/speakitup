<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>要抒啦管理員--檢舉專區</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous" />
</head>
<body>
	<div class="w-75 my-5 mx-auto">
		<ul class="nav nav-tabs nav-justified ">
			<li class="nav-item"><a class="nav-link"
				href="<spring:url value='/article/showReports?cmd=article'/>"
				style="text-decoration: none; color: black;">文章</a></li>
			<li class="nav-item"><a class="nav-link"
				href="<spring:url value='/article/showReports?cmd=comment'/>"
				style="text-decoration: none; color: black;">留言</a></li>
		</ul>

		<form action="<spring:url value='/article/showReports'/>">
			<input type="hidden" value="${cmd}" name="cmd">
			<div class="input-group my-3">
				<div class="input-group-prepend">
					<span class="input-group-text"><img
						src="<spring:url value='/image/product/search.png' /> " /></span>
				</div>
				<c:choose>
					<c:when test='${cmd=="article"}'>
						<c:set var="cmdSearch" value="搜尋: 文章標題"></c:set>
					</c:when>
					<c:otherwise>
						<c:set var="cmdSearch" value="搜尋: 留言內容"></c:set>
					</c:otherwise>
				</c:choose>
				<input type="search" class="form-control" placeholder="${cmdSearch}"
					name="searchStr" aria-label="Sizing example input"
					aria-describedby="inputGroup-sizing-default" value="${searchStr}" />

				<div class="input-group-append">
					<button class="btn btn-outline-secondary" id="button-addon2">
						搜尋</button>
				</div>
			</div>
		</form>

		<div class="container-fluid"
			style="border: 1px solid rgba(0, 0, 0, 0.575);">
			<div class="row">
				<div
					class="col-2 d-flex justify-content-center align-items-center my-2">
					<c:choose>
						<c:when test="${cmd=='article'}">標題編號</c:when>
						<c:otherwise>留言編號</c:otherwise>
					</c:choose>
				</div>
				<div
					class="col-3 d-flex justify-content-center align-items-center my-2">帳號</div>
				<div
					class="col-2 d-flex justify-content-center align-items-center my-2">發文日期</div>
				<div
					class="col-3 d-flex justify-content-center align-items-center my-2">
					<c:choose>
						<c:when test="${cmd=='article'}">標題編號</c:when>
						<c:otherwise>留言編號</c:otherwise>
					</c:choose>
				</div>
				<div
					class="col-2 d-flex justify-content-center align-items-center my-2">檢舉數</div>
			</div>
			<c:choose>
				<c:when test='${cmd=="article"}'>
					<c:set var="cmdName" value="${article_map}"></c:set>
				</c:when>
				<c:otherwise>
					<c:set var="cmdName" value="${comment_map}"></c:set>
				</c:otherwise>
			</c:choose>
			<c:forEach var="entry" items="${cmdName}">
				<c:choose>
					<c:when test='${cmd=="article"}'>
						<c:set var="cmdId" value="${entry.key.articleId}"></c:set>
					</c:when>
					<c:otherwise>
						<c:set var="cmdId" value="${entry.key.commentId}"></c:set>
					</c:otherwise>
				</c:choose>
				<a
					href="<spring:url value='/article/showReportInfo/${cmdId}/${cmd}'/>"
					style="text-decoration: none; color: black;">
					<div class="row">
						<div
							class="col-2 d-flex justify-content-center align-items-center my-2">${cmdId}</div>
						<div
							class="col-3 d-flex justify-content-center align-items-center my-2">${entry.key.authorName}</div>
						<div
							class="col-2 d-flex justify-content-center align-items-center my-2">
							<fmt:formatDate value="${entry.key.publishTime}"
								pattern="yyyy-MM-dd" />
						</div>
						<div
							class="col-3 d-flex justify-content-center align-items-center my-2">
							<c:choose>
								<c:when test="${cmd=='article'}">${entry.key.title}</c:when>
								<c:otherwise>${entry.key.content}</c:otherwise>
							</c:choose>
						</div>
						<div
							class="col-2 d-flex justify-content-center align-items-center my-2">${entry.value}</div>
					</div>
				</a>
			</c:forEach>

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

</body>
</html>