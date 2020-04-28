<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<link
	href='https://cdn.jsdelivr.net/npm/boxicons@2.0.5/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet"
	href="<spring:url value='/css/login/template_style.css' /> ">
<!-- my css -->
<link rel="stylesheet"
	href="<spring:url value='/css/login/style.css' /> " />
	
	<script src="<spring:url value='/js/login/login.js' /> " /></script>
<title>Login</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
</head>
<body>
	<c:set var="funcName" value="LOG" scope="session" />
	<c:if test="${ ! empty sessionScope.timeOut }">
		<!-- 表示使用逾時，重新登入 -->
		<c:set var="msg"
			value="<font color='red'>${sessionScope.timeOut}</font>" /> 
	</c:if>

	<!-- ==============Header ================= -->
	<div id="header">
		<nav class="navbar navbar-expand-lg navbar-light bg-danger">
			<!-- logo和標題 -->
			<nav class="navbar navbar-light bg-danger">
				<a class="navbar-brand text-white" href="#"> <img src="https://github.com/sun0722a/yaoshula/blob/master/src/logo/logo_trans_250px.png?raw=true" width="50" height="50" class="d-inline-block align-top" alt="">
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
<!-- 				============left menu=================== -->
				<ul class="navbar-nav mr-auto">
<!-- 					下拉一 -->
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle text-white" href="#"
						id="navbarDropdown" role="button" data-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false"> 論壇 </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item" href="#">天使版</a> <a
								class="dropdown-item" href="#">惡魔版</a></li>
<!-- 					下拉二 -->
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

<!-- 				============right menu=================== -->
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
		<div class="row justify-content-center">

			<div class="col-xl-10 col-lg-12 col-md-9">

				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
<!-- 						Nested Row within Card Body -->
						<div class="row">
							<div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
							<div class="col-lg-6">
								<div class="p-5">
									<div class="text-center">
										<h1 class="h4 text-gray-900 mb-4">歡迎回來，要抒啦！</h1>
									</div>
									<form class="box" action="" method="post" name="LoginForm">
										<c:if test="${! empty ErrorMsgKey.memberNotAuthError}">
											<div aria-live="polite" aria-atomic="true"
												class="d-flex justify-content-center align-items-center w-5"
												style="min-height: 200px;">

<!-- 												Then put toasts within -->
												<div class="toast w-75" role="alert" aria-live="assertive"
													aria-atomic="true" data-autohide="false">
													<div class="toast-header">
														<i class="fas fa-exclamation-triangle"></i> <strong
															class="mr-auto">Warning</strong>
														<button type="button" class="ml-2 mb-1 close"
															data-dismiss="toast" aria-label="Close">
															<span aria-hidden="true">&times;</span>
														</button>
													</div>
													<div class="toast-body" style="font-size: large;">
														請先完成Email認證 <a
															href="<c:url value='/_02_login/enterEmail.jsp' />">點此進入</a>
													</div>
												</div>
											</div>

										</c:if>

										<div class="form-group">
											<input type="text" class="form-control form-control-user mr-0"
												name="memberId" placeholder="輸入您的帳號" id="inputmemberId" required
												value="${requestScope.memberId}${param.memberId}">
<!-- 											<div class="idEmptyError">帳號欄必須輸入</div> -->
										</div>
										<div class="form-group">
											<input type="password" class="form-control form-control-user"
												name="password" id="inputPassword" required
												placeholder="輸入您的密碼"
												value="${requestScope.password}${param.password}">
<!-- 											<div class="passwordEmptyError">密碼欄必須輸入</div> -->
										</div>
										<div class="form-group">
											<div class="custom-control custom-checkbox small">
												<input type="checkbox" class="custom-control-input"
													id="customCheck" name="rememberMe"
													<c:if test='${requestScope.rememberMe==true}'>      
										                 checked='checked'   
										              </c:if>
													value="true"> <label class="custom-control-label"
													for="customCheck">記住我</label>
											</div>
										</div>
										<c:if test="${not empty loginError}" >
										<div class="loginError">帳號或密碼錯誤</div>
										</c:if>
										<input type="submit" id="loginBtn"
											class="btn btn-primary btn-user btn-block" value="立即登入"
											onclick="LoginForm.action='<spring:url value="/login/checkLogin"  />'; ">

										                    
										<hr>
										<a href=".." class="btn btn-google btn-user btn-block">
											用Google帳號登入 </a> <a href=".."
											class="btn btn-facebook btn-user btn-block">
											用Facebook帳號登入 </a>

										<hr>
										<div class="text-center">
											<a class="small"
												href='<c:url value="/_02_login/enterEmail.jsp"  />'>忘記密碼了？幫你找找</a>
										</div>
										<div class="text-center">
											<a class="small"
												href='<c:url value="/_01_register/register.jsp"  />'>還沒有帳號？前往註冊</a>
										</div>
									</form>
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

<!-- 				Grid column -->
				<div class="col-md-4 mx-auto">

<!-- 					Content -->
					<h5 class="font-weight-bold text-uppercase mt-3 mb-4">要抒啦！
						論壇&商城</h5>
					<p>是個能夠預期回應溫度的論壇空間。無論感情、生活、工作、時事都可以聊，還附設購物商城「要買啦！💸」，各種新奇有趣的商品都在這裡。</p>

				</div>
<!-- 				Grid column -->

				<hr class="clearfix w-100 d-md-none">

<!-- 				Grid column -->
				<div class="col-md-2 mx-auto">

<!-- 					Links -->
					<h5 class="font-weight-bold text-uppercase mt-3 mb-4">論壇</h5>

					<ul class="list-unstyled">
						<li><a href="#!">天使版</a></li>
						<li><a href="#!">惡魔版</a></li>

					</ul>

				</div>
<!-- 				Grid column -->

				<hr class="clearfix w-100 d-md-none">

<!-- 				Grid column -->
				<div class="col-md-2 mx-auto">

<!-- 					Links -->
					<h5 class="font-weight-bold text-uppercase mt-3 mb-4">商城</h5>

					<ul class="list-unstyled">
						<li><a href="#!">商城首頁</a></li>
						<li><a href="#!">我的購物車</a></li>
						<li><a href="#!">歷史訂單</a></li>
					</ul>

				</div>
<!-- 				Grid column -->

				<hr class="clearfix w-100 d-md-none">

<!-- 				Grid column -->
				<div class="col-md-2 mx-auto">

<!-- 					Links -->
					<h5 class="font-weight-bold text-uppercase mt-3 mb-4">關於我們</h5>

					<ul class="list-unstyled">
						<li><a href="#!">創站理念</a></li>
						<li><a href="#!">團隊介紹</a></li>
						<li><a href="#!">聯絡我們</a></li>
					</ul>

				</div>
<!-- 				Grid column -->

			</div>
			<!-- Grid row -->

		</div>

		<!-- Copyright -->
		<div class="footer-copyright text-center pb-4">© 2020 Copyright
			© 2020 Speak It Up. All rights reserved</div>
		<!-- Copyright -->

	</footer>
	<!-- Footer -->

	<!-- </div> -->
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
	<script src="main.js"></script>
</body>
</html>