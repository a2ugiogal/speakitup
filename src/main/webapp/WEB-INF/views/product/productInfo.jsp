<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>商品細節--要抒啦</title>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
	integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>
<!-- <link rel="stylesheet" -->
<!-- 	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.css"> -->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css"> -->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"> -->
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.4.1/cerulean/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-LV/SIoc08vbV9CCeAwiz7RJZMI5YntsH8rGov0Y2nysmepqMWVvJqds6y0RaxIXT"
	crossorigin="anonymous">
<!-- icon -->
<script src="https://kit.fontawesome.com/041970ba48.js"
	crossorigin="anonymous"></script>
<!-- <script -->
<!-- 	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
<link rel="stylesheet"
	href="<spring:url value='/css/product/productInfo.css' />">

<link rel="stylesheet"
	href="<spring:url value='/css/product/nav.css' /> " />
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
				<li class="nav-item mx-2"><a class="nav-link"
					href="<spring:url value='/product/showProductInfo/1' />">商品細節</a></li>
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

	<!-- ======= main ======= -->
	<!-- 商城頁面 -->
	<div class="commodity">
		<section>
			<!-- 商品分類 -->
			<div id="procentext" class="row m-0">
				<div class="col-2 ">
					<div id="left_list"
						class="list-group sticky-element mt-3 dropdown-menuy">
						<a id="left_list_0"
							href="<spring:url value='/product/showPageProducts' />"
							class="list-group-item list-group-item-action active "
							data-toggle="list">全部商品</a> <a id="left_list_a" href="#pane-2"
							class="list-group-item list-group-item-action" data-toggle="list">天使</a>
						<ul id="list_a">
							<c:forEach var="angelCategory" items="${angelCategoryList}">
								<li><a
									href="<spring:url value='/product/showPageProducts?categoryTitle="天使"&categoryName=${angelCategory}' />">${angelCategory}</a></li>
							</c:forEach>
						</ul>
						<a id="left_list_b" href="#pane-3"
							class="list-group-item list-group-item-action" data-toggle="list">惡魔</a>
						<ul id="list_b">
							<c:forEach var="evilCategory" items="${evilCategoryList}">
								<li><a
									href="<spring:url value='/product/showPageProducts?categoryTitle="惡魔"&categoryName=${evilCategory}' />">${evilCategory}</a></li>
							</c:forEach>
						</ul>
					</div>
					<!-- 控制商品分類，點擊其中一個展開時，其它關閉 -->
					<script>
						$('#left_list_0').click(function() {
							$('#list_a').hide();
							$('#list_b').hide();
							$('#list_c').hide();
							$('#list_d').hide();
						});
						$('#left_list_a').click(function() {
							$('#list_a').toggle();
							$('#list_b').hide();
							$('#list_c').hide();
							$('#list_d').hide();
						});
						$('#left_list_b').click(function() {
							$('#list_a').hide();
							$('#list_b').toggle();
							$('#list_c').hide();
							$('#list_d').hide();
						});
					</script>
				</div>
				<!-- 商品 -->
				<div class="col-8 Product_content">
					<div class="row">
						<!-- 麵包屑設定 -->
						<div id="nav_info">
							<ul style="padding-left: 10px !important;">
								<li><a href="#">首頁</a></li>
								<li>/<a
									href="<spring:url value='/product/showPageProducts?categoryTitle=${product.category.categoryTitle}' />">
										${product.category.categoryTitle}</a></li>
								<li>/ ${product.productName}</li>
							</ul>
						</div>
					</div>
					<div class="row p-5"
						style="background-color: rgba(248, 248, 248, 0.336)">
						<div style="width: 35%;">
							<img
								src="<spring:url value='/product/getProductImage/${product.productId}' />"
								style="width: 100%;">
						</div>
						<div class="Commodity_control" style="margin: 0px; width: 65%;">
							<div class="pl-4">
								<div class="Product_title">
									<span>
										<h3 class="text-dark">${product.productName}</h3>
									</span>
								</div>
								<span>&nbsp</span>
								<div>
									<span class="price">
										<h2 class="text-danger">$ ${product.price}</h2>
									</span>
								</div>
								<!-- 規格 -->
								<div class="specification row pb-2">
									<div class="col-12">
										<c:if test="${title1!=''}">
											<span style='display: inline-block; padding-top: 8px;'>
												<h5 class="text-dark">${title1}：</h5>
											</span>
											<ul
												style="padding-left: 0px !important; display: inline-block;">
												<c:forEach var="entry" items="${content1}">
													<li><input id="${entry}" type="radio" name="content1"
														value="${entry}" required="required"><label
														for="${entry}">${entry}</label></li>
												</c:forEach>
											</ul>
										</c:if>
									</div>

									<div class="col-12">
										<c:if test="${title2!=''}">
											<span style='display: inline-block; padding-top: 8px;'>
												<h5 class="text-dark">${title2}：</h5>
											</span>
											<ul
												style="padding-left: 0px !important; display: inline-block;">
												<c:forEach var="entry2" items="${content2}">
													<li><input id="${entry2}" type="radio" name="content2"
														required="required" value="${entry2}"><label
														for="${entry2}">${entry2}</label></li>
												</c:forEach>
											</ul>
										</c:if>
									</div>


									<div class="col-12 Quantity pb-4">
										<span style='display: inline-block;'>
											<h5 class="text-dark">數量 ：</h5>
										</span> <input style="display: inline; background-color: white;"
											class="Enter_the_quantity"
											onkeyup="value=value.replace(/[^\d]/g,'') "
											onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"
											id="Text2" name="qty" value="1" type="number" min="1">
									</div>
								</div>
								<div>
									<button type="button" class="btn btn-outline-danger">
										加入購物車<i class="fas fa-shopping-cart"></i>
									</button>
									<button type="button" class="btn btn-outline-danger buy">
										<a>直接購買</a>
									</button>
								</div>
							</div>
						</div>
					</div>
					<div class="row"
						style="background-color: rgba(248, 248, 248, 0.336);">
						<div class="m-5 p-5"
							style="background-color: rgba(255, 255, 255, 0.2); width: 100%;">
							<h1 style="color: rgba(0, 0, 0, 0.726); margin-bottom: 50px;">商品詳情</h1>
							${detail}
						</div>
					</div>
				</div>
			</div>
		</section>
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
</body>
</html>