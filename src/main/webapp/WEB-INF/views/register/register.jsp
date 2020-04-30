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

<!-- my css -->
<link rel="stylesheet"
	href="<spring:url value='/css/register/register.css' /> " />
<title>Register</title>


</head>

<body>
	<!-- ==============Header =================-->
	<div id="header">
		<nav class="navbar navbar-expand-lg navbar-light bg-danger">
			<!-- logo和標題 -->
			<nav class="navbar navbar-light bg-danger">
				<a class="navbar-brand text-white" href='<spring:url value="/" />'>
					<!-- <img src="https://github.com/sun0722a/yaoshula/blob/master/src/logo/logo_trans_250px.png?raw=true" width="50" height="50" class="d-inline-block align-top" alt=""> -->
					要抒啦！
				</a>
			</nav>
			<!-- 收縮成漢堡 -->
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<!-- ============left menu=================== -->
				<ul class="navbar-nav mr-auto">
					<!-- 下拉一 -->
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle text-white" href="#"
						id="navbarDropdown" role="button" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> 論壇 </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="#">天使版</a> <a
								class="dropdown-item" href="#">惡魔版</a></li>
					<!-- 下拉二 -->
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle text-white" href="#"
						id="navbarDropdown" role="button" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> 商城 </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="#">商城首頁</a> <a
								class="dropdown-item" href="#">我的購物車</a> <a
								class="dropdown-item" href="#">歷史訂單</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle text-white" href="#"
						id="navbarDropdown" role="button" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> 關於 </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="#">創站理念</a> <a
								class="dropdown-item" href="#">團隊介紹</a> <a class="dropdown-item"
								href="#">聯絡我們</a></li>
				</ul>

				<!-- ============right menu=================== -->
				<ul class="navbar-nav ml-auto ">
					<li class="nav-item"><a class="nav-link text-white" href="#">會員登入</a>
					</li>
				</ul>
			</div>
		</nav>
	</div>

	<!--================ register===============  -->
	<div class="container">

		<div class="card o-hidden border-0 shadow-lg my-5">
			<div class="card-body p-0">
				<!-- Nested Row within Card Body -->
				<div class="row">
					<!-- 左邊照片 -->
					<div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
					<div class="col-lg-7">
						<div class="p-5">
							<div class="text-center">
								<h4 class="text-gray-900 mb-4">註冊你的專屬抒發空間</h4>
							</div>
							<!-- ======從這裡開始套 =========-->
							<form:form class="user" method='POST' modelAttribute="memberBean"
								id="registerForm" enctype="multipart/form-data">
								<!-- autocomplete="off"不要讓瀏覽器記住使用者輸入資料的歷史紀錄 -->
								<!-- 大頭照上傳 -->
								<div id="boxHeadPicture" class="d-flex justify-content-center">
									<img
										src="<spring:url value='/image/personPage/headPicture.jpg' />"
										id="headPicture" class="rounded-circle">
								</div>
								<div id="boxFileSelect" class="d-flex justify-content-center">
									<!-- 選擇檔案 -->
									<form:input id="fileSelect" path="memberImage" type="file" />
									<!-- 									<input name="memberMultipartFile" type="file" id="fileSelect"> -->
								</div>


								<!-- 性別 -->
								<div class="d-flex justify-content-center">
									<%-- 									<form:radiobuttons path="gender" required="required" --%>
									<%-- 										items='${genderMap}' /> --%>
									<input type="radio" name="gender" value="男" required="required"
										<c:if test='${mb.gender=="男"}'>checked='checked'</c:if>>男
									<input type="radio" name="gender" value="女" required="required"
										<c:if test='${mb.gender=="女"}'> checked='checked'</c:if>>女
								</div>


								<div class="form-group row">
									<!-- ===帳號=== -->
									<div class="col-sm-10 mb-3">
										<form:input path="memberId" id="userName"
											placeholder="輸入帳號，可用英文字母和數字" required="required" type="text"
											class="form-control form-control-user"
											onkeyup="value=value.replace(/[\W]/g,'')" />
									</div>
									<div class="col-sm-1 mb-3">
										<input type="button" id="btUserName" value="重複檢查"
											class="btn btn-secondary">
									</div>
									<!--帳號 error msg -->
									<div class="errorText" id="userNameText">
										<form:errors path="memberId" cssClass="errorText" />${errorMsg.errorId}</div>
									<!-- ===密碼=== -->
									<div class="col-sm-6 mb-3">
										<form:input type="password" path="password"
											class="form-control form-control-user" id="password"
											placeholder="輸入密碼8~12字元" maxlength="15" minlength="8"
											required="required" />
									</div>
									<!-- ===再次輸入密碼=== -->
									<div class="col-sm-6">
										<input type="password" class="form-control form-control-user"
											id="passwordCheck" placeholder="請再次輸入密碼8~12字元" maxlength="15"
											minlength="8">
									</div>
									<!-- 密碼error msg -->
									<div style="display: none;" id="passwordError"
										class="errorText">密碼不相符</div>
									<!-- email -->
									<div class="col-sm-10 mb-3">
										<form:input id="email" path="email" placeholder="輸入email"
											required="required" type="email"
											class="form-control form-control-user" />
									</div>
									<div class="col-sm-1 mb-3">
										<input type="button" id="btEmail" value="重複檢查"
											class="btn btn-secondary" />
									</div>
									<!-- email err msg -->
									<div class="errorText" id="emailText">
										<form:errors path="email" cssClass="errorText" />${errorMsg.errorEmail}</div>

									<div class="col-sm-10 mb-3">
										<form:input path="phone" type="text"
											class="form-control form-control-user" placeholder="輸入手機號碼"
											maxlength="10" onkeyup="value=value.replace(/[^\d]/g,'')" />
									</div>

									<!-- 生日 -->
									<div class="col-sm-10 mb-3">
										<form:input id="datepicker" path="birthday"
											placeholder="選擇您的生日" type="text" autocomplete="off"
											required="required" class="form-control form-control-user" />
									</div>

									<!-- 地址 -->
									<div role="tw-city-selector" id="address"></div>
									<div class="col-sm-10">
										<form:input path="address" type="text"
											class="form-control form-control-user mb-3"
											placeholder="輸入地址" />
									</div>
								</div>
								<input class="btn btn-primary btn-user btn-block mt-3"
									id="btSubmit" type="submit" value="註冊帳號">
								<!-- a標籤寫的submit btn -->
								<!-- <a href=".." class="btn btn-primary btn-user btn-block" id="btSubmit" type="submit">
                    註冊帳號
                  </a> -->
								<!-- 暫時先不用的第三方登入 -->
								<!-- <hr>
                  <a href=".." class="btn btn-google btn-user btn-block">
                    用Google帳號登入
                  </a>
                  <a href=".." class="btn btn-facebook btn-user btn-block">
                    用Facebook帳號登入
                  </a> -->
							</form:form>
							<hr>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>

	<!--========= footer================= -->
	<!-- Footer -->
	<footer class="page-footer font-small stylish-color-dark pt-5">

		<!-- Footer Links -->
		<div class="container text-center text-md-left">

			<!-- Grid row -->
			<div class="row">

				<!-- Grid column -->
				<div class="col-md-4 mx-auto">

					<!-- Content -->
					<h5 class="font-weight-bold text-uppercase mt-3 mb-4">要抒啦！
						論壇&商城</h5>
					<p>是個能夠預期回應溫度的論壇空間。無論感情、生活、工作、時事都可以聊，還附設購物商城「要買啦！💸」，各種新奇有趣的商品都在這裡。</p>

				</div>
				<!-- Grid column -->

				<hr class="clearfix w-100 d-md-none">

				<!-- Grid column -->
				<div class="col-md-2 mx-auto">

					<!-- Links -->
					<h5 class="font-weight-bold text-uppercase mt-3 mb-4">論壇</h5>

					<ul class="list-unstyled">
						<li><a href="#!">天使版</a></li>
						<li><a href="#!">惡魔版</a></li>

					</ul>

				</div>
				<!-- Grid column -->

				<hr class="clearfix w-100 d-md-none">

				<!-- Grid column -->
				<div class="col-md-2 mx-auto">

					<!-- Links -->
					<h5 class="font-weight-bold text-uppercase mt-3 mb-4">商城</h5>

					<ul class="list-unstyled">
						<li><a href="#!">商城首頁</a></li>
						<li><a href="#!">我的購物車</a></li>
						<li><a href="#!">歷史訂單</a></li>
					</ul>

				</div>
				<!-- Grid column -->

				<hr class="clearfix w-100 d-md-none">

				<!-- Grid column -->
				<div class="col-md-2 mx-auto">

					<!-- Links -->
					<h5 class="font-weight-bold text-uppercase mt-3 mb-4">關於我們</h5>

					<ul class="list-unstyled">
						<li><a href="#!">創站理念</a></li>
						<li><a href="#!">團隊介紹</a></li>
						<li><a href="#!">聯絡我們</a></li>
					</ul>

				</div>
				<!-- Grid column -->

			</div>
			<!-- Grid row -->

		</div>

		<!-- Copyright -->
		<div class="footer-copyright text-center pb-4">© 2020 Copyright
			© 2020 Speak It Up. All rights reserved</div>
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