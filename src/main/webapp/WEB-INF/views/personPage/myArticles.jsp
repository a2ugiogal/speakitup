<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>我的文章--要抒啦</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<link href="https://unpkg.com/boxicons@2.0.5/css/boxicons.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="<spring:url value='/css/personPage/myArticles.css' /> " />
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
			style="position: absolute; right: 250px; top: 10px;"></div>
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
				<c:choose>
					<c:when test="${empty LoginOK}">
						<li class="nav-item mx-2"><a class="nav-link"
							href="<spring:url value='/product/productHome' />">商城</a></li>
					</c:when>
					<c:otherwise>
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
					</c:otherwise>
				</c:choose>
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

	<!-- 置頂按鈕 設定 -->
	<a href="#top"> <img id="myBtn"
		src="https://png.pngtree.com/png-clipart/20190705/original/pngtree-vector-up-arrow-icon-png-image_4272127.jpg" />
	</a>
	<!-- 置頂按鈕 設定 -->

	<!-- ======main=======文章列表從這裡開始 -->
	<div id="bg-color">
		<div id="article-area-title"
			class="h1 mb-4 d-flex justify-content-center"
			style="padding-top: 110px;">
			<strong>我的文章列表</strong>
		</div>

		<!-- 文章列表 -->
		<section id="nayma-timeline" class="nayma-container mx-auto mt-2 pt-3">
			<div class="d-flex" style="margin: 0px -15px 0px 60px">
				<!-- 搜尋欄 -->
				<div class="wrap mr-2 shadow">
					<div class="search">
						<input type="search" class="searchTerm p-2" id="search"
							placeholder="搜尋: 文章標題" />
						<button type="submit" class="searchButton" id="searchBtn"
							style="height: 46px">
							<i class="bx bx-search"></i>
						</button>
					</div>
				</div>
				<!-- 排序選項 -->
				<div class="btn-group shadow" id="filter-btn">
					<button id="by-date" type="button" class="btn text-white arrange"
						value="time" style="background-color: #005caf;">
						依日期<i class="bx bx-calendar-star ml-1"></i>
					</button>
					<button id="by-popular" type="button"
						class="btn text-white arrange" value="popular"
						style="background-color: #005caf;">
						依熱門<i class="bx bxs-hot ml-1"></i>
					</button>
				</div>
			</div>
			<!-- 這是一組開始 -->
			<div id="article_list" class="mt-4">
				<c:forEach var="entry" items="${articles_map}" varStatus="number">
					<div class="nayma-timeline-block"
						<c:if test="${number.first}">id="top_article"</c:if>>
						<!-- 藍色點點 -->
						<div class="nayma-timeline-img"></div>
						<a
							href="<spring:url value='/article/showArticleContent/${entry.key.articleId}'/>"
							style="text-decoration: none;"> <!-- 白色對話框 -->
							<div class="row nayma-timeline-content">
								<!-- 使用者頭貼 -->
								<div
									class="col-2 d-flex align-items-center justify-content-center">
									<img
										src="<spring:url value='/member/getUserImage/${LoginOK.id}' />"
										class="rounded-circle" width="150px" height="150px"
										alt="avatar" />
								</div>
								<!-- 文章詳情 -->
								<div class="col-8">
									<!-- 文章標題 -->
									<h2 class="mt-2">${entry.key.title}</h2>
									<!-- 文章分類 -->
									<span class="badge mr-2 mt-1 text-white"
										<c:choose>
									<c:when test="${entry.key.category.categoryTitle=='惡魔'}">
										style="background-color: #005caf;"
									</c:when>
									<c:otherwise>
										style="background-color: pink;"
									</c:otherwise>
								</c:choose>>${entry.key.category.categoryTitle}</span>
									<span
										<c:choose>
									<c:when test="${entry.key.category.categoryName=='工作'}">
										class="badge badge-info mr-2 mt-1"
									</c:when>
									<c:when test="${entry.key.category.categoryName=='感情'}">
										class="badge badge-danger mr-2 mt-1"
									</c:when>
									<c:when test="${entry.key.category.categoryName=='生活'}">
										class="badge badge-warning mr-2 mt-1"
									</c:when>
									<c:otherwise>
										class="badge badge-secondary mr-2 mt-1"
									</c:otherwise>
								</c:choose>>${entry.key.category.categoryName}</span>
									<!-- 文章內容預覽 -->
									<p class="JQellipsis" style="color: #212529">${entry.value}</p>
									<!-- 文章資訊列 -->
									<div class="row d-flex align-items-center mb-2">
										<!-- 發表日期 -->
										<p class="my-0 col-4 text-secondary">
											發表於
											<fmt:formatDate value="${entry.key.publishTime}"
												pattern="yyyy-MM-dd" />
										</p>
										<!-- 愛心數 -->
										<i class="my-0 p-0 h5 bx bx-heart-circle col-1 text-danger"><span
											class="h6 ml-1 text-secondary"><i>${entry.key.likes}</i></span></i>
										<!-- 留言數 -->
										<i class="my-0 p-0 h5 bx bx-message-detail col-1 text-info"><span
											class="h6 ml-1 text-secondary"><i> <c:choose>
														<c:when test="${not empty entry.key.articleComments}">
															<c:forEach var="comments"
																items="${entry.key.articleComments}" varStatus="number">
																<c:if test="${number.last}">${number.count}</c:if>
															</c:forEach>
														</c:when>
														<c:otherwise>0</c:otherwise>
													</c:choose></i></span></i>
									</div>
								</div>
								<!-- 文章照片 -->
								<div
									class="col-2 d-flex align-items-center justify-content-center">
									<c:if test="${not empty entry.key.image}">
										<img
											src="<spring:url value='/article/getArticleImage/${entry.key.articleId}' /> "
											class="" width="145px" height="145px" />
									</c:if>
								</div>
							</div>
						</a>
					</div>
				</c:forEach>
				<!-- 這是一組結束 -->
			</div>
		</section>
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
	<script src="<spring:url value='/js/personPage/myArticle.js' /> "></script>
</body>
</html>