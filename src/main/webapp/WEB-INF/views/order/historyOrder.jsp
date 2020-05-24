<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>歷史訂單--要抒拉</title>
<!-- 載入 Bootstrap 的CSS -->
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.4.1/cerulean/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-LV/SIoc08vbV9CCeAwiz7RJZMI5YntsH8rGov0Y2nysmepqMWVvJqds6y0RaxIXT"
	crossorigin="anonymous" />
<!-- icon -->
<script src="https://kit.fontawesome.com/041970ba48.js"
	crossorigin="anonymous"></script>

<link rel="stylesheet"
	href="<spring:url value='/css/product/nav.css' /> " />
<link rel="stylesheet"
	href="<spring:url value='/css/order/historyOrder.css' /> " />
	<link rel="shortcut icon" href="<spring:url value='/image/logo/logo_trans_92px.png' /> ">
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
	<div style="padding: 120px 0px 60px 0px;" id="bg-color">
		<div id="Confirm_Order_1" class="w-75 mx-auto px-5 pt-4 pb-5">
			<div class="Confirm_Order_title">歷史訂單</div>
			<ul class="nav nav-pills my-3 text-sm-center" id="pills-tab"
				role="tablist">
				<li class="nav-item col"><a class="nav-link active" id="all"
					data-toggle="pill" href="#" role="tab" aria-controls="pills-home"
					aria-selected="true">全部</a></li>
				<li class="nav-item col"><a class="nav-link" id="waitShip"
					data-toggle="pill" href="#" role="tab"
					aria-controls="pills-profile" aria-selected="false">待出貨</a></li>
				<li class="nav-item col"><a class="nav-link" id="alreadyShip"
					data-toggle="pill" href="#" role="tab"
					aria-controls="pills-contact" aria-selected="false">已出貨</a></li>
				<li class="nav-item col"><a class="nav-link" id="finish"
					data-toggle="pill" href="#" role="tab"
					aria-controls="pills-contact" aria-selected="false">已完成</a></li>
			</ul>
			<div class="container-fluid"
				style="border: 1px solid rgba(0, 0, 0, 0.575); border-radius: 5px;">
				<div class="row border-bottom">
					<div class="col-1 text-center my-2"></div>
					<div class="col-2 text-center my-2">訂單編號</div>
					<div class="col-2 text-center my-2">訂購日期</div>
					<div class="col-2 text-center my-2">出貨日期</div>
					<div class="col-2 text-center my-2">到貨日期</div>
					<div class="col-2 text-center my-2">訂單狀態</div>
					<div class="col-1 text-center my-2"></div>
				</div>


				<c:forEach var="entry" items="${order_list}">
					<div class="row orderRow ${entry.status}">
						<div class="col-1 text-center my-2"></div>
						<div class="col-2 text-center my-2">${entry.orderNo}</div>
						<div class="col-2 text-center my-2">
							<fmt:formatDate value="${entry.orderDate}" pattern="yyyy-MM-dd" />
						</div>
						<div class="col-2 text-center my-2">
							<fmt:formatDate value="${entry.shippingDate}"
								pattern="yyyy-MM-dd" />
						</div>
						<div class="col-2 text-center my-2">
							<fmt:formatDate value="${entry.arriveDate}" pattern="yyyy-MM-dd" />
						</div>
						<div class="col-2 text-center my-2">${entry.status}</div>
						<div class="col-1 text-center my-2"></div>
					</div>
					<div class="row orderItems" style="display: none;">
						<div class="col-2 text-center my-2"></div>
						<div class="col-2 text-center my-2">商品名稱</div>
						<div class="col-2 text-center my-2">規格</div>
						<div class="col-2 text-center my-2">單價</div>
						<div class="col-2 text-center my-2">數量</div>
						<div class="col-2 text-center my-2">總價</div>
						<c:forEach var="detailMap" items="${orderItem_map}">
							<c:if test="${detailMap.key==entry.orderNo}">
								<c:forEach var="detailEntry" items="${detailMap.value}">
									<div
										class="col-2 d-flex justify-content-center align-items-center text-center border-top border-light py-2">
										<img
											src="<spring:url value='/product/getProductImage/${detailEntry.productId}' />"
											alt="" style="max-width: 100px;" />
									</div>
									<div
										class="col-2 d-flex justify-content-center align-items-center text-center border-top border-light py-2">
										${detailEntry.productName}</div>
									<div
										class="col-2 d-flex justify-content-center align-items-center text-center border-top border-light py-2">
										${detailEntry.formatContent1} ${detailEntry.formatContent2}</div>
									<div
										class="col-2 d-flex justify-content-center align-items-center text-center border-top border-light py-2">
										$ ${detailEntry.unitPrice}</div>
									<div
										class="col-2 d-flex justify-content-center align-items-center text-center border-top border-light py-2">
										${detailEntry.quantity}</div>
									<div
										class="col-2 d-flex justify-content-center align-items-center text-center border-top border-light py-2">
										$ ${detailEntry.unitPrice*detailEntry.quantity}</div>
								</c:forEach>
							</c:if>
						</c:forEach>
						<div
							class="col-12 d-flex justify-content-end align-items-center border-top border-light py-2">
							<span style="font-size: 20px;">總金額: $ ${entry.totalPrice}</span>
						</div>
					</div>




				</c:forEach>
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

	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
		integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
		integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
		integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
		crossorigin="anonymous"></script>
	<script src="<spring:url value='/js/order/historyOrder.js' />"></script>

</body>
</html>