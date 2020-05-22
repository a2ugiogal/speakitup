<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link
	href='https://cdn.jsdelivr.net/npm/boxicons@2.0.5/css/boxicons.min.css'
	rel='stylesheet'>
	<link rel="shortcut icon" href="<spring:url value='/image/logo/logo_trans_92px.png' /> ">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@500&display=swap" rel="stylesheet">
    <link rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.0.0/animate.min.css"/>
    <link rel="stylesheet" href="<spring:url value='/css/letter/sendAngel.css' /> ">
    <link rel="stylesheet" href="<spring:url value='/css/letter/nav.css' /> ">
<link rel="stylesheet" href="<spring:url value='/css/letter/leaves.css' /> ">

<title>寄封天使信</title>
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
	
<div class="mainContainer">
            <div class="content animate__animated">
                <!-- <h2>信件主題:天使</h2> -->
                <form action ="<spring:url value='/letter/sendAngel' />" method="POST" id="letterForm">
                    <div class="letterInput">
                        <input type="text" name="title" required="" autocomplete="off">
                        <label>信件標題</label>
                        <span></span>
                    </div>
                    <div class="letterText">
                        <textarea name="letterContent" cols="25" rows="10" id="letterContent" 
                                maxlength="250"  required=""></textarea>
                        <label>抒發點什麼吧<small>(限250個字)</small></label>
                        <span></span>
                    </div>
                    <div id="sendBtnDiv">
                    	<input class="sendBtn" type="submit" role="button" value="寄出" name=""  >
                    </div>
                 </form>
                </div>
                <div class="letterBoxArea">
	                <div class="fakeLetter animate__animated"></div>
	                <div class="letterBox"> 
	                	<img src="<spring:url value='/image/letter/letterBox2.png' /> " >
	                </div>
                </div>
            </div>
        	


      	
      <section class="leavesDiv">
         <div class="set">
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
         </div>
        <div class="set set2">
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
         </div>
        <div class="set set3">
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
             <div><img src="<spring:url value='/image/letter/flower.png' /> " ></div>
         </div>
     </section>
<!-- </div>	 -->
 <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
	    <script src="<spring:url value='/js/letter/sendLetters.js' /> "></script>
</body>
</html>