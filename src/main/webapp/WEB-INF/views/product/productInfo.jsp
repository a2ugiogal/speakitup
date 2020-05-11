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


<!-- icon -->
<script src="https://kit.fontawesome.com/041970ba48.js"
	crossorigin="anonymous"></script>
	<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous" />
<%-- <script src="<spring:url value='/js/product/productInfo.js' /> "></script> --%>
<link rel="stylesheet"
	href="<spring:url value='/css/product/productInfo.css' />">
<link rel="stylesheet"
	href="<spring:url value='/css/product/nav.css' /> " />
<link rel="stylesheet"
	href="<spring:url value='/css/loginModel.css' /> " />
<script type="text/javascript">
	function addShoppinCart() {
		buyForm = document.getElementById("buyForm");
		buyForm.action = "<spring:url value='/order/shoppingCart' />";
		buyForm.method = "GET";
		buyForm.submit();

	}

	function buyNow() {
		buyForm = document.getElementById("buyForm");
		buyForm.action = "<spring:url value='/order/checkOrder' />";
		buyForm.method = "GET";
		buyForm.submit();
	}
</script>
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
				<input type="hidden" value="-1" name="pageNo">
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

	<!-- ======= main ======= -->
	<!-- 商城頁面 -->
	<div class="commodity">
		<section>
			<!-- 商品分類 -->
			<div id="procentext" class="row m-0">
				<div class="col-2 ">
					<div id="left_list"
						class="list-group sticky-element mt-3 dropdown-menuy">
						<a id="left_list_0" style="font-size: 20px;"
							href="<spring:url value='/product/showPageProducts' />"
							<c:choose>
								<c:when test="${categoryTitle==''}">
									class="list-group-item list-group-item-action active"
								</c:when>
								<c:otherwise>
									class="list-group-item list-group-item-action"
								</c:otherwise>
							</c:choose>>全部商品</a>
						<a id="left_list_a" href="#pane-2" data-toggle="list"
							style="font-size: 20px;"
							<c:choose>
								<c:when test="${categoryTitle=='天使'}">
									class="list-group-item list-group-item-action active"
								</c:when>
								<c:otherwise>
									class="list-group-item list-group-item-action"
								</c:otherwise>
							</c:choose>>天使</a>

						<ul id="list_a"
							<c:if test="${categoryTitle=='天使'}">style="display: block"</c:if>>
							<li><a
								href="<spring:url value='/product/showPageProducts?categoryTitle=天使' />"
								<c:if test="${categoryTitle=='天使'&&categoryName==''}">style="color: rgb(73, 105, 247) !important; font-weight: bold;"</c:if>>全部</a></li>
							<c:forEach var="angelCategory" items="${angelCategoryList}">
								<li><a
									<c:if test="${categoryTitle=='天使'&&categoryName==angelCategory}">style="color: rgb(73, 105, 247) !important; font-weight: bold;"</c:if>
									href="<spring:url value='/product/showPageProducts?categoryTitle=天使&categoryName=${angelCategory}' />">${angelCategory}</a></li>
							</c:forEach>
						</ul>
						<a id="left_list_b" href="#pane-3" data-toggle="list"
							style="font-size: 20px;"
							<c:choose>
								<c:when test="${categoryTitle=='惡魔'}">
									class="list-group-item list-group-item-action active"
								</c:when>
								<c:otherwise>
									class="list-group-item list-group-item-action"
								</c:otherwise>
							</c:choose>>惡魔</a>
						<ul id="list_b"
							<c:if test="${categoryTitle=='惡魔'}">style="display: block"</c:if>>
							<li><a
								<c:if test="${categoryTitle=='惡魔'&&categoryName==''}">style="color: rgb(73, 105, 247) !important; font-weight: bold;"</c:if>
								href="<spring:url value='/product/showPageProducts?categoryTitle=惡魔' />">全部</a></li>
							<c:forEach var="evilCategory" items="${evilCategoryList}">
								<li><a
									<c:if test="${categoryTitle=='惡魔'&&categoryName==evilCategory}">style="color: rgb(73, 105, 247) !important; font-weight: bold;"</c:if>
									href="<spring:url value='/product/showPageProducts?categoryTitle=惡魔&categoryName=${evilCategory}' />">${evilCategory}</a></li>
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
								<li><a href="<spring:url value='/product/productHome' />">首頁</a></li>
								<li>/<a
									href="<spring:url value='/product/showPageProducts?categoryTitle=${product.category.categoryTitle}' />">
										${product.category.categoryTitle}</a></li>
								<li>/ ${product.productName}</li>
							</ul>
						</div>
					</div>
					<div class="row p-5"
						style="background-color: rgba(248, 248, 248, 0.336)">
						<div style="width: 35%;" class="productImg">
							<img
								src="<spring:url value='/product/getProductImage/${product.productId}' />"
								style="width: 100%;" alt="item" >
						</div>
						<div class="Commodity_control" style="margin: 0px; width: 65%;">
							<div class="pl-4">
								<div class="Product_title">

									<span>
										<h3 class="text-dark">${product.productName}</h3>

									</span>
									<div class="addToCartLoc" ><i class="fas fa-shopping-cart"></i></div>
								</div>
								<span>&nbsp</span>
								<div>
									<span class="price">
										<h2 class="text-danger">$ ${product.price}</h2>
									</span>
								</div>
								<!-- 規格 -->
								<form action="" name="buyForm" id="buyForm">
									<div class="specification row pb-2">
										<div class="col-12">
											<c:if test="${title1!=''}">
												<span style='display: inline-block; padding-top: 8px;'>
													<h5 class="text-dark">${title1}：</h5>
												</span>
												<ul
													style="padding-left: 0px !important; display: inline-block;">
													<c:forEach var="entry" items="${content1}"
														varStatus="count">
														<li><input id="${entry}" type="radio" name="content1"
															value="${entry}"
															<c:if test="${count.first}">checked</c:if>><label
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
													<c:forEach var="entry2" items="${content2}"
														varStatus="count">
														<li><input id="${entry2}" type="radio"
															name="content2" value="${entry2}"
															<c:if test="${count.first}">checked</c:if>> <label
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
										<button type="button" class="btn btn-outline-danger"
											
											<c:choose>
												<c:when test="${empty LoginOK}">onclick="loginModel()"</c:when>
												<c:otherwise>onclick="addShoppinCart()"</c:otherwise>
											</c:choose>  id="addToCart">
											加入購物車<i class="fas fa-shopping-cart"></i>
										</button>
										<button type="button" class="btn btn-outline-danger buy"
											onclick="buyNow()">直接購買</button>
											
									</div>
								</form>
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



	<!-- 登入浮動視窗============================= -->
	<div class="modal fade" id="ignismyModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="">
						<span>×</span>
					</button>
				</div>

				<div class="modal-body">
					<p class="h3 ml-3 mb-2">請登入再抒唷！</p>
					<p>
						<a
							href="<spring:url value='/member/login?target=/product/showProductInfo/${product.productId}&loginFilter=true' />"
							style="text-decoration: none; color: black;">
							<button type="button" class="btn btn-light ml-3">Login
								Now</button>
						</a>
					</p>
				</div>
			</div>
		</div>
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
<!-- 		<script src="https://code.jquery.com/jquery-3.4.1.js"></script> -->
			<script
			src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
		<script src="<spring:url value='/js/product/addToCart.js' /> "></script>
	

</body>
</html>