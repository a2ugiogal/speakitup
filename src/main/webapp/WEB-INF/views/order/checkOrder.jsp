<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>確認訂單--要抒拉</title>
<!-- 載入 Bootstrap 的CSS -->
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.4.1/cerulean/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-LV/SIoc08vbV9CCeAwiz7RJZMI5YntsH8rGov0Y2nysmepqMWVvJqds6y0RaxIXT"
	crossorigin="anonymous">
	<link rel="shortcut icon" href="<spring:url value='/image/logo/logo_trans_92px.png' /> ">
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
<!-- icon -->
<script src="https://kit.fontawesome.com/041970ba48.js"
	crossorigin="anonymous"></script>
<script src="<spring:url value='/js/order/check.js' />"></script>
<link rel="stylesheet"
	href="<spring:url value='/css/product/nav.css' /> " />
<link rel="stylesheet"
	href="<spring:url value='/css/order/check.css' />">
<!-- 下拉式地址 -->
<script
	src="https://cdn.jsdelivr.net/npm/tw-city-selector@2.1.0/dist/tw-city-selector.min.js"></script>
<script>
	new TwCitySelector();
</script>
<!-- 下拉式地址 -->
<style>
/*下拉式選單地址*/
#address select {
	margin-right: 10px;
	padding-left: 0.5em;
}
</style>
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
			style="position: absolute; right: 250px; top: 10px;"></div>
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

	<!-- 商城頁面 -->
	<div id="bg-color">
		<div id="Confirm_Order">
			<!-- 訂單商品 -->
			<span>確認訂單</span>
			<div style="background-color: white;">
				<section>
					<!-- 商品分類 -->
					<div id="procentext" class="row ">
						<!-- 商品 -->
						<div class="col-12">
							<div class="shopping-cart">
								<div class="column-labels procentext_list">
									<label>商品名稱</label> <label>商品規格</label> <label>商品價格</label> <label>商品數量</label>
									<label>總金額</label>
								</div>
								<c:forEach var="cartMap" varStatus="vs"
									items="${ShoppingCart.content}">
									<c:forEach var="orderMap" items="${cartMap.value}">
										<c:forEach var="checkedMap" items="${ShoppingCart.checkedMap}">
											<c:if test="${checkedMap.key==cartMap.key}">
												<c:if test="${checkedMap.value=='y'}">
													<div class="product procentext_list">
														<div style="text-align: center;">
															<img
																src="<spring:url value='/product/getProductImage/${orderMap.key.productId}'/>">
														</div>
														<div>
															<h5 style="color: rgb(73, 80, 87)">${orderMap.key.productName}</h5>
														</div>
														<div>
															<!-- 如果沒有規格 就寫無 -->
															<c:choose>
																<c:when
																	test="${(orderMap.key.formatContent1=='')&&(orderMap.key.formatContent2=='')}">無 </c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${(orderMap.key.formatContent2=='')}">
																			<span>${orderMap.key.formatContent1}</span>
																		</c:when>
																		<c:otherwise>
																			<span style="color: #5B616A;">${orderMap.key.formatContent1}
																				${orderMap.key.formatContent2}</span>
																		</c:otherwise>
																	</c:choose>
																</c:otherwise>
															</c:choose>
														</div>
														<div class="product-price">${orderMap.key.unitPrice}</div>
														<div class="product-quantity">
															<input type="number" value="${orderMap.key.quantity}"
																min="1" disabled />
														</div>
														<div class="product-price singlePrice">${orderMap.key.unitPrice*orderMap.key.quantity}</div>
													</div>
												</c:if>
											</c:if>
										</c:forEach>
									</c:forEach>
								</c:forEach>
								<div class="totals_view">
									<div>總金額</div>
									<div class="totals-value" id="totalPrice"></div>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
			<span>訂單資訊</span>
			<!-- 訂單資訊 -->
			<div style="background-color: white;">
				<div class="card border-0 ">
					<form class="needs-validation"
						action="<spring:url value='/order/orderCheck'/>">
						<div class="row" style="padding: 1em;">
							<div style="width: 35%; min-width: 500px;" class="col-4">
								<img src="<spring:url value='/image/order/616216.jpg' />"
									style="width: 100%;">
							</div>
							<!-- flex-column:橫向變成直向, -->
							<div style="width: 35%; min-width: 500px;"
								class="d-flex flex-column form-group " style="margin-left: 2em;">
								<div class="form-group">
									<label for="name" class="pt-3 mr-1"
										style="text-align: left; font-size: 1.5em;"> 姓名</label> <input
										style="width: 45%; padding-left: 0.5em; font-size: 1.5em;"
										type="text" id="name" name="name" placeholder="Name" required>
								</div>
								<div class="form-group" style="font-size: 1.5em;">
									<label for="zone" class=" mr-1 " style="text-align: left;">地址</label>
									<span> <span role="tw-city-selector" id="address"
										style="font-size: inherit;"
										data-county-value="${LoginOK.city}"
										data-district-value="${LoginOK.area}"></span>
									</span><br>
									<div
										style="width: 70%; float: left; margin-top: 5px; margin-left: 2.4em;">
										<input name="address" class=""
											style="width: 100%; padding-left: 0.5em;" type="text"
											required value="${LoginOK.address}">
									</div>
								</div>
								<div class="form-group">
									<label for="name" class="pt-3 mr-1"
										style="text-align: left; font-size: 1.5em;">電話</label> <input
										style="width: 45%; padding-left: 0.5em; font-size: 1.5em;"
										placeholder="Phone" name="phone" value="${LoginOK.phone}"
										maxlength="10" onkeyup="value=value.replace(/[^\d]/g,'')"
										required>
								</div>
								<div class="form-group">
									<label for="" class="pt-3 mr-1"
										style="text-align: left; font-size: 1.5em;">付款方式</label> <select
										name="" id=""
										style="padding-left: 0.5em; width: 8.7em; font-size: 1.5em;">
										<option value="">信用卡付款</option>
									</select>
								</div>
								<input type="hidden" name="buyCartStr" value="${buyCartStr}">
							</div>
							<div style="width: 30%;">
								<textarea name="note" id="" class="annotation5" placeholder="備註"></textarea>
							</div>
						</div>
						<div class="row">
							<div class="col-12 text-center">
								<button type="submit" class="btn btn-primary">確認付款</button>
							</div>
						</div>
					</form>
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

</body>
</html>