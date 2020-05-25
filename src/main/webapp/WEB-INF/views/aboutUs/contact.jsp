<!DOCTYPE html>
<html lang="en">
<head>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8" />
<!-- Vendor CSS Files -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous" />
<link
	href='https://cdn.jsdelivr.net/npm/boxicons@2.0.5/css/boxicons.min.css'
	rel='stylesheet'>
	<link rel="shortcut icon" href="<spring:url value='/image/logo/logo_trans_92px.png' /> ">
<!-- aos是別人寫好的動畫效果，載入時會浮上來的感覺，不要可拿掉 -->
<link rel="stylesheet"
	href="<spring:url value='/css/aboutUs/aos.css' />">
<!-- my css -->
<link rel="stylesheet"
	href="<spring:url value='/css/aboutUs/contact.css' /> " />

<link rel="stylesheet"
	href="<spring:url value='/css/register/nav.css' /> " />
<title>聯絡我們--要抒啦</title>

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
				height="50px" /> 要抒啦
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
					<div style="width: 170px;">
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
						<a class="dropdown-item" href="<spring:url value='/aboutUs/createIdea' />">創建理念</a> <a
							class="dropdown-item" href="<spring:url value='/aboutUs/groupInfo' />">團隊介紹</a> <a class="dropdown-item"
							href="<spring:url value='/aboutUs/contact' />">聯絡我們</a>
					</div></li>
			</ul>
		</div>
	</nav>
	<!-- 導覽列 -->

	<!-- ======= Contact Section ======= -->
	<div style="background-color: rgb(219, 219, 219)">
		<section id="contact" class="contact section-bg mt-5">
			<div class="container">

				<div class="section-title">
					<h2 data-aos="fade-in" class="pb-4">
						<strong>CONTACT US </strong>
					</h2>
					<p data-aos="fade-in">若您有任何問題，歡迎於週一至週五上午10點至下午6點來電洽詢。也歡迎您留下訊息，我們將盡快與您聯繫。</p>
				</div>

				<div class="row">

					<div class="col-lg-6">

						<div class="row">
							<div class="col-md-12">
								<div class="info-box" data-aos="fade-up">
									<i class="bx bx-map"></i>
									<h3>Our Address</h3>
									<p>10608 台北市大安區新生南路一段1號 光華館 2樓 210室</p>
								</div>
							</div>
							<div class="col-md-6">
								<div class="info-box mt-4" data-aos="fade-up"
									data-aos-delay="100">
									<i class="bx bx-envelope"></i>
									<h3>Email Us</h3>
									<p>speak_it_up@ntnu.com</p>
								</div>
							</div>
							<div class="col-md-6">
								<div class="info-box mt-4" data-aos="fade-up"
									data-aos-delay="100">
									<i class="bx bx-phone-call"></i>
									<h3>Call Us</h3>
									<p>+886-2-2835-3415</p>
								</div>
							</div>
						</div>

					</div>

					<div class="col-lg-6">
						<form action="<spring:url value='/member/contactUs' /> " method="POST" role="form" class="php-email-form"
							data-aos="fade-up">
							<div class="form-row">
								<div class="col-md-6 form-group">
									<input type="text" name="name" class="form-control" id="name"
										placeholder="您的大名" required  autocomplete="off"/>
									<div class="validate"></div>
								</div>
								<div class="col-md-6 form-group">
									<input type="email" class="form-control" name="email"
										id="email" placeholder="聯絡信箱" required/>
									<div class="validate"></div>
								</div>
							</div>
							<div class="form-group">
								<input type="text" class="form-control" name="guestSubject"
									id="subject" placeholder="主旨" required/>
								<div class="validate"></div>
							</div>
							<div class="form-group">
								<textarea class="form-control" name="message" rows="5" maxlength="250"
									data-rule="required" placeholder="想說的話..." required></textarea>
								<div class="validate"></div>
							</div>
							<div class="mb-3">
								<div class="loading">Loading</div>
								<div class="error-message"></div>
								<div class="sent-message">Your message has been sent.
									Thank you!</div>
							</div>
							<div class="text-center">
								<button type="submit">Send Message</button>
							</div>
						</form>
					</div>

				</div>
		</section>
		<!-- End Contact Section -->
		<div id="googlemap" class="d-flex justify-content-center pb-5">
			<iframe
				src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3614.7595495555097!2d121.53330871501322!3d25.042232883968556!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3442a97d255598df%3A0x47ea748e8f3f53aa!2z5ZyL56uL6Ie65YyX56eR5oqA5aSn5a24!5e0!3m2!1szh-TW!2stw!4v1586255037278!5m2!1szh-TW!2stw"
				width="1100" height="350" frameborder="0" style="border: 0;"
				allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
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

	<!-- ========================modal============================ -->
	<!-- Modal for subscribe-->
	<div class="modal fade" id="my-modal-subscribe" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel_sub"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel_sub">Modal title</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">...</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
<c:if test="${not empty sendSuccess}">
	<script>
		alert("寄信成功，感謝你的來信")
	</script>
	<%
		session.removeAttribute("sendSuccess");
	%>
</c:if>
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
	<!-- Template Main JS File -->
	<script src="<spring:url value='/js/aboutUs/aos.js' />"></script>
	<script src="<spring:url value='/js/aboutUs/contact.js' />"></script>
</body>
</html>
