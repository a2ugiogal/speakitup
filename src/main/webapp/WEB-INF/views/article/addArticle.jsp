<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>要抒啦--新增文章</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<script src="${pageContext.request.contextPath}/js/_06_article/addArticle.js"></script>
</head>
<body>
	<form method="POST" action="<c:url value='/article/AddArticle'/>" enctype="multipart/form-data">
		<div class="w-75 border p-3">
			<h1>發表新文章</h1>
			主板： <select class="m-2" style="width: 150px;" name="categoryTitle">
				<option value="天使">天使</option>
				<option value="惡魔">惡魔</option>
			</select> 副板： <select class="m-2" style="width: 150px;" name="categoryName">
				<option value="生活">生活</option>
				<option value="感情">感情</option>
				<option value="工作">工作</option>
				<option value="時事">時事</option>
			</select>
			<div class="form-group m-2">
				<input class="form-control" type="text" required="required"
					placeholder="標題" name="title">
			</div>
			<img id="articlePicture" />
			<div class="form-group m-2">
				<input type="file" id="fileSelect" name="articlePicture"/>
			</div>
			<div class="form-group m-2">
				<textarea class="form-control" name="content" rows="10"
					required="required" placeholder="內文..." style="resize: none;"></textarea>
			</div>
			<input type="submit">
		</div>
	</form>

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