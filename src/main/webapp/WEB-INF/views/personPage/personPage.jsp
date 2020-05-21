<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>個人頁面--要抒啦</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous" />
<link
	href="https://cdn.jsdelivr.net/npm/boxicons@2.0.5/css/boxicons.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="<spring:url value='/css/personPage/personPage.css' />" />
<link rel="stylesheet"
	href="<spring:url value='/css/register/nav.css' /> " />
<!-- 下拉式地址 -->
<script
	src="https://cdn.jsdelivr.net/npm/tw-city-selector@2.1.0/dist/tw-city-selector.min.js"></script>
<!-- 下拉式地址 -->
</head>
<body>
	<!-- =======================導覽列================= -->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top p-0"
		style="margin-bottom: 200px" id="navBody">
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
			<!-- 			<form class="form-inline mr-5"> -->
			<!-- 				<input class="form-control mr-sm-2" type="search" id="search" -->
			<!-- 					placeholder="Search" aria-label="Search" /> -->
			<!-- 				<button class="btn d-flex justify-content-center" type="submit" -->
			<!-- 					id="search-btn">Search</button> -->
			<!-- 			</form> -->
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
					<div style="width: 150px;">
						<a class="mr-4" href="<spring:url value='/member/personPage' />"
							style="text-decoration: none;" id="nav-memberId"> <img
							src="<spring:url value='/member/getUserImage/${LoginOK.id}' />"
							width="45px" height="45px" class="rounded-circle mr-2"
							id="nav-memberPicture" /> ${LoginOK.memberId}
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
				<c:choose>
					<c:when test="${empty LoginOK}">
						<li class="nav-item mx-2"><a class="nav-link"
							href="<spring:url value='/product/productHome' />">商城</a></li>
					</c:when>
					<c:otherwise>
						<li class="nav-item dropdown mx-2"><a
							class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> 商城 </a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdown">
								<a class="dropdown-item"
									href="<spring:url value='/product/productHome' />">首頁</a> <a
									class="dropdown-item"
									href="<spring:url value='/order/shoppingCartList' />">購物車</a> <a
									class="dropdown-item"
									href="<spring:url value='/order/showHistoryOrder' />">歷史訂單</a>
							</div></li>
					</c:otherwise>
				</c:choose>
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
							href="<spring:url value='/aboutUs/contact' />">聯絡我們</a>
					</div></li>
			</ul>
		</div>
	</nav>
	<!-- 導覽列 -->
	<!-- ======main=======個人頁面從這裡開始 -->
	<%-- 	<form:form modelAttribute="memberBean" method="POST" --%>
	<%-- 		enctype="multipart/form-data" id="personForm" class="py-4" --%>
	<%-- 		style="margin-top: 60px"> --%>
	<div id="personForm" class="py-4" style="margin-top: 60px">
		<div class="container rounded my-5" id="personPage"
			style="background-color: white; height: 544px;">
			<div class="row my-5">
				<!-- 左側欄 -->
				<div
					class="col-lg-4 pull-lg-8 text-xs-center d-flex flex-column align-items-center"
					id="left">
					<!-- 編輯的按鈕 -->
					<div id="boxHeadPicture">
						<!-- 大頭貼照 -->
						<img
							src="<spring:url value='/member/getUserImage/${LoginOK.id}' />"
							class="m-x-auto mt-5 img-fluid img-circle rounded-circle"
							style="border: 3px solid rgb(196, 190, 190); width: 120px; height: 120px"
							alt="avatar" id="headPicture" />
					</div>
					<div id="boxFileSelect"
						class="d-flex text-center w-75 mx-auto mt-2 mb-1">
						<!-- 上傳檔案 -->
						<input type="file" style="visibility: hidden;" id="fileSelect"
							class="w-100 mt-1" />
					</div>
					<label class="custom-file d-flex flex-column align-items-center">
						<div class="text-center">
							<p class="mb-2">
								<strong id="idStr">${LoginOK.memberId}</strong>
							</p>
							<!-- 這裡的字可以再議 -->
							<p class="mb-3" id="permissionStr">${LoginOK.permission}</p>
						</div>

						<div class="card mx-auto text-center" style="width: 14rem; z-index: 1000">
							<ul class="list-group list-group-flush">
								<li class="list-group-item" id="edit">編輯檔案<i
									class="bx bx-edit ml-1"></i>
								</li>
								<a href="<spring:url value='/member/showMyArticles' />">
									<li class="list-group-item">我的文章<i class="bx bx-file ml-1"></i></li>
								</a>
								<a href="<spring:url value='/letter/myLetters' />">
									<li class="list-group-item">我的漂流信<i
										class="bx bx-paper-plane ml-1"></i>
								</li>
								</a>
							</ul>
						</div>
					</label>
				</div>

				<!-- 右側欄 -->
				<div class="col-lg-8 push-lg-4" id="right">
					<div class="tab-content">
						<h2 class="m-y-2 mt-5 mb-4">會員檔案</h2>

						<div class="form-group row">
							<label
								class="col-lg-2 col-form-label form-control-label personalTitle">帳號</label>
							<label
								class="col-lg-8 col-form-label form-control-label personal">
								${LoginOK.memberId}</label>
						</div>
						<div class="form-group row">
							<label
								class="col-lg-2 col-form-label form-control-label personalTitle">性別</label>
							<label
								class="col-lg-8 col-form-label form-control-label personal">
								${LoginOK.gender}</label>
						</div>
						<div class="form-group row">
							<label
								class="col-lg-2 col-form-label form-control-label personalTitle">生日</label>
							<label
								class="col-lg-8 col-form-label form-control-label personal">${LoginOK.birthday}
							</label>
						</div>
						<div class="form-group row">
							<label
								class="col-lg-2 col-form-label form-control-label personalTitle">E-mail</label>
							<label
								class="col-lg-8 col-form-label form-control-label personal">
								${LoginOK.email}</label>
						</div>
						<div class="form-group row">
							<label
								class="col-lg-2 col-form-label form-control-label personalTitle">手機</label>
							<label
								class="col-lg-8 col-form-label form-control-label personalUpdate">
								<span id="phone">${LoginOK.phone}</span>
							</label>
						</div>
						<div class="form-group row">
							<label
								class="col-lg-2 col-form-label form-control-label personalTitle">地址</label>
							<label
								class="col-lg-8 col-form-label form-control-label personalUpdate">
								<span id="city">${LoginOK.city}</span><span id="area">${LoginOK.area}</span><span
								id="address">${LoginOK.address}</span>
							</label>
						</div>

						<div class="form-group row">
							<div class="col-lg-10 d-flex justify-content-center">
								<input type="button" class="btn btn-secondary mr-2"
									style="visibility: hidden;" id="btCancel" value="取消" />
								<input class="btn btn-primary ml-2" style="visibility: hidden;"
									id="btSubmit" type="button" value="儲存" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%-- 	</form:form> --%>




	<!--========= footer================= -->
	<!-- Footer -->
	<footer class="page-footer font-small stylish-color-dark pt-2">
		<!-- Footer Links -->
		<div class="container text-center text-md-left mt-3">
			<!-- Grid row -->
			<div class="row">
				<div
					class="col-md-2 d-flex justify-content-center align-items-center">
					<img
						src="https://github.com/sun0722a/yaoshula/blob/master/src/logo/logo_trans_140px.png?raw=true"
						width="120px" alt="" />
				</div>
				<!-- Grid column -->

				<div class="col-md-4 mx-auto">
					<!-- Content -->
					<h5 class="font-weight-bold text-uppercase mb-3">要抒啦！ 網路論壇&商城
					</h5>
					<p id="footer-introdution" class="text-secondary">
						是個能夠預期回應溫度的論壇空間。希望在亂世間提供一個烏托邦式的空間，讓大家可以盡情釋放壓力，得到慰藉❤️。</p>
					<div class="d-flex"></div>
				</div>
				<!-- Grid column -->

				<hr class="clearfix w-100 d-md-none" />

				<!-- Grid column -->
				<div class="col-md-2 mx-auto">
					<!-- Links -->
					<h5 class="font-weight-bold text-uppercase mb-3">論壇</h5>

					<ul class="list-unstyled">
						<li><a
							href="<spring:url value='/article/showPageArticles?categoryTitle=天使' />">天使版</a></li>
						<li><a
							href="<spring:url value='/article/showPageArticles?categoryTitle=惡魔' />">惡魔版</a></li>
						<li><a href="<spring:url value='/letter/letterHome' />">漂流信</a></li>
					</ul>
				</div>
				<!-- Grid column -->

				<hr class="clearfix w-100 d-md-none" />

				<!-- Grid column -->
				<div class="col-md-2 mx-auto">
					<!-- Links -->
					<h5 class="font-weight-bold text-uppercase mb-3">商城</h5>

					<ul class="list-unstyled">
						<li><a href="<spring:url value='/product/productHome' />">商城首頁</a></li>
						<li><a href="<spring:url value='/order/shoppingCartList' />">我的購物車</a></li>
						<li><a href="<spring:url value='/order/showHistoryOrder' />">歷史訂單</a></li>
					</ul>
				</div>
				<!-- Grid column -->

				<hr class="clearfix w-100 d-md-none" />

				<!-- Grid column -->
				<div class="col-md-2 mx-auto">
					<!-- Links -->
					<h5 class="font-weight-bold text-uppercase mb-3">關於我們</h5>

					<ul class="list-unstyled">
						<li><a href="<spring:url value='/aboutUs/contact' />">聯絡我們</a></li>
						<li><a href="#!">服務條款</a></li>
						<li><a href="#!">隱私權政策</a></li>
					</ul>
				</div>
				<!-- Grid column -->
			</div>
			<!-- Grid row -->
		</div>

		<!-- Copyright -->
		<div class="footer-copyright text-center mt-0 pb-3"
			style="font-size: 15px;">© 2020 Copyright © 2020 Speak It Up.
			All rights reserved</div>
		<!-- Copyright -->
	</footer>
	<!-- Footer -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"
		integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
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
		src="<spring:url value='/js/personPage/updatePersonPage.js' /> "></script>
</body>
</html>
