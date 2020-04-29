<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="<spring:url value='/css/product/productInfo.css' />">
</head>

<body class="bg-light">

	<jsp:include page="../fragment/topForLogin.jsp" />

	<div class="productBox col-10">
		<form action="" name="buyForm">
			<div class="topProductBox">

				<div class="productImg col-5">
					<img
						src="<spring:url value='/product/getProductImage/${product.productId}' />"
						class="img-thumbnail">
				</div>
				<div class="itemSelect col-lg-6 col-sm-3 m-2">
					<div class="mt-2">
						商品名稱: ${product.productName} <span style="float: right;"><i
							class="fas fa-external-link-alt ml-5"></i></span>
					</div>
					<div class="mt-2">商品價格: ${product.price}</div>
					<div class="mt-3"></div>

					<c:if test="${title1!=''}">
						<div class="btn-group-vertical btn-group-toggle mb-5"
							data-toggle="buttons">${title1}
							<c:forEach var="entry" items="${content1}">
								<div
									class="btn btn-outline-secondary text-monospace mt-2 active">
									<input type="radio" name="content1" required="required"
										value="${entry}">${entry}
								</div>
							</c:forEach>
						</div>
					</c:if>
					<c:if test="${title2!=''}">
						<div class="btn-group-vertical btn-group-toggle"
							data-toggle="buttons">${title2}
							<c:forEach var="entry2" items="${content2}">
								<div
									class="btn btn-outline-secondary text-monospace mt-2 active">
									<input type="radio" name="content2" required="required"
										value="${entry2}">${entry2}
								</div>
							</c:forEach>
						</div>
					</c:if>

					<div class="mt-2">
						數量<input type="number" name="qty" value="1" min="1"
							class="ml-6 mt-2">
					</div>
					<div class="mt-2">
						<c:forEach var="entry" items="${errorMsg}">
							<font color="red">${entry.value}</font>
						</c:forEach>
					</div>
					<div class="btn-group-sm ml-3 mb-3" role="group"
						aria-label="Basic example">
						<input type="submit" class="btn btn-dark mt-3" role="button"
							value="立即購買 "
							onclick="buyForm.action='<c:url value="/order/checkOrder" />';">
						<input type="submit" class="btn btn-dark mt-3" role="button"
							id="joinCart" value="加入購物車"
							onclick="buyForm.action='<c:url value="/order/shoppingCart" />'; ">
						<a type="button" class="btn btn-dark mt-3" role="button"
							href="<c:url value="/product/ShowPageProducts" /> ">返回商品列表</a>
					</div>


				</div>
				<!-- topProduct結束標前 -->
			</div>
		</form>
		<div class="productDesc">
			<p style="text-align: center;">
				<span>商品介紹</span>
			</p>
			<span>${detail}</span>
		</div>

	</div>




	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
		integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
		crossorigin="anonymous">
		
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous">
		
	</script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
		integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
		crossorigin="anonymous">
		
	</script>
</body>
</html>