<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>要抒啦--熱門商品</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous" />
<link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.css" />
<link rel="stylesheet"
	href="https://unpkg.com/swiper/css/swiper.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
div a {
	text-decoration: none;
	color: black;
}
</style>
</head>
<body>
	<div class="w-75 my-5 mx-auto">
		<h1>天使熱門榜</h1>
		<div class="swiper-container">
			<!-- Additional required wrapper -->

			<div class="swiper-wrapper">
				<!-- Slides -->
				<c:forEach var="entry" items="${angel_products_map}">
					<div class="p-3 swiper-slide">
						<a
							href="<c:url value='/product/ShowProductInfo?productId=${entry.value.productId}'/>">
							<div class="card border-dark">
								<img
									src="${pageContext.request.contextPath}/init/getProductImage?id=${entry.value.productId}"
									class="card-img-top productImg" />
								<div class="card-body">
									<h5 class="card-title"
										style="text-align: center; font-size: 30px;">${entry.value.productName}</h5>
									<div class="card-text mt-2"
										style="text-align: center; font-size: 20px;">$ ${entry.value.price}</div>
								</div>
							</div>
						</a>
					</div>
				</c:forEach>
			</div>

			<div class="swiper-button-prev"></div>
			<div class="swiper-button-next"></div>
		</div>
	</div>


	<div class="w-75 my-5 mx-auto">
		<h1>惡魔熱門榜</h1>
		<div class="swiper-container">
			<!-- Additional required wrapper -->

			<div class="swiper-wrapper">
				<!-- Slides -->
				<c:forEach var="entry" items="${evil_products_map}">
					<div class="p-3 swiper-slide">
						<a
							href="<c:url value='/product/ShowProductInfo?productId=${entry.value.productId}'/>">
							<div class="card border-dark">
								<img
									src="${pageContext.request.contextPath}/init/getProductImage?id=${entry.value.productId}"
									class="card-img-top productImg" />
								<div class="card-body">
									<h5 class="card-title"
										style="text-align: center; font-size: 30px;">${entry.value.productName}</h5>
									<div class="card-text mt-2"
										style="text-align: center; font-size: 20px;">${entry.value.price}</div>
								</div>
							</div>
						</a>
					</div>
				</c:forEach>
			</div>

			<div class="swiper-button-prev"></div>
			<div class="swiper-button-next"></div>
		</div>
	</div>




	<script src="https://unpkg.com/swiper/js/swiper.js"></script>
	<script src="https://unpkg.com/swiper/js/swiper.min.js"></script>
	<script>
		var mySwiper = new Swiper(".swiper-container", {
			// 排列方向,一次三張
			direction : "horizontal",
			loop : false,
			slidesPerView : 3,
			// Navigation arrows
			navigation : {
				nextEl : ".swiper-button-next",
				prevEl : ".swiper-button-prev"
			}
		});
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