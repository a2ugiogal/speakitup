<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>購物車--要抒啦</title>

<!-- 載入 Bootstrap 的CSS -->
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.4.1/cerulean/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-LV/SIoc08vbV9CCeAwiz7RJZMI5YntsH8rGov0Y2nysmepqMWVvJqds6y0RaxIXT"
	crossorigin="anonymous">
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
<link rel="stylesheet"
	href="<spring:url value='/css/order/shoppingCart.css' />">
<script src="<spring:url value='/js/order/shoppingCart.js' />"></script>
<link rel="stylesheet"
	href="<spring:url value='/css/register/nav.css' /> " />
<script type="text/javascript">
	var n;
	var key;
	function deleteCart(n) {
		document.forms[0].action = "<spring:url value='/order/updateShoppingCart?cmd=DEL&productFormatId="
				+ n + "' />";
		document.forms[0].method = "POST";
		document.forms[0].submit();
	}
	function modifyQuantity(key, index) {
		var x = "newQty" + index;
		var newQty = document.getElementById(x).value;
		document.forms[0].action = "<spring:url value='/order/updateShoppingCart?cmd=QTY&productFormatId="
				+ key + "&newQty=" + newQty + "' />";
		document.forms[0].method = "POST";
		document.forms[0].submit();
	}
	function modifyFormat(key, index) {
		var x = "newFmt" + index;
		var newFmt = document.getElementById(x).value;
		document.forms[0].action = "<spring:url value='/order/updateShoppingCart?cmd=FMT&productFormatId="
				+ key + "&newFmt=" + newFmt + "' />";
		document.forms[0].method = "POST";
		document.forms[0].submit();
	}
	function changeChoose(key, index) {
		var choose = document.getElementsByClassName("choose")[index].checked;
		document.forms[0].action = "<spring:url value='/order/updateShoppingCart?cmd=CHS&productFormatId="
				+ key + "&choose=" + choose + "' />";
		document.forms[0].method = "POST";
		document.forms[0].submit();
	}
	function changeAll() {
		var chooseAll = document.getElementById("allCheck").checked;
		document.forms[0].action = "<spring:url value='/order/updateShoppingCart?cmd=CSA&chooseAll="
				+ chooseAll + "' />";
		document.forms[0].method = "POST";
		document.forms[0].submit();
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

	<!-- 商城頁面 -->
	<div class="commodity">
		<section>
			<div id="procentext" class="row m-0">
				<div class="col-2"></div>
				<!-- 商品 -->
				<div class="col-8 Product_content">
					<div class="History_Title">購物車</div>
					<div class="shopping-cart">
						<div class="column-labels">
							<label class="product-checkbox"> <input type="checkbox"
								id="allCheck" onchange="changeAll()" />
							</label> <label class="product-check"> 全選 </label><label
								class="product-image">&nbsp</label> <label
								class="product-details">商品名稱</label> <label
								class="product-format">商品規格</label> <label class="product-price">商品價格</label>
							<label class="product-quantity">商品數量</label> <label
								class="product-line-price">總金額</label> <label
								class="product-removal">&nbsp</label>
						</div>


						<form action="<spring:url value='/order/orderList' />">
							<c:forEach var="cartMap" varStatus="vs"
								items="${ShoppingCart.content}">
								<c:forEach var="orderMap" items="${cartMap.value}">

									<div class="product">
										<span class="product-span"> <c:forEach var="checkedMap"
												items="${ShoppingCart.checkedMap}">
												<c:if test="${checkedMap.key==cartMap.key}">
													<input type="checkbox" class="choose"
														<c:if test="${checkedMap.value=='y'}"> checked </c:if>
														onchange="changeChoose('${checkedMap.key}',${vs.index})" />
												</c:if>
											</c:forEach>
										</span>
										<div class="product-image">
											<img
												src="<spring:url value='/product/getProductImage/${orderMap.key.productId}' />" />
										</div>
										<div class="product-details">
											<div class="product-title">
												<h5>${orderMap.key.productName}</h5>
											</div>
										</div>
										<div class="product-format">
											<c:choose>
												<c:when
													test="${(orderMap.key.formatContent1=='')&&(orderMap.key.formatContent2=='')}">無 </c:when>
												<c:otherwise>
													<select name="format" id="newFmt${vs.index}"
														onchange="modifyFormat('${cartMap.key}',${vs.index})">
														<c:choose>
															<c:when test="${(orderMap.key.formatContent2=='')}">
																<c:forEach var="productSet" items="${orderMap.value}">
																	<option value="${productSet.formatContent1}"
																		<c:if test="${(orderMap.key.formatContent1==productSet.formatContent1)}"> selected </c:if>>${productSet.formatContent1}</option>
																</c:forEach>
															</c:when>
															<c:otherwise>
																<c:forEach var="productSet" items="${orderMap.value}">
																	<option
																		value="${productSet.formatContent1},${productSet.formatContent2}"
																		<c:if test="${(orderMap.key.formatContent1==productSet.formatContent1)&&(orderMap.key.formatContent2==productSet.formatContent2)}"> selected </c:if>>${productSet.formatContent1},${productSet.formatContent2}</option>
																</c:forEach>
															</c:otherwise>
														</c:choose>
													</select>
												</c:otherwise>
											</c:choose>
										</div>
										<div class="product-price">${orderMap.key.unitPrice}</div>
										<div class="product-quantity">
											<input type="number" name="count" id="newQty${vs.index}"
												style="max-width: 100%;"
												onchange="modifyQuantity('${cartMap.key}',${vs.index})"
												value="${orderMap.key.quantity}" min="1">
										</div>
										<div class="product-line-price singleTotal">${orderMap.key.unitPrice*orderMap.key.quantity}</div>
										<div class="product-removal">
											<button class="remove-product"
												onclick="deleteCart('${cartMap.key}')">
												<i class="fas fa-times"></i>
											</button>
										</div>
									</div>
								</c:forEach>
							</c:forEach>


							<div class="totals">
								<c:forEach var="entry" items="${errorMsg}">
									<font color="red">${entry.value}</font>
								</c:forEach>
								<div class="totals-item">
									<label>總金額</label>
									<div class="totals-value" id="cart-shipping">
										<span id="totalPrice"></span>
									</div>
								</div>
							</div>
							<button type="submit" class="checkout" role="button"
								onclick="checkShoppingCart(${ShoppingCart})">Checkout</button>
						</form>
					</div>
				</div>
				<div class="col-2"></div>
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