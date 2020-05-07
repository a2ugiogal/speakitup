<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link
	href='https://cdn.jsdelivr.net/npm/boxicons@2.0.5/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<link rel="stylesheet"
	href="http://jqueryui.com/resources/demos/style.css" />
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous" />
<!-- my css -->
<link rel="stylesheet"
	href="<spring:url value='/css/register/register.css' /> " />
<link rel="stylesheet"
	href="<spring:url value='/css/register/nav.css' /> " />
<title>註冊--要抒啦</title>


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

	<!--================ register===============  -->
	<div id="bg-color">
		<div class="container" style="padding: 108px 0px 48px 0px">
			<div class="card o-hidden border-0 shadow-lg">
				<div class="card-body p-0">
					<!-- Nested Row within Card Body -->
					<div class="row">
						<!-- 左邊照片 -->
						<div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
						<div class="col-lg-7">
							<div class="p-5">
								<div class="text-center">
									<h1 class="text-gray-900 mb-4">
										<strong>註冊你的專屬抒發空間</strong>
									</h1>
								</div>
								<!-- ======從這裡開始套 =========-->
								<form:form class="user" method='POST'
									modelAttribute="memberBean" id="registerForm"
									enctype="multipart/form-data">
									<!-- autocomplete="off"不要讓瀏覽器記住使用者輸入資料的歷史紀錄 -->
									<!-- 大頭照上傳 -->
									<div id="boxHeadPicture" class="d-flex justify-content-center">
										<img
											src="<spring:url value='/image/personPage/headPicture.jpg' />"
											width="125px" height="125px" id="headPicture"
											class="m-x-auto rounded-circle"
											style="border: 3px solid rgb(196, 190, 190);">
									</div>
									<div id="boxFileSelect"
										class="d-flex justify-content-center mt-3">
										<!-- 選擇檔案 -->
										<p class="file">
											<form:input id="fileSelect" path="memberImage" type="file" />
											<!-- 											<input name="memberMultipartFile" type="file" id="fileSelect" /> -->
											<label for="file" class="rounded" style="font-size: 18px;">上傳你的個人照片</label>
										</p>
									</div>
									<!-- 性別 -->
									<div class="d-flex justify-content-center gender mb-2">
										<input type="radio" class="magic-radio" id="male"
											name="gender" value="男" required="required" checked
											<c:if test='${mb.gender=="男"}'>checked='checked'</c:if>>
										<label for="male" class="mr-2"
											style="color: rgb(131, 121, 121)">男</label> <input
											type="radio" class="magic-radio" id="female" name="gender"
											value="女" required="required" width="16px" height="16px"
											<c:if test='${mb.gender=="女"}'> checked='checked'</c:if>>
										<label for="female" class="ml-2"
											style="color: rgb(131, 121, 121)">女</label>
									</div>


									<div class="form-group row">
										<!-- ===帳號=== -->
										<div class="col-sm-10">
											<input id="userName" name="memberId" value="${mb.memberId}"
												placeholder="輸入帳號，可用英文字母和數字" required="required" type="text"
												class="form-control form-control-user"
												onkeyup="value=value.replace(/[\W]/g,'')"
												style="font-size: 16px" />
										</div>
										<div class="col-sm-1 mb-3">
											<input type="button" id="btUserName" value="重複檢查"
												class="btn text-white check" />
										</div>
										<!--帳號 error msg -->
										<div class="errorText col-sm-10 mb-2 " id="userNameText">${errorMsg.errorId}</div>
										<!-- ===密碼=== -->
										<div class="col-sm-6 mb-3">
											<input type="password" name="password"
												class="form-control form-control-user" id="password"
												placeholder="輸入密碼8~12字元" maxlength="15" minlength="8"
												required="required" style="font-size: 16px" />
										</div>
										<!-- ===再次輸入密碼=== -->
										<div class="col-sm-6">
											<input type="password" class="form-control form-control-user"
												id="passwordCheck" name="passwordCheck"
												placeholder="請再次輸入密碼8~12字元" maxlength="15" minlength="8"
												style="font-size: 16px" />
										</div>
										<!-- 密碼error msg -->
										<div style="display: none;" id="passwordError"
											class="errorText col-sm-10 mb-2 ">密碼不相符</div>
										<!-- email -->
										<div class="col-sm-10">
											<input id="email" name="email" value="${mb.email}"
												placeholder="輸入email" required="required" type="email"
												class="form-control form-control-user"
												style="font-size: 16px" />
										</div>
										<div class="col-sm-1 mb-3">
											<input type="button" id="btEmail" value="重複檢查"
												class="btn text-white check" />
										</div>
										<!-- email err msg -->
										<div class="errorText col-sm-10 mb-2" id="emailText">${errorMsg.errorEmail}</div>

										<div class="col-sm-10 mb-3">
											<input name="phone" type="text" value="${mb.phone}"
												class="form-control form-control-user" placeholder="輸入手機號碼"
												maxlength="10" onkeyup="value=value.replace(/[^\d]/g,'')"
												style="font-size: 16px" />
										</div>

										<!-- 生日 -->
										<div class="col-sm-10 mb-3">
											<input id="datepicker" name="birthday" placeholder="選擇您的生日"
												value="${mb.birthday}" type="text" autocomplete="off"
												required="required" class="form-control form-control-user"
												style="font-size: 16px" />
										</div>

										<!-- 地址 -->
										<div role="tw-city-selector" id="address"
											class="col-sm-10 my-style-selector"></div>
										<div class="col-sm-10">
											<input name="address" value="${mb.address}" type="text"
												class="form-control form-control-user mb-3"
												placeholder="輸入地址" style="font-size: 16px" />
										</div>
									</div>
									<input class="btn btn-primary btn-user btn-block mt-2"
										id="btSubmit" type="submit" style="font-size: 16px"
										value="註冊帳號" />
								</form:form>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>


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



	<!-- 下拉式地址 -->
	<script
		src="https://cdn.jsdelivr.net/npm/tw-city-selector@2.1.0/dist/tw-city-selector.min.js"></script>

	<script>
		new TwCitySelector();
	</script>
	<!-- 下拉式地址 -->

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
	<script type="text/javascript"
		src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script type="text/javascript"
		src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	<!-- Template Main JS File -->
	<script src="<spring:url value='/js/register/register.js' /> "></script>
	<script>
		let date = new Date();
		let year = date.getFullYear();
		let month = date.getMonth() + 1;
		let day = date.getDate();
		let now = year + "-" + month + "-" + day;
		$(function() {
			$("#datepicker").datepicker({
				changeMonth : true,
				changeYear : true,
				yearRange : "-150:+0",
				maxDate : now,
				dateFormat : "yy-mm-dd"
			});
		});
	</script>
</html>