<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>團隊介紹</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
    <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.0.0/animate.min.css"/>
    <link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<spring:url value='/css/aboutUs/team.css' /> ">
    <link rel="shortcut icon" href="<spring:url value='/image/logo/logo_trans_92px.png' /> ">
    <link rel="stylesheet"
	href="<spring:url value='/css/register/nav.css' /> " />
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
	
	<div class="mainContent container-fluid ">
	 <h1 class="ourteam">團隊介紹</h1>
    <div class="imgSection d-flex row align-items-center justify-content-center mb-5">
        <div class="imgBox w-50 col-xl-2 col-md-6 col-sm-12 pl-5 mt-3 mb-3" id="no1">
                <img src="<spring:url value='/image/aboutus/品睿.JPG' />" alt="" class="imgChecked">
        </div>
        <div class="imgBox w-50 col-xl-2 col-md-6 col-sm-12  pl-5 mt-3 mb-3" id="no2">
                <img src="<spring:url value='/image/aboutus/婷伃.JPG' />" alt="">
        </div>
        <div class="imgBox w-50 col-xl-2 col-md-6 col-sm-12  pl-5 mt-3 mb-3" id="no3">
                <img src="<spring:url value='/image/aboutus/于婷.JPG' />" alt="">
        </div> 
        
        <div class="imgBox w-50 col-xl-2 col-md-6 col-sm-12  pl-5 mt-3 mb-3" id="no4">
                <img src="<spring:url value='/image/aboutus/昱廷.JPG' />" alt="">
        </div>
        <div class="imgBox w-50 col-xl-2 col-md-6 col-sm-12  pl-5 mt-3 mb-3" id="no5">
                <img src="<spring:url value='/image/aboutus/泓哲.JPG' />" alt="">
        </div>
        <div class="imgBox w-50 col-xl-2 col-md-6 col-sm-12  pl-5 mt-3 mb-3" id="no6">
                <img src="<spring:url value='/image/aboutus/將軍.JPG' />" alt="">
        </div>
    </div>
    <div class="infoSection">
	    <div class="infoBox no1 animate__animated animate__zoomIn" >
	        <span class="name">曾品睿(組長)</span>
	        <span class="border"></span>
	        <p> 
	        	國立台北大學應用外語系<br>
	                                會員系統前端版面<br>
	     		UI設計      
	        </p>
	    </div>
	    <div class="infoBox no2 animate__animated animate__zoomIn">
	        <span class="name">詹婷伃 (副組長兼技術長)</span>
	        <span class="border"></span>
	        <p> 
	        	國立中央大學數學系<br>
			           論壇前端版面<br>
	                                前端工程整合<br>
	 		          資料庫設計<br>
	                                後端系統
	        </p>
	    </div>
	    <div class="infoBox no3 animate__animated animate__zoomIn">
	        <span class="name">孫于婷(被程式耽誤的編劇)</span>
	        <span class="border"></span>
	        <p>  
	        	國立中央大學數學系<br>
	        	論壇前端版面<br>
	           	前端工程整合<br>
	          	資料庫設計<br>
	          	後端系統
	        </p>
	    </div>
	    <div class="infoBox no4 animate__animated animate__zoomIn">
	        <span class="name">劉昱廷(要抒啦專業打雜)</span>
	        <span class="border"></span>
	        <p> 
	        	世新大學社會心理學系<br>
	           	 前端工程整合<br>
	           	 漂流瓶系統<br>
	           	 資料庫設計<br>
	                                  後端系統
	        </p>
	    </div>
	    <div class="infoBox no5 animate__animated animate__zoomIn">
	        <span class="name">蔡泓哲(要抒啦御用特效師)</span>
	        <span class="border"></span>
	        <p>  
	        	龍華科技大學電機工程系<br>
	           	商城系統前端版面<br>
	           	管理系統前端版面
	        </p>
	    </div>
	    <div class="infoBox no6 animate__animated animate__zoomIn">
	        <span class="name">彭淳義(要抒啦向心力博士)</span>
	        <span class="border"></span>
	        <p>   
	        	龍華科技大學電機工程系<br>
	           	聊天機器人
	        </p>
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

	<!-- ========================modal============================ -->
	<!-- Modal for subscribe-->
	<div class="modal fade" id="my-modal-subscribe" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel_sub"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel_sub">Modal title</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">...</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

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
    <script >

        $(document).ready(function () {
            //一開始預設是品叡的資料
            $('.no1').css('display','block')

            $('.imgBox').click(function(){
                var id = $(this).attr('id');
                //點的時候其他的資料隱藏
                $('.'+id).siblings().not(this).css('display','none')
                //該元素出現
                $('.' + id).css('display','block')
                $(this).find('img').addClass('imgChecked')
                //在點擊狀態時保持放大一點的狀態
                $(this).siblings().find('img').removeClass('imgChecked').css('transition','0.5s')
                
            })
        });

    </script>
</body>
</html>