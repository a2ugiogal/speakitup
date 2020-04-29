<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/_05_product/productInfo.css">


<c:set var='debug' value='true' scope='application' />
<div class="top_area">
	
		<div class="logo">
		
			<a href="<c:url value='/index.jsp' />">
			<img src="${pageContext.request.contextPath}/image/logo.png"
				style="width: 100px; height: 100px;" alt="">
			</a>
		</div>
		<div class="top-space"></div>

		<div>
			<a class="animateCart animated flash text-danger"
				href="<c:url value='' />"><i class="fas fa-shopping-cart animated flash" id="cartIcon"></i>
			</a>
		</div>
		<div style="display:flex; items-direction:row;">
			<span class="option" style="margin-right:20px;" > <a
			href="<c:url value='/_04_order/shoppingCart.jsp' />"><i class="fas fa-shopping-cart" style="color:#0e2640;"></i></a>
			</span>
			<c:choose>
			<c:when test="${ ! empty LoginOK }">
			   <a href="<c:url value='/_02_login/logout.jsp' />">
  				登出 <i class="fas fa-sign-out-alt"></i>
	           </a>
			</c:when>
			<c:otherwise>
				<a href="<c:url value='/_02_login/login.jsp'/>">
  				登入
	           </a>
			</c:otherwise>
			</c:choose>
		</div>
	</div>

	<ul id="a-style">
		<div class="test">
			<li class="dropdown"><i class="fas fa-bullhorn"></i> <a
				href="<c:url value='#' />">論壇</a>
				<div class="dropdown-content">
					<a href="<c:url value='#' />">惡魔版</a> <a href="<c:url value='#' />">天使版</a>
				</div></li>
			<li class="dropdown "><i class="fas fa-shopping-bag"></i> <a
				href="#news">商城</a>
				<div class="dropdown-content">
					<a href="<c:url value='#' />">購物區</a> <a href="<c:url value='#' />">購物車</a>
					<a href="<c:url value='#' />">歷史訂單</a>
				</div></li>
			<li class="dropdown"><i class="fas fa-user-friends"></i> <a
				href="<c:url value='#' />">關於我們</a>
				<div class="dropdown-content">
					<a href="<c:url value='#' />">創建理念</a> <a
						href="<c:url value='#' />">團隊介紹</a> <a href="<c:url value='#' />">關於我們</a>
				</div></li>
		</div>
	</ul>

	<div class="center-content">
		<!-- 		<div class="side_menu col-2"> -->

		<div class="side_menu col-2">


			<div>
				<h3>天使</h3>
			</div>
			<div>
				<a href="<c:url value='#' />"> 書籍</a>
			</div>
			<div>
				<a href="<c:url value='#' />">紓壓小物</a>
			</div>
			<div>
				<h3>惡魔</h3>
			</div>
			<div>
				<a href="<c:url value='#' />">書籍</a>
			</div>
			<div>
				<a href="<c:url value='#' />">紓壓小物</a>
			</div>
		</div>
