<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
   <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@500&display=swap" rel="stylesheet">
    <link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous" />
	<link rel="shortcut icon" href="<spring:url value='/image/logo/logo_trans_92px.png' /> ">
    <link rel="stylesheet" href="<spring:url value='/css/letter/reply.css' /> ">
    <link rel="stylesheet" href="<spring:url value='/css/letter/nav.css' /> ">
    <script src="<spring:url value='/js/letter/sendReply.js' /> " ></script>
<title>回信</title>
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
				height="50px" /> 要抒啦
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
						<a class="dropdown-item" href="<spring:url value='/aboutUs/createIdea' />">創建理念</a> <a
							class="dropdown-item" href="<spring:url value='/aboutUs/groupInfo' />">團隊介紹</a> <a class="dropdown-item"
							href="<spring:url value='/aboutUs/contact' />">聯絡我們</a>
					</div></li>
			</ul>
		</div>
	</nav>
	<div class="midSpace"></div>
	 <div class="mainContent">
        <div class="box">
            <div class="imgBox">
                <img class="happyImg" src="<spring:url value='/image/letter/replyAngel2.png' /> " >
            </div>
            <div class="contentBoxHappy">
                <div>
                    <h2 style="text-align: center;">撈取天使信<i class="far fa-envelope"></i></h2>
                    <br>
                    <p>
                        透過撈取此信箱的信來幫助那些生活遇到瓶頸、想要得到溫暖的人，注意，當選擇了天使區，只能給予正面的回饋，散發正能量來幫助他人，
                        對方可在讀取完回信後給予評價，系統會依照負面評價的多寡來管理會員，如果對方滿意您的回覆當然也能夠獲得正面的評價，
                        所以請依照興趣慎選想要的幫助的人!
                    </p>

                    <a class="angelA" href="<spring:url value='/letter/replyLetters/天使' /> " >點擊進入<i class="fas fa-sign-in-alt"></i></a>
                </div>
            </div>
        </div>
        <div class="box">
            <div class="imgBox">
                <img class="sadImg" src="<spring:url value='/image/letter/sendDark.png' /> " >
            </div>
            <div class ="contentBoxSad">
                <div>
                    <h2 style="text-align: center;">撈取惡魔信<i class="far fa-envelope"></i></h2>
                    <br>
                    <p>聽膩俗套的鼓勵時，可以選擇寄封惡魔漂流信，對方會給予負面的回饋及滿滿的負能量，
			                        並不是說對方可以進行人生攻擊式的回覆，而是透過負面又詼諧的方式讓寄信者得到前所未有的感受，或許此類型
			                        的回覆能使您對挑戰一笑置之，給予當頭棒喝讓您能繼續向前，得到回覆後也可以依照對方的內容給予評價，
			                        讓我們能更致力於維護惡魔區所帶來的負能量，讓你重拾信心或是失去信心(?)，繼續面對下一個跳戰
                    </p>
                    <a class="darkA" href="<spring:url value='/letter/replyLetters/惡魔' /> " >點擊進入<i class="fas fa-sign-in-alt"></i></a>
                </div>
                
                
            
            </div>
        </div>
	</div>
</body>
</html>