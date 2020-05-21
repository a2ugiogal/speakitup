<!DOCTYPE html>
<html lang="en">
<head>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8" />
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous" />

<link rel="stylesheet" href="<spring:url value='/css/index.css' /> " />
<link rel="stylesheet" href="<spring:url value='/css/bot.css' /> " />
<link rel="stylesheet"
	href="<spring:url value='/css/register/nav.css' /> " />
<title>首頁--要抒啦</title>
<c:if test="${not empty verifyAlert}">
	<script>
		alert("請前往信箱驗證");
	</script>
	<%
		session.removeAttribute("verifyAlert");
	%>
</c:if>

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
				<li class="nav-item mx-2"><a class="nav-link"
					href="<spring:url value='/letter/letterHome' />">漂流瓶</a></li>
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
						<a class="dropdown-item" href="#">創建理念</a> <a
							class="dropdown-item" href="#">團隊介紹</a> <a class="dropdown-item"
							href="<spring:url value='/aboutUs/contact' />">聯絡我們</a>
					</div></li>
			</ul>
		</div>
	</nav>
	<!-- 導覽列 -->

	<!-- 聊天機器人 -->

	<button class="open-button open-button:after" onclick="openForm()" style="background-image: url('<spring:url value="/image/logo/logo_trans_92px.png "/> '); background-size: 50px 50px;">
	</button>
	<!-- 彈出視窗+視窗大小 -->
	<div class="chat-popup es_bg" id="myForm">
		<div class="form-container">
			<!-- 藍條+關閉紐 -->
			<span class="blue-bar"></span>
			<button type="button" class="btn cancel" onclick="closeForm()">✖</button>
			<!-- 聊天框+邊距15px-->
			<div id="dialogBox" class="dialogBox">
				<div style="margin: 0px">
					<!--開頭============================= -->
					<div class="es_service">
						<!-- 客服頭像 -->
						<div class="es_headBox">
							<div class="es_head"></div>
							<span class="es_botName">智能客服</span>
						</div>
						<!-- 對話 -->
						<div class="es_scBox">
							<div class="es_scTxt">
								你好，我是 <span style="color: blue;">要抒拉智能客服</span> ，任何問題都可以問我哦!
							</div>
							<!-- 卡片=======================================-->
							<div class="es_scTxt">
								<a href="https://world.taobao.com/item/523235463919.htm"
									target="_blank" style="text-decoration: none;"> <img
									class="card__cover" src="<spring:url value='/product/getProductImage/2' />">
									<div class="card__description">2020要抒拉論壇高人氣吉祥物玩偶，戽斗星球玩偶！</div>
									<div class="card__btn-link">
										<span>點擊前去看看 >></span>
									</div>
								</a>
							</div>

							<div class="es_scTxt">
								<a
									href="https://store.line.me/stickershop/product/12999/zh-Hant"
									target="_blank" style="text-decoration: none;"> <img
									class="card__cover" src="<spring:url value='/product/getProductImage/42' />">
									<div class="card__description">
										2020要抒拉論壇票選人氣最高紓壓商品！超大Enter鍵！</div>
									<div class="card__btn-link">
										<span>點擊前去看看 >></span>
									</div>
								</a>
							</div>
							<!-- 卡片=============================-->
						</div>
					</div>
					<!--開頭============================= -->
				</div>
			</div>
			<div style="margin-top:5px;">
				<!-- 按enter回答 -->
				<input id="say" name="say" type="text" value=""
					onkeydown="keyin(event)" placeholder="寫點什麼.."
					style="font-size: 13.3333px;" />
				<!-- 箭頭按鈕 -->
				<input type="image" src="https://i.imgur.com/bpUnSvu.png"
					id="send-button" alt="submit" onclick="say()" />
			</div>
		</div>
	</div>

	<!-- 聊天機器人 -->

	<!-- 置頂按鈕 設定 -->
	<a href="#top"> <img id="myBtn"
		src="https://png.pngtree.com/png-clipart/20190705/original/pngtree-vector-up-arrow-icon-png-image_4272127.jpg" />
	</a>
	<!-- 置頂按鈕 設定 -->
	<!-- ======= Index Section ======= -->
	<div id="index"
		style="background:url('<spring:url value="/image/index/home.png" />');">

		<div class="content text-center d-flex align-items-center">
			<!-- title ============-->
			<div class="row">
				<div class="mx-auto typewriter">
					<h1 id="eyesNo">上網紓壓，你無須看人臉色</h1>
				</div>

				<!-- sub title ===============-->
				<div class="mt-5">
					<h2 id="listenYouWant" style="visibility: hidden;">
						在要抒啦，聽你想聽的 <span id="smile">:)</span>
					</h2>
				</div>
			</div>
		</div>
	</div>
	<main id="main">
		<!-- ======= About Section ======= -->
		<section id="about" class="about">
			<div class="container">
				<div class="section-title">
					<h2>論壇簡介</h2>
					<h3>
						惡魔版v.<span>s.天使版</span>
					</h3>
					<p>以下哪個對話讓你感到舒壓？</p>
				</div>

				<div class="row content">
					<div class="col-lg-6 col-12 pt-4 pt-lg-0"
						style="padding: 0px 50px;">
						<div
							style="margin-left: auto; width: fit-content; position: relative;"
							id="left-content">
							<p>
								<strong>你</strong>：花了八萬五來學程式，但我什麼也沒學會，<br />沒車沒防沒技能沒工作沒女友沒未來，我的人生好失敗><<br />
								<strong>友</strong>：八萬五丟水溝啦！你就爛，我也爛 <i class="bx bx-like"></i>
							</p>

							<p style="margin-bottom: 130px;">
								喜歡和朋友一起講幹話、笑看人生的你，<br /> 適合到<strong>惡魔版</strong>，來點負能量，全身都舒爽。
							</p>
						</div>
						<a
							href="<spring:url value='/article/showPageArticles?categoryTitle=惡魔' />"
							class="btn-learn-more d" style="margin-bottom: auto;">前往惡魔版<i
							class="bx bx-upside-down mt-1"></i></a>
					</div>

					<div class="col-lg-6 col-12 pt-4 pt-lg-0"
						style="padding: 0px 50px;">
						<p>
							<strong>妳</strong>：交往九年的對象，一直以為他是深情暖男，<br />沒想到背著我在外約了無數女生，毅然決然分手並公布他的事蹟...<br />
							<strong>友</strong>：拍拍妳，妳真的好勇敢，辛苦妳了<i class="bx bx-donate-heart"></i>
						</p>
						<p>
							在<strong>天使版</strong>，吐吐苦水後來碗心靈雞湯，<br />
							接受來自四面八方網友的溫情拍拍，讓你重新暖起來。
						</p>
						<a
							href="<spring:url value='/article/showPageArticles?categoryTitle=天使' />"
							class="btn-learn-more">前往天使版<i class="bx bx-smile mt-1"></i></a>
					</div>
				</div>
			</div>
		</section>
		<!-- End About Section -->
	</main>

	<!-- ======= signup Section ======= -->
	<div id="plug">
		<div class="content flex-column d-flex align-items-center">
			<!-- title ============-->
			<div class="row">
				<div class="col-12">
					<h1 class="mb-3">現在加入！</h1>
				</div>
				<div class="col-12">
					<h2 class="mb-4">為你的生活充電⚡</h2>
				</div>
				<div class="col-12">
					<a id="to-register" class="btn btn-lg btn-light"
						href="<spring:url value='/member/register' />">還沒有帳號？立即註冊！</a>
				</div>
			</div>
		</div>
	</div>

	<!-- ======= Services Section ======= -->
	<section id="services" class="services">
		<div class="container">
			<div class="section-title" style="padding-bottom: 50px;">
				<h2>熱門話題</h2>
				<h3 id="hotTitle">
					What's <span>HOT</span> now?
				</h3>
				<p>馬上加入現在最夯的話題吧！</p>
			</div>

			<div class="container">
				<div class="row">
					<div class="col-12 col-md-3 mt-4">
						<div class="card">
							<img src="https://i.imgur.com/VJKZHvV.png" class="card-img-top"
								alt="..." />
							<div class="card-body">
								<h5 class="card-title">是兩條線><</h5>
								<p class="card-text">
									生理期沒來，朋友今天陪我去藥局，結果...該怎麼辦？我才16歲..不想當媽媽><</p>
								<a
									href="<spring:url value='/article/showPageArticles?categoryTitle=天使' />"
									class="btn btn-danger">前往天使板</a>
							</div>
						</div>
					</div>

					<div class="col-12 col-md-3 mt-4">
						<div class="card">
							<img src="https://i.imgur.com/ohWljoL.jpg" class="card-img-top"
								alt="..." />
							<div class="card-body">
								<h5 class="card-title">傳說中的豹紋口罩@@</h5>
								<p class="card-text">天還沒亮就去排隊90分鐘，打開一看，ㄍ...阿中你說我出門到底該戴還是不戴？
								</p>
								<a
									href="<spring:url value='/article/showPageArticles?categoryTitle=惡魔' />"
									class="btn btn-light border-dark">前往惡魔板</a>
							</div>
						</div>
					</div>

					<div class="col-12 col-md-3 mt-4">
						<div class="card">
							<img src="https://i.imgur.com/rzG8sTR.png" class="card-img-top"
								alt="..." />
							<div class="card-body">
								<h5 class="card-title">熱銷*南歐薰衣草精油*</h5>
								<p class="card-text">來了來了！來自歐洲的氣息~吸上兩口一夜好眠，限時特惠只要5555元！</p>
								<a href="<spring:url value='/product/productHome' />"
									class="btn btn-danger">前往商城</a>
							</div>
						</div>
					</div>

					<div class="col-12 col-md-3 mt-4">
						<div class="card">
							<img src="https://i.imgur.com/1SZdxCi.png" class="card-img-top"
								alt="..." />
							<div class="card-body">
								<h5 class="card-title">昱廷の漂流世界</h5>
								<p class="card-text">隨意拾起一個陌生人的美麗與哀愁，或與他共鳴、或給他幾句問暖的隻字片語...</p>
								<a href="<spring:url value='/letter/letterHome' />"
									class="btn btn-light border-dark">前往漂流瓶</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- End Services Section -->
	<!--================= subscribe================= -->
	<div class="bg-warning text-center pt-5">
		<div
			class="text-center bg-warning d-flex flex-column justify-content-center align-items-center">
			<img src="<spring:url value='/image/index/subscribe.jpg' />"
				width="400px" alt="" />

			<p class="mb-3">不想錯過任何有趣的話題？這就訂閱我們的電子報，還有超優惠折價券送給你！</p>
			<div class="input-group d-flex justify-content-center pb-5 w-25">
				<input id="subscribe-email" type="email" class="form-control"
					placeholder="Enter your email here" required />
				<div class="input-group-append">
					<button class="btn btn-secondary" id="btn-to-subscribe"
						type="submit">訂閱</button>
				</div>
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

	<!-- 遊戲浮動視窗============================= -->
	<div class="modal fade" id="gameModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header pb-0">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="">
						<span>×</span>
					</button>
				</div>

				<form action="<spring:url value='/game'/>">
					<div class="modal-body">
						<p class="h3 ml-3 mb-5">請選擇難度</p>
						<div id="rangeValue" class="ml-4 mb-2" style="font-size: 20px"></div>
						<input type="range" min="5" max="55" value="30" id="range"
							name="range" class="ml-4" onmousemove="changeValue()">
						<p class="d-flex justify-content-center mt-5">
							<button type="submit"
								class="btn btn-light close rounded-circle p-3"
								style="border: 3px solid #343a40">GO!</button>
						</p>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function showGameModel() {
			$("#gameModal").modal("show");
			changeValue();
		}
		function changeValue() {
			$("#rangeValue")
					.text($("#range").val() + ' X ' + $("#range").val());
		}
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
	<script src="<spring:url value='/js/index.js' />"></script>
	<script src="<spring:url value='/js/robot/bot.js' />"></script>
	<script src="<spring:url value='/js/robot/qaList.js' />"></script>
	<script src="<spring:url value='/js/robot/user.js' />"></script>
</body>
</html>
