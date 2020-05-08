<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<spring:url value='/css/letter/replyAngel.css' /> ">
<link rel="stylesheet" href="<spring:url value='/css/letter/nav.css' /> ">
    <script src="<spring:url value='/js/letter/forSend.js' /> "></script>
<title>Insert title here</title>
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
				<li class="nav-item mx-2"><a class="nav-link"
					href="<spring:url value='/letter/letterHome' />">漂流瓶</a></li>
				<li class="nav-item mx-2"><a class="nav-link"
					href="<spring:url value='/product/showPageProducts' />">商品列表</a></li>
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
<form action="<c:url value='/letter/sendReplyContent' /> " method="POST">
	<div class="container">
        <div class="card">
            <div class="contentBox">
                <div class="content">
                    <h4>${lb.letterTitle}</h4>
                    <br>
                    <h5>${lb.letterCategory}</h5>
                    <p>${lb.letterContent}</p>
                </div>
            </div>
            <div class="replyContentBox">
                <div class="replyContent">
                    <h2>回應內容</h2>
                    <input type="hidden" value="${lb.letterId}" name="id">
                    <p><textarea name="replyContent" id="" cols="30" rows="10" maxlength="250"></textarea></p>
                   <input type="submit" name="devil" class="btn btn-primary btn-user btn-block" role="button" id="submitbtn" value="寄出">
                </div>
            </div>
        </div>
    </div>
       </form>
       
       <!--========= footer================= -->
	<!-- Footer -->
<!-- 	<footer class="page-footer font-small stylish-color-dark pt-2"> -->
<!-- 		<!-- Footer Links --> -->
<!-- 		<div class="container text-center text-md-left mt-3"> -->
<!-- 			<!-- Grid row --> -->
<!-- 			<div class="row"> -->
<!-- 				<div -->
<!-- 					class="col-md-2 d-flex justify-content-center align-items-center"> -->
<!-- 					<img -->
<!-- 						src="https://github.com/sun0722a/yaoshula/blob/master/src/logo/logo_trans_140px.png?raw=true" -->
<!-- 						width="120px" alt="" /> -->
<!-- 				</div> -->
<!-- 				Grid column -->

<!-- 				<div class="col-md-4 mx-auto"> -->
<!-- 					Content -->
<!-- 					<h5 class="font-weight-bold text-uppercase mb-3">要抒啦！ 網路論壇&商城 -->
<!-- 					</h5> -->
<!-- 					<p id="footer-introdution" class="text-secondary"> -->
<!-- 						是個能夠預期回應溫度的論壇空間。希望在亂世間提供一個烏托邦式的空間，讓大家可以盡情釋放壓力，得到慰藉❤️。</p> -->
<!-- 					<div class="d-flex"></div> -->
<!-- 				</div> -->
<!-- 				Grid column -->

<!-- 				<hr class="clearfix w-100 d-md-none" /> -->

<!-- 				Grid column -->
<!-- 				<div class="col-md-2 mx-auto"> -->
<!-- 					Links -->
<!-- 					<h5 class="font-weight-bold text-uppercase mb-3">論壇</h5> -->

<!-- 					<ul class="list-unstyled"> -->
<!-- 						<li><a -->
<%-- 							href="<spring:url value='/article/showPageArticles?categoryTitle=天使' />">天使版</a></li> --%>
<!-- 						<li><a -->
<%-- 							href="<spring:url value='/article/showPageArticles?categoryTitle=惡魔' />">惡魔版</a></li> --%>
<%-- 						<li><a href="<spring:url value='/letter/letterHome' />">漂流信</a></li> --%>
<!-- 					</ul> -->
<!-- 				</div> -->
<!-- 				Grid column -->

<!-- 				<hr class="clearfix w-100 d-md-none" /> -->

<!-- 				Grid column -->
<!-- 				<div class="col-md-2 mx-auto"> -->
<!-- 					Links -->
<!-- 					<h5 class="font-weight-bold text-uppercase mb-3">商城</h5> -->

<!-- 					<ul class="list-unstyled"> -->
<%-- 						<li><a href="<spring:url value='/product/productHome' />">商城首頁</a></li> --%>
<%-- 						<li><a href="<spring:url value='/order/shoppingCartList' />">我的購物車</a></li> --%>
<%-- 						<li><a href="<spring:url value='/order/showHistoryOrder' />">歷史訂單</a></li> --%>
<!-- 					</ul> -->
<!-- 				</div> -->
<!-- 				Grid column -->

<!-- 				<hr class="clearfix w-100 d-md-none" /> -->

<!-- 				Grid column -->
<!-- 				<div class="col-md-2 mx-auto"> -->
<!-- 					Links -->
<!-- 					<h5 class="font-weight-bold text-uppercase mb-3">關於我們</h5> -->

<!-- 					<ul class="list-unstyled"> -->
<%-- 						<li><a href="<spring:url value='/aboutUs/contact' />">聯絡我們</a></li> --%>
<!-- 						<li><a href="#!">服務條款</a></li> -->
<!-- 						<li><a href="#!">隱私權政策</a></li> -->
<!-- 					</ul> -->
<!-- 				</div> -->
<!-- 				Grid column -->
<!-- 			</div> -->
<!-- 			<!-- Grid row --> -->
<!-- 		</div> -->

<!-- 		<!-- Copyright --> -->
<!-- 		<div class="footer-copyright text-center mt-0 pb-3" -->
<!-- 			style="font-size: 15px;">© 2020 Copyright © 2020 Speak It Up. -->
<!-- 			All rights reserved</div> -->
<!-- 		<!-- Copyright --> -->
<!-- 	</footer> -->
	<!-- Footer -->
</body>
</html>