<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商城首頁--要抒啦</title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@100;400&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous" />
<script src="https://kit.fontawesome.com/041970ba48.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="<spring:url value='/css/product/nav.css' /> ">
<link rel="stylesheet"
	href="<spring:url value='/css/product/productHome.css' />" />
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
			<form class="form-inline mr-5"
				action="<spring:url value='/product/showPageProducts' /> ">
				<input class="form-control mr-sm-2" type="search" id="search"
					placeholder="搜尋: 商品名稱" aria-label="Search" name="search"
					style="width: 70% !important;" />
				<button class="btn" type="submit" id="search-btn">搜尋</button>
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
	<!-- 置頂按鈕 設定 -->
	<a href="#top"><img id="myBtn"
		src="https://png.pngtree.com/png-clipart/20190705/original/pngtree-vector-up-arrow-icon-png-image_4272127.jpg"></a>

	<div style="height: 100vh;">
		<div
			style="position: relative; height: 100vh; z-index: -1; top: 60px;">
						<img src="<spring:url value='/image/product/productInfo.jpg'/> "
							style="height: 100%; width: 100%;">
						<div id="text3d" data-text="商城">商城</div>
		</div>
	</div>


	<!-- 天使熱門商品  輪播-->
	<div id="hot-sales" class="pb-5 pt-4 ">
		<div class="two_title my-5 text-center fluid">
			<h1 style="color: #495057;" class="mb-4">天使熱銷商品</h1>
			<div id="carousel-card1" class="carousel slide" data-interval="5000">
				<div class="carousel-inner">
					<div class="carousel-item px-10 active">
						<div class="row m-0">
							<c:forEach var="entry" items="${angel_products_map}"
								varStatus="number">
								<c:if test="${number.count % 2 == 1}">
									<a
										href="<spring:url value='/product/showProductInfo/${entry.value.productId}'/>"
										class="col-12 col-sm-6 col-lg-4 mt-4">
										<div class="card border-dark">
											<img
												src="<spring:url value='/product/getProductImage/${entry.value.productId}' />"
												class="card-img-top productImg" />
											<div class="card-body">
												<h5 class="card-title"
													style="text-align: center; font-size: 30px;">${entry.value.productName}</h5>
												<div class="card-text mt-2"
													style="text-align: center; font-size: 20px;">$
													${entry.value.price}</div>
											</div>
										</div>
									</a>
								</c:if>
							</c:forEach>
						</div>
					</div>
					<div class="carousel-item px-10">
						<div class="row m-0">
							<c:forEach var="entry" items="${angel_products_map}"
								varStatus="number">
								<c:if test="${number.count % 2 == 0}">
									<a
										href="<spring:url value='/product/showProductInfo/${entry.value.productId}'/>"
										class="col-12 col-sm-6 col-lg-4 mt-4">
										<div class="card border-dark">
											<img
												src="<spring:url value='/product/getProductImage/${entry.value.productId}' />"
												class="card-img-top productImg" />
											<div class="card-body">
												<h5 class="card-title"
													style="text-align: center; font-size: 30px;">${entry.value.productName}</h5>
												<div class="card-text mt-2"
													style="text-align: center; font-size: 20px;">$
													${entry.value.price}</div>
											</div>
										</div>
									</a>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
				<a class="carousel-control-prev" href="#carousel-card1"
					role="button" data-slide="prev"> <span
					class="carousel-control-prev-icon" aria-hidden="true"></span> <span
					class="sr-only">Previous</span>
				</a> <a class="carousel-control-next" href="#carousel-card1"
					role="button" data-slide="next"> <span
					class="carousel-control-next-icon" aria-hidden="true"></span> <span
					class="sr-only">Next</span>
				</a>
			</div>
		</div>
		<!-- 惡魔熱門商品  輪播-->
		<div class="two_title my-5 text-center fluid">
			<h1 style="color: #495057;" class="mb-4">惡魔熱銷商品</h1>
			<div id="carousel-card2" class="carousel slide" data-interval="5000">
				<div class="carousel-inner">
					<div class="carousel-item px-10 active">
						<div class="row m-0">
							<c:forEach var="entry" items="${evil_products_map}"
								varStatus="number">
								<c:if test="${number.count % 2 == 1}">
									<a
										href="<spring:url value='/product/showProductInfo/${entry.value.productId}'/>"
										class="col-12 col-sm-6 col-lg-4 mt-4">
										<div class="card border-dark">
											<img
												src="<spring:url value='/product/getProductImage/${entry.value.productId}' />"
												class="card-img-top productImg" />
											<div class="card-body">
												<h5 class="card-title"
													style="text-align: center; font-size: 30px;">${entry.value.productName}</h5>
												<div class="card-text mt-2"
													style="text-align: center; font-size: 20px;">$
													${entry.value.price}</div>
											</div>
										</div>
									</a>
								</c:if>
							</c:forEach>
						</div>
					</div>
					<div class="carousel-item px-10">
						<div class="row m-0">
							<c:forEach var="entry" items="${evil_products_map}"
								varStatus="number">
								<c:if test="${number.count % 2 == 0}">
									<a
										href="<spring:url value='/product/showProductInfo/${entry.value.productId}'/>"
										class="col-12 col-sm-6 col-lg-4 mt-4">
										<div class="card border-dark">
											<img
												src="<spring:url value='/product/getProductImage/${entry.value.productId}' />"
												class="card-img-top productImg" />
											<div class="card-body">
												<h5 class="card-title"
													style="text-align: center; font-size: 30px;">${entry.value.productName}</h5>
												<div class="card-text mt-2"
													style="text-align: center; font-size: 20px;">$
													${entry.value.price}</div>
											</div>
										</div>
									</a>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
				<a class="carousel-control-prev" href="#carousel-card2"
					role="button" data-slide="prev"> <span
					class="carousel-control-prev-icon" aria-hidden="true"></span> <span
					class="sr-only">Previous</span>
				</a> <a class="carousel-control-next" href="#carousel-card2"
					role="button" data-slide="next"> <span
					class="carousel-control-next-icon" aria-hidden="true"></span> <span
					class="sr-only">Next</span>
				</a>
			</div>
		</div>
	</div>
	<!-- 第三區塊  文字區塊-->
	<div class="three_title mt-5 pt-5">
		<div class="black">
			<div class="yallow">
				<span>現今人們在繁忙焦慮的生活中，又迫切需要感到放鬆的時刻。療癒風潮的崛起，為生活忙碌的人們解決了這個問題，療癒系列產品的出現，帶給大眾另類的喘息機會。</span>
				<span><a
					href="<spring:url value='/product/showPageProducts?categoryTitle=天使' /> "
					class="">來天使區找找吧</a></span>
			</div>
		</div>
		<div class="pink">
			<div class="white">
				<span>想跟家人、朋友、同學開點小小的玩笑嗎?你所想的到的惡搞小物都在這裡。 </span> <span><a
					href="<spring:url value='/product/showPageProducts?categoryTitle=惡魔' /> "
					id="goToDevilA">來惡魔區看看吧</a></span>
			</div>
		</div>
	</div>
	<!-- 第三區塊下的文字  -->
	<div class="therr_bottom text-info">#搞怪#療育#都在這裡</div>
	<!-- 第四區塊  推薦商品-->
	<div id="recommend-product" class="mt-5 pt-5 pb-3">
		<div class="four_title">
			<div class="recommend text-white">推薦商品</div>
			<div class="four_top">
				<c:forEach var="entry" items="${top_product_list}">
					<div>
						<a href="<spring:url value='/product/showProductInfo/${entry}'/>">
							<img
							src="<spring:url value='/product/getProductImage/${entry}' />"
							class="four_img">
						</a>
					</div>
				</c:forEach>
			</div>
			<div class="four_under">
				<c:forEach var="entry" items="${bot_product_list}">
					<div>
						<a href="<spring:url value='/product/showProductInfo/${entry}'/>">
							<img
							src="<spring:url value='/product/getProductImage/${entry}' />"
							class="four_img">
						</a>
					</div>
				</c:forEach>
			</div>
			<div style="width: 100%; text-align: center;">
				<span class="four_bottom"> <a
					href="<spring:url value='/product/showPageProducts'/> ">More</a>
				</span>
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
	<script type="text/javascript">
		var text = document.getElementById('text3d')
		var shadow = '';
		for (var i = 0; i < 30; i++) {
			shadow += (shadow ? ',' : '') + -i * 1 + 'px ' + i * 1
					+ 'px 0 #d9d9d9';
		}
		text.style.textShadow = shadow;
	</script>









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