<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>要抒啦--購物區</title>
<!-- 載入 Bootstrap 的CSS -->
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.4.1/cerulean/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-LV/SIoc08vbV9CCeAwiz7RJZMI5YntsH8rGov0Y2nysmepqMWVvJqds6y0RaxIXT"
	crossorigin="anonymous" />
<link rel="stylesheet"
	href="<spring:url value='/css/product/productList.css' />" />
<link rel="stylesheet"
	href="<spring:url value='/css/product/nav.css' />" />
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
					style="width: 70% !important;" value="${searchStr}" />
				<button class="btn" type="submit" id="search-btn">搜尋</button>
				<input type="hidden" value="-1" name="pageNo"><input
					type="hidden" value="${arrange}" name="arrange" class="arrangeNew"><input
					type="hidden" value="${categoryTitle}" name="categoryTitle"
					id="categoryTitle"><input type="hidden"
					value="${categoryName}" name="categoryName" id="categoryName">
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

	<!-- 商城頁面  上方圖示-->
	<div class="mall">
		<section>
			<div
				class="jumbotron jumbotron-fluid jumbotron-bg d-flex align-items-end">
				<div class="container jumbotron-text text-white p-4">
					<h1 class="display-4" style="font-weight: bold; color: white;">
						買到剁手手！年終出清！</h1>
					<p class="lead">This is a modified jumbotron that occupies the
						entire horizontal space of its parent.</p>
				</div>
			</div>
		</section>
		<section>
			<div id="procen_text" class="row m-0">
				<!-- 商品分類子預覽列 -->
				<div class="col-2">
					<div id="left_list"
						class="list-group sticky-element dropdown-menuy"
						style="margin-top: 75px">
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
				</div>
				<!-- 商品頁面 -->
				<div class="col-9 p-0 ml-3">
					<!-- 控制麵包和下拉式選單在同一行 -->
					<div id="nav_info" class="row m-0 my-1 px-2">
						<!-- 麵包屑 -->
						<div class="col-6 d-flex justify-content-start align-items-center">
							<ul style="padding-left: 0px !important;">
								<li><a href="<spring:url value='/product/productHome' />">首頁</a></li>
								<c:choose>
									<c:when test="${categoryTitle!=''}">
										<li>/</li>
										<li><a
											href="<spring:url value='/product/showPageProducts?categoryTitle=${categoryTitle}' />">${categoryTitle}</a></li>
									</c:when>
									<c:otherwise>
										<li>/</li>
										<li><a
											href="<spring:url value='/product/showPageProducts' />">全部</a></li>
									</c:otherwise>
								</c:choose>
								<c:if test="${categoryName!=''}">
									<li>/</li>
									<li class="ml-1">${categoryName}</li>
								</c:if>
							</ul>
						</div>
						<!-- 下拉式選單 -->
						<div class="col-6 d-flex justify-content-end align-items-center">
							<span> <select name="arrange" id="arrange"
								class="YourLocation_1" style="margin-left: 8.5em;">
									<option value="price"
										<c:if test="${arrange=='price'}"> selected </c:if>>商品價格
										⇧</option>
									<option value="popular"
										<c:if test="${arrange=='popular'}"> selected </c:if>>銷售數量
										⇧</option>
									<option value="time"
										<c:if test="${arrange=='time'}"> selected </c:if>>最新⇧</option>
							</select>
							</span>
						</div>
					</div>
					<!-- 商品 -->
					<div class="row" id="product_list">
						<c:forEach var="entry" items="${products_map}">
							<a
								href="<spring:url value='/product/showProductInfo/${entry.key.productId}'/>"
								style="text-decoration: none;">
								<div
									class="col-lg-6 col-xl-4 p-0 py-3 d-flex justify-content-center">
									<div class="card text-center h-100 border-0 box-shadow">
										<img
											src="<spring:url value='/product/getProductImage/${entry.key.productId}' />"
											class="card-img-top img_high" />
										<div class="card-body">
											<h5 class="card-title" style="font-weight: bold;">${entry.key.productName}</h5>
											<p class="card-text" style="color: #495057">${entry.value}</p>
										</div>
										<div class="card-footer border-top-0 bg-white mb-3">
											<div class="btn-group" role="group" aria-label="First group"></div>
											<span style="color: #495057 !important; font-size: 20px">$
												${entry.key.price}</span><a></a>
										</div>
									</div>
								</div>
							</a>
						</c:forEach>
					</div>

					<!-- 分頁+下拉式選單 -->
					<nav aria-label="Page navigation example">
						<ul class="pagination">
							<li class="page-item"
								<c:if test="${pageNo==1}">style="visibility: hidden;"</c:if>><a
								class="page-link"
								href="<spring:url value='/product/showPageProducts?pageNo=${pageNo-1}&search=${searchStr}&arrange=${arrange}&categoryTitle=${categoryTitle}&categoryName=${categoryName}'/>"><i
									class='fas fa-angle-left' style='font-size: 23px'></i></a></li>
							<form action="<spring:url value='/product/showPageProducts' />"
								id="pageForm">
								<span><select name="pageNo" id="nowPage"
									class="YourLocation_2">
										<c:forEach var="pages" begin="1" end="${totalPages}">
											<option value="${pages}" class="options"
												<c:if test="${pages==pageNo}"> selected </c:if>>${pages}</option>
										</c:forEach>
								</select></span> <input type="hidden" name="search" value="${searchStr}">
								<input type="hidden" value="${arrange}" name="arrange"
									class="arrangeNew"><input type="hidden"
									value="${categoryTitle}" name="categoryTitle"><input
									type="hidden" value="${categoryName}" name="categoryName">
							</form>
							<li class="page-item"
								<c:if test="${pageNo==totalPages}">style="visibility: hidden;"</c:if>><a
								class="page-link"
								href="<spring:url value='/product/showPageProducts?pageNo=${pageNo+1}&search=${searchStr}&arrange=${arrange}&categoryTitle=${categoryTitle}&categoryName=${categoryName}'/>"><i
									class='fas fa-angle-right' style='font-size: 23px'></i></a></li>
						</ul>
					</nav>
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

	<script src="https://code.jquery.com/jquery-3.5.1.min.js"
		integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
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
	<script src="<spring:url value='/js/product/productList.js' />"></script>
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

</body>
</html>