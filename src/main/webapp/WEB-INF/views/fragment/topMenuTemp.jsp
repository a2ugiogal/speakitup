<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/topMenu.css" />
<c:set var='debug' value='true' scope='application' />
<div class="top_area">
	<div class="logo">
		<a href=""> <img
			src="${pageContext.request.contextPath}/webImage/heart.png" alt="">
		</a>
	</div>
	<div class="login">
		<a href=""> <span>登入</span>
		</a>
	</div>

</div>
<div class="top">
	<ul class="main_menu">
		<li class="main_menu_li"><a href=""> <img
				src="${pageContext.request.contextPath}/webImage/home.png">論壇
		</a>
			<ul class="item_menu">
				<li><a href="<c:url value='/index.jsp' />">天使</a></li>
				<li><a href="">惡魔</a></li>
				<li><a></a></li>
			</ul></li>

		<li class="main_menu_li"><a href=""> <img
				src="${pageContext.request.contextPath}/webImage/market.png">商城
		</a>
			<ul class="item_menu">
				<li><a href="">購物區</a></li>
				<li><a href="">購物車</a></li>
				<li><a href="">歷史訂單</a></li>
			</ul></li>
		<li class="main_menu_li"><a href=""> <img
				src="${pageContext.request.contextPath}/webImage/about.png"
				style="margin-right: 2px;">關於我們
		</a>
			<ul class="item_menu">
				<li><a href="">創建理念</a></li>
				<li><a href="">團隊介紹</a></li>
				<li><a href="">關於我們</a></li>
			</ul></li>
	</ul>
</div>