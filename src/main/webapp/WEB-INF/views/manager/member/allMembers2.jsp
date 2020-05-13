<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>要抒啦管理員--帳號管理</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous" />
</head>
<body>
	<div class="w-75 my-5 mx-auto">
		<form action="<spring:url value='/member/showMembers'/>">
			<div class="input-group my-3">
				<div class="input-group-prepend">
					<span class="input-group-text"><img
						src="<spring:url value='/image/product/search.png'/>" /></span>
				</div>
				<input type="search" class="form-control" placeholder="搜尋"
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
					class="col-4 d-flex justify-content-center align-items-center my-2">
					帳號</div>
				<div
					class="col-2 d-flex justify-content-center align-items-center my-2">權限</div>
				<div
					class="col-3 d-flex justify-content-center align-items-center my-2">刪除文章/留言</div>
				<div
					class="col-3 d-flex justify-content-center align-items-center my-2">
					帳號狀態</div>
			</div>
			<c:forEach var="entry" items="${member_map}">
				<a
					href="<spring:url value='/member/showManageMemberInfo/${entry.key.id}?reportTimes=${entry.value}'/>"
					style="text-decoration: none; color: black;">
					<div class="row">
						<div
							class="col-4 d-flex justify-content-center align-items-center my-2">
							${entry.key.memberId}</div>
						<div
							class="col-2 d-flex justify-content-center align-items-center my-2">
							${entry.key.permission}</div>
						<div
							class="col-3 d-flex justify-content-center align-items-center my-2">
							${entry.value}</div>
						<div
							class="col-3 d-flex justify-content-center align-items-center my-2">
							${entry.key.status}</div>
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