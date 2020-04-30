<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>要抒拉--確認訂單</title>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<spring:url value='/css/order/check.css' />">
<script src="<spring:url value='/js/order/shoppingCart.js' />"></script>
<!-- 下拉式地址 -->
<script
	src="https://cdn.jsdelivr.net/npm/tw-city-selector@2.1.0/dist/tw-city-selector.min.js"></script>

<script>
	new TwCitySelector();
</script>
<!-- 下拉式地址 -->
</head>
<style>
a {
	color: black;
}

#a-style a {
	text-decoration: none;
}
/*下拉式選單地址*/
#address select {
	font: 16px Tahoma;
	height: 30px;
	margin-right: 5px;
}
</style>

<body class="bg-light">

	<div class="top_area">

		<div class="logo">
			<a href="<spring:url value='/' />"> <img
				src="<spring:url value='/image/logo.png' />"
				style="width: 100px; height: 100px;" alt="">
			</a>
		</div>
		<div class="top-space"></div>
		<c:choose>
			<c:when test="${ ! empty LoginOK }">
				<a href="<spring:url value='/login/logout' />"> 登出 <i
					class="fas fa-sign-out-alt"></i>
				</a>
			</c:when>
			<c:otherwise>
				<a href="<spring:url value='/login/login'/>"> 登入 </a>
			</c:otherwise>
		</c:choose>
	</div>
	<ul id="a-style">
		<div class="test">
			<li class="dropdown"><i class="fas fa-bullhorn"></i> <a
				href="#home">論壇</a>
				<div class="dropdown-content">
					<a href="#">惡魔版</a> <a href="#">天使版</a>
				</div></li>
			<li class="dropdown"><i class="fas fa-shopping-bag"></i> <a
				href="#news">商城</a>
				<div class="dropdown-content">
					<a href="#">購物區</a> <a href="#">購物車</a> <a href="#">歷史訂單</a>
				</div></li>
			<li class="dropdown"><i class="fas fa-user-friends"></i> <a
				href="">關於我們</a>
				<div class="dropdown-content">
					<a href="#">創建理念</a> <a href="#">團隊介紹</a> <a href="#">關於我們</a>
				</div></li>
		</div>
	</ul>

	<div class="cart-box p-2">
		<h1 class="m-0">確認訂單</h1>
		<!-- 標題======================================== -->
		<div class="items-menu border border-dark">
			<!-- <hr style="background: black;" /> -->
			<div class="row p-2">
				<div
					class="col-1 h4 m-0 d-flex justify-content-center align-items-center ">
					<input type="checkbox" id="allCheck" onchange="changeAll()"
						disabled />
				</div>
				<div
					class="col-2 h6 m-0 d-flex justify-content-start align-items-center">
					全選</div>
				<div
					class="col-2 h5 m-0 d-flex justify-content-center align-items-center">
					商品名稱</div>
				<div
					class="col-3 h5 m-0 d-flex justify-content-center align-items-center">
					規格</div>
				<div
					class="col-1 h5 m-0 d-flex justify-content-center align-items-center">
					單價</div>
				<div
					class="col-1 h5 m-0 d-flex justify-content-center align-items-center">
					數量</div>
				<div
					class="col-1 h5 m-0 d-flex justify-content-center align-items-center">
					總價</div>
				<div class="col-1 d-flex justify-content-center align-items-center"></div>
			</div>

			<hr class="m-0" style="background: black;" />

			<!-- 內容物=================================== -->


			<c:forEach var="cartMap" varStatus="vs"
				items="${ShoppingCart.content}">

				<c:forEach var="orderMap" items="${cartMap.value}">
					<c:forEach var="checkedMap" items="${ShoppingCart.checkedMap}">
						<c:if test="${checkedMap.key==cartMap.key}">

							<c:if test="${checkedMap.value=='y'}">

								<div class="row p-2 cartItem">
									<div
										class="col-1 d-flex justify-content-center align-items-center">
										<input type="checkbox" class="choose" disabled
											<c:if test="${checkedMap.value=='y'}"> checked </c:if>
											onchange="changeChoose('${checkedMap.key}',${vs.index})" />
									</div>
									<div
										class="col-2 d-flex justify-content-center align-items-center">

										<img
											src="<spring:url value='/product/getProductImage/${orderMap.key.productId}'/>"
											style="max-width: 80%; max-height: 150px;" />

									</div>
									<div
										class="col-2 h4 m-0 d-flex justify-content-center align-items-center">
										${orderMap.key.productName}</div>
									<div
										class="col-3 h5 m-0 d-flex justify-content-center align-items-center">
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
									<div
										class="col-1 h5 m-0 d-flex justify-content-center align-items-center">
										$ <span class="singlePrice">${orderMap.key.unitPrice}</span>
									</div>
									<div
										class="col-1 h5 m-0 d-flex justify-content-center align-items-center"
										style="padding: 0px;">

										<!-- 無法更動數量 -->
										<span style="color: #5B616A;">${orderMap.key.quantity}</span>
									</div>
									<div
										class="col-1 h5 m-0 d-flex justify-content-center align-items-center ">
										$ <span class="singleTotal">${orderMap.key.unitPrice*orderMap.key.quantity}</span>

									</div>
									<div
										class="col-1 d-flex justify-content-center align-items-center">
										<i class="fas fa-check"></i>
									</div>
								</div>
							</c:if>
						</c:if>
					</c:forEach>
				</c:forEach>
			</c:forEach>



			<hr class="m-0" style="background: black;" />
			<!-- 總金額================================================= -->
			<div class="row p-2">
				<div class="col-5"></div>
				<div
					class="col-4 h4 m-0 d-flex justify-content-center align-items-center">
					總金額： $ <span id="totalPrice" class="mr-5"> </span> <span><a
						href="<spring:url value='/product/showProductInfo/${productId}'/> ">返回<i
							class="fas fa-arrow-left "></i></a></span>
				</div>
			</div>
		</div>
	</div>




	<form action="<spring:url value='/order/orderCheck'/>">

		<div class="items-menu border border-dark p-2"
			style="width: 80%; margin: 50px 10% 0 10%;">
			<h2>訂單資訊</h2>
			<hr style="background: black;">
			<div class="row p-2">

				<div class="formBox col-7">

					<!-- 					<label for="orderInfo" class="col-sm-6">訂單資訊</label> -->

					<div class="form-group row">
						<label for="name" class="col-sm-3 ml-3">姓名</label> <input
							type="text" class="form-control  col-6" name="name" value=""
							placeholder="Name" required="required">
					</div>
					<div class="form-group row">
						<label for="address" class="col-sm-3 ml-3">地址</label>
						<div role="tw-city-selector" id="address" class="col-4"
							data-county-value="${LoginOK.city}"
							data-district-value="${LoginOK.area}"></div>
						<input name="address" value="${LoginOK.address}" type="text"
							class="contentText form-control col-3" placeholder="Address"
							required="required" />
					</div>
					<div class="form-group row">
						<label for="address" class="col-sm-3 ml-3">電話</label> <input
							type="text" class="form-control col-6" name="phone"
							value="${LoginOK.phone}" placeholder="Phone" maxlength="10"
							onkeyup="value=value.replace(/[^\d]/g,'')" required="required">
					</div>
					<div class="form-group row">
						<label for="payment" class="col-sm-3 ml-3">付款方式</label> <select
							class="form-control form-control-sm col-6">
							<option>信用卡付款</option>
						</select>
					</div>
					<input type="hidden" name="buyCartStr" value="${buyCartStr}">
					<button type="submit" class="btn btn-primary ml-3">送出</button>
				</div>
				<div class="textAreaBox col-3">
					<label for="">備註</label>
					<textarea class="form-control w-75 h-50" name="note"></textarea>
				</div>

			</div>

		</div>
	</form>


</body>
</html>