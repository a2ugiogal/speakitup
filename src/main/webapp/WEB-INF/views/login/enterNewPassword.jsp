 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href='https://cdn.jsdelivr.net/npm/boxicons@2.0.5/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>
<!-- my css -->
<link rel="stylesheet"
	href="<spring:url value='/css/style.css' /> " />
<script src="<spring:url value='/js/login/enterNewPswd.js' /> "></script>
<title>Reset Password</title>
</head>
<body>
	<!-- ==============Header =================-->
	<div id="header">
		<nav class="navbar navbar-expand-lg navbar-light bg-danger fixed-top">
			<!-- logo和標題 -->
			<nav class="navbar navbar-light bg-danger">
				<a class="navbar-brand text-white" href="#">
<!-- 				 <img -->
<!-- 					src="https://github.com/sun0722a/yaoshula/blob/master/src/logo/logo_trans_250px.png?raw=true" -->
<!-- 					width="50" height="50" class="d-inline-block align-top" alt=""> -->
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

	<!-- ===main=== -->
	<div class="container">

		<!-- Outer Row -->
		<div class="row justify-content-center mt-5">

			<div class="col-xl-10 col-lg-12 col-md-9 mt-5">

				<div class="card o-hidden border-0 shadow-lg my-5 ">
					<div class="card-body p-0">
						<!-- Nested Row within Card Body -->
						<div class="row">
							<div class="col-lg-6 d-none d-lg-block bg-password-image"></div>
							<div class="col-lg-6">
								<div class="p-5">
									<div class="text-center">
										<h1 class="h4 text-gray-900 mb-2">歡迎回來！要抒啦！</h1>
										<p class="mb-4">請重新設定您的密碼</p>
									</div>
									<form class="user" action="<spring:url value='/member/changepswd'  />"
										method="POST">
										<div class="form-group">
											<input type="password" name="password"
												class="form-control form-control-user" id="enterPassword"
												placeholder="輸入新密碼(8~15字元)" maxlength="15" minlength="8">
										</div>
									
											<div class="checkPswd input-group mb-3">
												<input type="password" name="checkPassword"
													class="form-control form-control-user checked"
													id="checkPassword" placeholder="再輸入一次">
												<div class="input-group-append">
													
													<button class="btn btn-outline-primary" type="button"
														id="button-addon">
														<i class='bx bxs-lock-open'></i>
													</button>
												</div>
												
											</div>
											<div  id="passwordError" style="display: none;"
														class="errorText">密碼不相符</div>
											<button type="submit" id="checkbtn"
												class="btn btn-primary btn-user btn-block" disabled>確認</button>
									</form>
									<hr>

								</div>
							</div>
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
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.compatibility.min.js"></script>

	<script>
		$(document).ready(function() {
			
			
			
			$('#button-addon').mousedown(function() {
				let changeType = $('.checked').attr('type')
				
					$('.checked').attr('type', 'text')
				
			})
			
			$('body').mouseup(function() {
				let changeType = $('.checked').attr('type')

					$('.checked').attr('type', 'password')

			})
		});
	</script>
</html>