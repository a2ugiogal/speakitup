<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>要抒拉管理員--商品管理</title>
<!-- 載入 Bootstrap 的CSS -->
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.4.1/cerulean/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-LV/SIoc08vbV9CCeAwiz7RJZMI5YntsH8rGov0Y2nysmepqMWVvJqds6y0RaxIXT"
	crossorigin="anonymous" />
	<link rel="shortcut icon" href="<spring:url value='/image/logo/logo_trans_92px.png' /> ">
<link rel="stylesheet"
	href="<spring:url value='/css/manager/allProducts.css' />" />
<link rel="stylesheet"
	href="<spring:url value='/css/manager/nav.css' />" />
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

	<div class="pb-5" id="pageBg">
		<div style="height: 60px;"></div>
		<div class="w-75 my-5 mx-auto allProducts_spacing">
			<div class="row border-bottom border-dark m-0 pb-4 mb-5">
				<div class="col p-0" style="font-size: 2em;">商品管理</div>
				<div class="col p-0 d-flex justify-content-end align-items-center">
					<div class="allProducts_button">
						<a href="<spring:url value='/product/addProduct/0'/>"
							style="text-decoration: none;"><span>新增商品</span></a>
						<div class="liquid"></div>
					</div>
				</div>
			</div>
			<ul class="nav nav-pills my-4" id="pills-tab" role="tablist">
				<li class="nav-item col text-sm-center" id="all"
					style="padding-left: 0px !important; padding-right: 0px !important;">
					<a
					<c:choose>
							<c:when test="${categoryTitle=='天使'}">class="nav-link active"</c:when>
							<c:otherwise>class="nav-link"</c:otherwise>
						</c:choose>
					role="tab" aria-controls="pills-home" aria-selected="true"
					href="<spring:url value='/product/showProducts?categoryTitle=天使'/>">天使</a>
				</li>
				<li class="nav-item col text-sm-center" id="waitShip"
					style="padding-left: 0px !important; padding-right: 0px !important;">
					<a
					<c:choose>
							<c:when test="${categoryTitle=='惡魔'}">class="nav-link active"</c:when>
							<c:otherwise>class="nav-link"</c:otherwise>
						</c:choose>
					role="tab" aria-controls="pills-profile" aria-selected="false"
					href="<spring:url value='/product/showProducts?categoryTitle=惡魔'/>">惡魔</a>
				</li>
			</ul>
			<form action="<spring:url value='/product/showProducts'/>">
				<input type="hidden" value="${categoryTitle}" name="categoryTitle" />
				<div class="input-group my-3">
					<div class="input-group-prepend">
						<span class="input-group-text"><i class="fas fa-search"></i></span>
					</div>
					<input type="search" class="form-control" placeholder="搜尋： 商品名稱"
						name="searchStr" aria-label="Sizing example input"
						value="${searchStr}" aria-describedby="inputGroup-sizing-default" />
					<div class="input-group-append">
						<button class="btn btn-outline-dark" id="button-addon2"
							style="border: 0px solid; background: rgb(155, 148, 148); color: white;">
							搜尋</button>
					</div>
				</div>
			</form>

			<div class="contentBox mt-4"
				style="border: 1px solid rgba(0, 0, 0, 0.575); border-radius: 0.5em;">
				<div class="row m-0">
					<div
						class="col-2 d-flex justify-content-center align-items-center text-center my-2"></div>
					<div
						class="col-2 d-flex justify-content-center align-items-center text-center my-2">
						商品編號</div>
					<div
						class="col-2 d-flex justify-content-center align-items-center text-center my-2">
						商品名稱</div>
					<div
						class="col-2 d-flex justify-content-center align-items-center text-center my-2">
						分類</div>
					<div
						class="col-2 d-flex justify-content-center align-items-center text-center my-2">
						價格</div>
					<div
						class="col-2 d-flex justify-content-center align-items-center text-center my-2"></div>
				</div>
				<c:forEach var="entry" items="${product_map}">
					<div class="row productRow m-0">
						<div
							class="col-2 d-flex justify-content-center align-items-center text-center my-2"
							onclick="location.href='<spring:url value="/product/addProduct/${entry.value.productId}"/>';">
							<img
								src="<spring:url value='/product/getProductImage/${entry.value.productId}' />"
								alt="" style="width: 100px; height: 100px;" />
						</div>
						<div
							class="col-2 d-flex justify-content-center align-items-center text-center my-2"
							onclick="location.href='<spring:url value="/product/addProduct/${entry.value.productId}"/>';">${entry.value.productId}</div>
						<div
							class="col-2 d-flex justify-content-center align-items-center text-center my-2"
							onclick="location.href='<spring:url value="/product/addProduct/${entry.value.productId}"/>';">${entry.value.productName}</div>
						<div
							class="col-2 d-flex justify-content-center align-items-center text-center my-2"
							onclick="location.href='<spring:url value="/product/addProduct/${entry.value.productId}"/>';">${entry.value.category.categoryName}</div>
						<div
							class="col-2 d-flex justify-content-center align-items-center text-center my-2"
							onclick="location.href='<spring:url value="/product/addProduct/${entry.value.productId}"/>';">$
							${entry.value.price}</div>
						<div
							class="col-2 d-flex justify-content-center align-items-center text-center my-2">
							<i class="far fa-times-circle" style="font-size: 30px;"
								onclick="checkDelete('${entry.value.productId}','${entry.value.productName}')"></i>
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
							href="<spring:url value='/article/showPageArticles?categoryTitle=天使' />">天使版</a>
						</li>
						<li><a
							href="<spring:url value='/article/showPageArticles?categoryTitle=惡魔' />">惡魔版</a>
						</li>
						<li><a href="<spring:url value='/letter/letterHome' />">漂流信</a>
						</li>
					</ul>
				</div>
				<!-- Grid column -->

				<hr class="clearfix w-100 d-md-none" />

				<!-- Grid column -->
				<div class="col-md-2 mx-auto">
					<!-- Links -->
					<h5 class="font-weight-bold text-uppercase mb-3">商城</h5>

					<ul class="list-unstyled">
						<li><a href="<spring:url value='/product/productHome' />">商城首頁</a>
						</li>
						<li><a href="<spring:url value='/order/shoppingCartList' />">我的購物車</a>
						</li>
						<li><a href="<spring:url value='/order/showHistoryOrder' />">歷史訂單</a>
						</li>
					</ul>
				</div>
				<!-- Grid column -->

				<hr class="clearfix w-100 d-md-none" />

				<!-- Grid column -->
				<div class="col-md-2 mx-auto">
					<!-- Links -->
					<h5 class="font-weight-bold text-uppercase mb-3">關於我們</h5>

					<ul class="list-unstyled">
						<li><a href="<spring:url value='/aboutUs/contact' />">聯絡我們</a>
						</li>
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

	<!-- 確認刪除商品 浮動視窗========== -->
	<div class="modal fade" id="deleteProductModal" tabindex="-1"
		role="dialog" aria-labelledby="deleteProductModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" id="modalBody">
					確認是否刪除<br /> 編號：名稱：之商品?
				</div>
				<div class="modal-footer">
					<a style="text-decoration: none; color: black;" id="aSend"> <input
						type="button" class="btn" style="background: rgb(136, 116, 116) !important;color: #fff;" value="刪除" />
					</a>
				</div>
			</div>
		</div>
	</div>
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
	<script type="text/javascript">
		function checkDelete(productId, productName) {
			$("#deleteProductModal").modal("show");
			var aSend = document.getElementById("aSend");
			modalBody = document.getElementById("modalBody");
			modalBody.innerHTML = "確認是否刪除<br> 編號：" + productId + " 名稱："
					+ productName + "之商品?";
			aSend.href = "<c:url value='/product/deleteProduct/" + productId
					+ "'/>";
			$("#deleteProductModal").modal("hide");
		}
	</script>
</body>
</html>