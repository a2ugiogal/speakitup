<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>要抒啦--購物區</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous" />

<link rel="stylesheet"
	href="<spring:url value='/css/product/productList.css' />" />
<script src="<spring:url value='/js/product/productList.js' />"></script>
</head>
<body>
	<%-- 	<jsp:include page="../fragment/topForLogin.jsp" /> --%>
	<div class="product">
		<div class="w-75 m-auto">
			<a href="<spring:url value='/product/showPageProducts?pageNo=-1' />">全部商品</a>
			<a
				href="<spring:url value='/product/showPageProducts?categoryTitle=天使&pageNo=-1' />">天使商品</a>
			<a
				href="<spring:url value='/product/showPageProducts?categoryTitle=天使&categoryName=日常用品&pageNo=-1' />">日常用品</a>
			<a
				href="<spring:url value='/product/showPageProducts?categoryTitle=天使&categoryName=紓壓小物&pageNo=-1' />">紓壓小物</a>
			<a
				href="<spring:url value='/product/showPageProducts?categoryTitle=惡魔&pageNo=-1' />">惡魔商品</a>
			<!-- 搜尋選擇列=================================== -->
			<form action="<spring:url value='/product/showPageProducts' />"
				id="searchForm">
				<div class="row">
					<div class="input-group my-3 col-9 ">
						<div class="input-group-prepend">
							<span class="input-group-text"><img
								src="<spring:url value= '/image/product/search.png'/>"
								class="productImg" /></span>
						</div>
						<input type="search" class="form-control" placeholder="搜尋: 商品名稱"
							name="search" aria-label="Sizing example input"
							aria-describedby="inputGroup-sizing-default" value="${searchStr}" />
						<div class="input-group-append">
							<button class="btn btn-outline-secondary" id="button-addon2">搜尋</button>
						</div>
					</div>
					<div
						class="col-3 my-3 d-flex justify-content-end align-items-center">
						<span style="font-size: 10px;">排序：</span> <select name="arrange"
							id="arrange">
							<option value="time"
								<c:if test="${arrange=='time'}"> selected </c:if>>最新</option>
							<option value="popular"
								<c:if test="${arrange=='popular'}"> selected </c:if>>熱門</option>
							<option value="price"
								<c:if test="${arrange=='price'}"> selected </c:if>>價格</option>
						</select>
					</div>
					<input type="hidden" value="-1" name="pageNo"> <input
						type="hidden" value="${categoryTitle}" name="categoryTitle"><input
						type="hidden" value="${categoryName}" name="categoryName">
				</div>
			</form>
			<!-- products=================================== -->
			<div id="products">
				<div class="row">
					<c:forEach var="entry" items="${products_map}">
						<a
							href="<spring:url value='/product/showProductInfo/${entry.key.productId}'/>"
							class="col-12 col-sm-6 col-lg-4 mt-4">
							<div class="card border-dark">
								<img
									src="<spring:url value='/product/getProductImage/${entry.key.productId}' />"
									class="card-img-top productImg" />
								<div class="card-body">
									<h5 class="card-title"
										style="text-align: center; font-size: 30px;">${entry.key.productName}</h5>
									<div class="card-text mt-2"
										style="text-align: center; font-size: 20px;">$
										${entry.key.price}</div>
								</div>
							</div>
						</a>
					</c:forEach>
				</div>
			</div>
			<!-- 頁碼列=================================== -->
			<div class="row">
				<div id="pages"
					class="col d-flex justify-content-center align-items-center">
					<a
						href="<spring:url value='/product/showPageProducts?pageNo=${pageNo-1}&search=${searchStr}&arrange=${arrange}&categoryTitle=${categoryTitle}&categoryName=${categoryName}'/>"
						<c:if test="${pageNo==1}">style="visibility: hidden;"</c:if>>
						<button class="btPage">
							<img
								src="<spring:url value='/image/product/上一頁.png' />"
								style="max-width: 90%;" />
						</button>
					</a> <a
						href="<spring:url value='/product/showPageProducts?pageNo=1&search=${searchStr}&arrange=${arrange}&categoryTitle=${categoryTitle}&categoryName=${categoryName}'/>"
						<c:if test="${pageNo==1}">style="visibility: hidden;"</c:if>>
						<button class="btPage">1</button>
					</a> <span <c:if test="${pageNo==1}">style="visibility: hidden;"</c:if>>．．．</span>


					<form action="<spring:url value='/product/showPageProducts' />"
						id="pageForm">
						<span>第</span> <select name="pageNo" id="nowPage">
							<c:forEach var="pages" begin="1" end="${totalPages}">
								<option value="${pages}"
									<c:if test="${pages==pageNo}"> selected </c:if>>${pages}</option>
							</c:forEach>
						</select> <span>頁</span> <input type="hidden" name="search"
							value="${searchStr}"> <input type="hidden"
							value="${arrange}" name="arrange"><input type="hidden"
							value="${categoryTitle}" name="categoryTitle"><input
							type="hidden" value="${categoryName}" name="categoryName">
					</form>


					<span
						<c:if test="${pageNo==totalPages}">style="visibility: hidden;"</c:if>>．．．</span>


					<a
						href="<spring:url value='/product/showPageProducts?pageNo=${totalPages}&search=${searchStr}&arrange=${arrange}&categoryTitle=${categoryTitle}&categoryName=${categoryName}'/>"
						<c:if test="${pageNo==totalPages}">style="visibility: hidden;"</c:if>>
						<button class="btPage">${totalPages}</button>
					</a> <a
						href="<spring:url value='/product/showPageProducts?pageNo=${pageNo+1}&search=${searchStr}&arrange=${arrange}&categoryTitle=${categoryTitle}&categoryName=${categoryName}'/>"
						<c:if test="${pageNo==totalPages}">style="visibility: hidden;"</c:if>>
						<button class="btPage">
							<img
								src="<spring:url value='/image/product/下一頁.png' />"
								style="max-width: 90%;" />
						</button>
					</a>
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
</body>
</html>