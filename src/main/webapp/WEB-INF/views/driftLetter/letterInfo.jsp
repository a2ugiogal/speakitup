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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
    <link rel="stylesheet" href="<spring:url value='/css/letter/info.css' /> ">
    <link rel="stylesheet" href="<c:url value='/css/letter/nav.css' /> ">
    <link rel="stylesheet" href="<c:url value='/css/letter/countdown.css' /> ">
    <link rel="shortcut icon" href="<spring:url value='/image/logo/logo_trans_92px.png' /> ">
<title>歡迎來到漂流瓶專區</title>
</head>
<c:choose>
	<c:when test="${not empty noLettersDevil}">
		<script>
			alert("目前沒有惡魔信件可以回!試試看天使信件ㄅ")
		</script>
		<%
			session.removeAttribute("noLettersDevil");
		%>
	</c:when>
	<c:when test="${not empty noLettersAngel}">
		<script>
			alert("目前沒有天使信件可以回!試試看惡魔信件ㄅ")
		</script>
		<%
			session.removeAttribute("noLettersAngel");
		%>
	</c:when>
</c:choose>
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
				height="50px" /> 要抒啦
			</a>
		</div>
		<div class="navbar-nav flex-row ml-auto"
			style="position: absolute; right: 250px; top: 10px;">
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
	<!-- 導覽列 -->
	<div class="container-fluid mainContent">
        <div class="info_img">
            <img src="<spring:url value='/image/letter/undraw_delivery_address_03n0.svg '/> " >
        </div>

        <div class="intro-container">
                <div>
                	<c:if test="${! empty sendError || ! empty replyError}" >
                	<h2 style="width:350px;">  距離下次更新時間</h2>
                		<div style="width:350px;font-size:18px; margin-bottom:10px;">
		                	<i class="fas fa-arrow-down"></i>
							<i class="fas fa-arrow-down"></i>
							<i class="fas fa-arrow-down"></i>
							<i class="fas fa-arrow-down"></i>
							<i class="fas fa-arrow-down"></i>
							<i class="fas fa-arrow-down"></i>
							<i class="fas fa-arrow-down"></i>
							<i class="fas fa-arrow-down"></i>
							<i class="fas fa-arrow-down"></i>
							<i class="fas fa-arrow-down"></i>
							<i class="fas fa-arrow-down"></i>
							<i class="fas fa-arrow-down"></i>
							<i class="fas fa-arrow-down"></i>
							<i class="fas fa-arrow-down"></i>
							<i class="fas fa-arrow-down"></i>
						</div>
                	<div class="countdown">
				        <div id="hour"></div>        
				        <div id="minute"></div>        
				        <div id="second"></div>        
    				</div>
    				</c:if>			
                <div class="formTop">	
                    <h1>漂流信專區</h1>
                </div>
                <ul>
                    <li>會員每日可選擇寄一封信及回一封信</li>
                    <li>保證只會有一個人看到你的煩惱或回覆。</li>
                    <li>可以從會員信箱看到自己曾經寄過的完整信件。</li>
                    <li>可選擇該信件的主題(天使or惡魔)</li>
                    <li>每天中午十二點刷新寄信與回信的扣打</li>
                </ul>
            <div class="btnGroup">

            	<c:choose>
            		<c:when test="${! empty sendError}">
            			<div class="btnError">我想寄信</div>
            		</c:when>
            		<c:otherwise>
            			<a href="<spring:url value='/letter/send' /> "><div class="btn" >我想寄信</div></a>
            		</c:otherwise>
            	</c:choose>
            	
           		<c:choose>
            		<c:when test="${! empty replyError}">
            			<div class="btnError">我想回信</div>
            		</c:when>
            		<c:otherwise>
            			<a href="<spring:url value='/letter/reply' /> "><div class="btn" >我想回信</div></a>
            		</c:otherwise>
            	</c:choose>	     
               	<a href="<spring:url value='/letter/myLetters' /> "><div class="btn" >我的信箱</div>
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
		<script src="<spring:url value='/js/letter/letterInfo.js' /> " ></script>
</body>
</html>