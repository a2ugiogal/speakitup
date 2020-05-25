<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
    crossorigin="anonymous" />
     <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.0.0/animate.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@500&display=swap" rel="stylesheet">
    <link rel="shortcut icon" href="<spring:url value='/image/logo/logo_trans_92px.png' /> ">
    <link rel="stylesheet"
	href="<spring:url value='/css/register/nav.css' /> " />
	<link rel="stylesheet"
	href="<spring:url value='/css/aboutUs/createIdea.css' /> " />
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
			<!-- 			<form class="form-inline mr-5"> -->
			<!-- 				<input class="form-control mr-sm-2" type="search" id="search" -->
			<!-- 					placeholder="Search" aria-label="Search" /> -->
			<!-- 				<button class="btn d-flex justify-content-center" type="submit" -->
			<!-- 					id="search-btn">Search</button> -->
			<!-- 			</form> -->
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
					<div style="width: 170px;">
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
					aria-expanded="false">論壇 </a>
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
							aria-expanded="false">商城 </a>
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
				<li class="nav-item mx-2">
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${not empty LoginOK}"> --%>
<!-- 							<a class="nav-link" -->
<%-- 							href="<spring:url value='/letter/letterHome' />">漂流瓶</a> --%>
<%-- 						</c:when> --%>
<%-- 						<c:otherwise> --%>
							<a class="nav-link"
					href="<spring:url value='/member/login?target=/letter/letterHome&loginFilter=true' />">漂流瓶</a>
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
					
				</li>
				<li class="nav-item dropdown mx-2"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false">歡樂吧</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" style="cursor: pointer;"
							onclick="showGameModel()">掉落吧！方塊！</a>
					</div></li>
				<!-- 				<li class="nav-item mx-2"><a class="nav-link" -->
				<!-- 					style="cursor: pointer;" onclick="showGameModel()">紓壓遊戲</a></li> -->
				<c:if test="${LoginOK.permission=='管理員'}">
					<li class="nav-item dropdown mx-2"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false">管理後台 </a>
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
					aria-expanded="false">關於我們 </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="<spring:url value='/aboutUs/createIdea' />">創建理念</a> 
						<a class="dropdown-item" href="<spring:url value='/aboutUs/groupInfo' />">團隊介紹</a> 
						<a class="dropdown-item" href="<spring:url value='/aboutUs/contact' />">聯絡我們</a>
					</div></li>
			</ul>
		</div>
	</nav>
	<!-- 導覽列 -->
	<div class="mainContent animate__animated animate__fadeIn">
	
    <div class="card col-8 col-md-6 ml-2 mb-2 mt-5">
        <div class="card-header">
            <h3>創建理念</h3>
        </div>
        <div class="card-body">
          <blockquote class="blockquote mb-0">
            <p>  「要抒啦！」的理念是能夠預期回應溫度的論壇空間，想被
                拍拍誇誇來碗心靈雞湯的你請右轉「天使版」， 想來碗惡魔
                毒湯被罵醒或和鄉民講講幹話的你左轉「惡魔版」。</p>
           
          </blockquote>
        </div>
      </div>
      <div class="card col-8 col-md-6 ml-2 mb-2">
        <div class="card-header">
            <h3>功能特色</h3>論壇
        </div>
        <div class="card-body">
          <blockquote class="blockquote mb-0">
            <p class="">有別於多數論壇既定的前端設計，我們的網站想呈現的不只是一段單純文字，而是一個有溫度的世界。因此我們把每篇文章視為該作者的內心世界，留言則是外界給予他的想法，而天使版與惡魔版能將這些想法變成作者想要的能量，讓現實中的大家都能找到屬於自己的抒壓方式。</p>
          </blockquote>
        </div>
      </div>
      <div class="card col-8 col-md-6 ml-2 mb-2">
        <div class="card-header">
            <h3>功能特色</h3>商城
        </div>
        <div class="card-body">
          <blockquote class="blockquote mb-0">
            <p>商品規格是我們當初努力的重點之一，讓網站管理員可以在新增商品時任意的填寫商品規格與庫存，加入購物車也適當的加入了視覺回饋的特效，在前端的呈現上能有更直觀的使用介面。</p>
          </blockquote>
        </div>
      </div>
      <div class="card col-8 col-md-6 ml-2 mb-2">
        <div class="card-header">
            <h3>特色功能</h3>漂流瓶
        </div>
        <div class="card-body">
          <blockquote class="blockquote mb-0">
            <p> 對於寄信的人來說，希望透過匿名的方式得到最單純、真誠的回覆
                對於回信的人來說，希望在幫助別人的同時自己也獲得心靈上的滿足 
                當然啦，如果無聊想寄信、回信，我們也是OK~</p>
          </blockquote>
        </div>
    </div>
        <div class="card col-8 col-md-6 ml-2 mb-2">
            <div class="card-header">
                <h3>特色功能</h3>歡樂吧
            </div>
            <div class="card-body">
              <blockquote class="blockquote mb-0">
                <p>原本只是組員分享的有趣特效，意外變成了抒壓小遊戲，讓負面情緒得以釋放，我們希望可以把這份快樂分享給大家，散播歡樂散播愛~</p>
              </blockquote>
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
	
	 <script src="https://code.jquery.com/jquery-3.5.1.min.js"
		integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
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