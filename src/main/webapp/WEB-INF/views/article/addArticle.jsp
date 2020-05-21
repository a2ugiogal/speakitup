<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>要抒啦--新增文章</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="<spring:url value='/css/article/addArticle.css' />" />
<link rel="stylesheet"
	href="<spring:url value='/css/article/nav.css' />" />
<script src="<spring:url value='/js/article/addArticle.js' /> "></script>
</head>
<body>
	<!-- =======================導覽列================= -->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top p-0"
		id="navBody">
		<div class="mr-auto">
			<button id="hamberger-btn" class="navbar-toggler ml-3" type="button"
				data-toggle="collapse" data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<a class="navbar-brand ml-3" href="<spring:url value='/' />"> <img
				src="<spring:url value='/image/logo/logo_trans_92px.png' /> "
				height="50px" /> 要抒拉
			</a>
		</div>
		<div class="navbar-nav flex-row ml-auto"
			style="position: absolute; right: 250px; top: 10px;">
			<form class="form-inline mr-5">
				<input class="form-control mr-sm-2" type="search" id="search"
					placeholder="Search" aria-label="Search" />
				<button class="btn d-flex justify-content-center" type="submit"
					id="search-btn">Search</button>
			</form>
		</div>
		<div class="navbar-nav flex-row ml-auto"
			style="position: absolute; right: 0; top: 10px;">
			<!-- ==========判斷是否登入======== -->
			<c:choose>
				<c:when test="${empty LoginOK}">
					<a class="navbar-brand mr-5"
						href="<spring:url value='/member/login' />">登入</a>
					<a class="navbar-brand mr-5"
						href="<spring:url value='/member/register' />">註冊</a>
				</c:when>
				<c:otherwise>
					<div style="width: 160px;">
						<a id="nav-memberId" class="mr-4"
							href="<spring:url value='/member/personPage' />"
							style="text-decoration: none;"> <img id="nav-memberPicture"
							src="<spring:url value='/member/getUserImage/${LoginOK.id}' />"
							width="45px" height="45px" class="rounded-circle mr-2" />
							${LoginOK.memberId}
						</a>
					</div>
					<a class="navbar-brand mr-5"
						href="<spring:url value='/member/logout' />">登出</a>
				</c:otherwise>
			</c:choose>
		</div>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item dropdown mx-2"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> 論壇 </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item"
							href="<spring:url value='/article/showPageArticles?categoryTitle=天使' />">天使板</a>
						<a class="dropdown-item"
							href="<spring:url value='/article/showPageArticles?categoryTitle=惡魔' />">惡魔板</a>
					</div></li>
				<li class="nav-item dropdown mx-2"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> 商城 </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="/product/productHome">首頁</a> <a class="dropdown-item"
							href="<spring:url value='/order/shoppingCartList' />">購物車</a> <a
							class="dropdown-item"
							href="<spring:url value='/order/showHistoryOrder' />">歷史訂單</a>
					</div></li>
				<li class="nav-item mx-2"><a class="nav-link"
					href="<spring:url value='/letter/letterHome' />">漂流瓶</a></li>
				<c:if test="${LoginOK.permission=='管理員'}">
					<li class="nav-item dropdown mx-2"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"> 管理後台 </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item"
								href="<spring:url value='/article/showReports' />">檢舉專區</a> <a
								class="dropdown-item"
								href="<spring:url value='/member/showMembers' />">帳號管理</a> <a
								class="dropdown-item"
								href="<spring:url value='/order/showOrders' />">訂單管理</a><a
								class="dropdown-item"
								href="<spring:url value='/product/showProducts' />">商品管理</a>
						</div></li>
				</c:if>
				<li class="nav-item dropdown mx-2 mb-1"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> 關於我們 </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">創建理念</a> <a
							class="dropdown-item" href="#">團隊介紹</a> <a class="dropdown-item"
							href="#">聯絡我們</a>
					</div></li>
			</ul>
		</div>
	</nav>
	<!-- 導覽列 -->


	<form:form modelAttribute="articleBean" enctype="multipart/form-data">
		<div class="container changeBgR">
			<h1 class="mb-4">發表新文章</h1>
			<div class="row m-0">
				<div
					class="col-md-12 col-lg-6 p-0 d-flex flex-column align-items-start justify-content-start">
					<div class="row m-2 mb-5 mt-2 d-flex align-items-center w-100">
						<h5>標題：</h5>
						<form:input class="form-control" type="text" required="required"
							placeholder="標題" path="title" id="titleInput" />
					</div>
					<div class="row m-2 mb-5 d-flex align-items-center">
						<h5>主板：</h5>
						<select class="m-2 form-control select" name="categoryTitle">
							<option value="天使" id="angel">天使</option>
							<option value="惡魔" id="evil">惡魔</option>
						</select>
					</div>
					<div class="row m-2 mb-5 d-flex align-items-center">
						<h5>副板：</h5>
						<select class="m-2 form-control select" name="categoryName">
							<option value="生活">生活</option>
							<option value="感情">感情</option>
							<option value="工作">工作</option>
							<option value="時事">時事</option>
						</select>
					</div>
				</div>
				<div class="col-md-12 col-lg-6 p-0">
					<div class="row m-2 d-flex align-items-center">
						<h5>文章圖片：</h5>
					</div>
					<div id="articlePictureBox" class="text-center">
						<img id="articlePicture" src="<spring:url value='/image/article/noImages.png' />" />
					</div>
					<div class="form-group m-3">
						<p id="file">
							<form:input type="file" id="fileSelect" path="articleImage"
								style="visibility: hidden;" />
							<label for="fileSelect" id="fileLabel"
								class="d-flex align-items-center justify-content-center rounded changeBtR">上傳文章圖片</label>
						</p>
					</div>
				</div>
			</div>

			<div class="border"></div>

			<div class="form-group m-2 pt-4">
				<h5>內文：</h5>
				<textarea class="form-control" name="contentStr" rows="10"
					required="required" style="resize: none;"></textarea>
			</div>
			<div class="text-center mt-3">
				<input type="submit" class="btn changeBtR" style="color: white;"
					id="submitBt" />
			</div>
		</div>
	</form:form>

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