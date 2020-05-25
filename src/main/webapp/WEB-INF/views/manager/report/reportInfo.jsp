<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>文章檢舉內容--要抒啦管理員</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
	<link rel="shortcut icon" href="<spring:url value='/image/logo/logo_trans_92px.png' /> ">
<!-- 載入 Bootstrap 的CSS -->
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.4.1/cerulean/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-LV/SIoc08vbV9CCeAwiz7RJZMI5YntsH8rGov0Y2nysmepqMWVvJqds6y0RaxIXT"
	crossorigin="anonymous" />
<link rel="stylesheet"
	href="<spring:url value='/css/manager/reportInfo.css' />">
<link rel="stylesheet"
	href="<spring:url value='/css/manager/nav.css' />">
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
						<a class="dropdown-item" href="<spring:url value='/aboutUs/createIdea' />">創建理念</a> <a
							class="dropdown-item" href="<spring:url value='/aboutUs/groupInfo' />">團隊介紹</a> <a class="dropdown-item"
							href="<spring:url value='/aboutUs/contact' />">聯絡我們</a>
					</div></li>
			</ul>
		</div>
	</nav>
	<!-- 導覽列 -->


	<div class="p-5" id="pageBg">
		<!-- 檢舉頁面 -->
		<div class="row reportInfo_title m-0 p-5">
			<!-- <div class="col-1"></div> -->
			<div class="col-lg-12 col-xl-6 pt-5">
				<!-- 左上區 -->
				<div class="py-4 pl-4 row mx-auto contentBox">
					<c:choose>
						<c:when test="${cmd=='article'|| cmd=='deleteArticle'}">
							<img
								src="<spring:url value='/member/getUserImage/${article.authorId}'/> "
								class="rounded-circle border border-dark"
								style="float: left; height: 100px; width: 100px;">
							<div
								class="ml-5 my-auto d-flex flex-column justify-content-around"
								style="float: left; height: 100%;">
								<div class="py-1">帳號：${article.authorName}</div>
								<div>
									<fmt:formatDate value="${article.publishTime}"
										pattern="yyyy-MM-dd HH:mm" />
								</div>
								<div class="py-1">
									愛心：${article.likes}
									<div class="py-1">
										留言數：
										<c:choose>
											<c:when test="${not empty article.articleComments}">
												<c:forEach var="comments" items="${article.articleComments}"
													varStatus="number">
													<c:if test="${number.last}">${number.count}</c:if>
												</c:forEach>
											</c:when>
											<c:otherwise>0</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<img
								src="<spring:url value='/member/getUserImage/${comment.authorId}'/>"
								class="rounded-circle border border-dark"
								style="float: left; height: 100px; width: 100px;">
							<div
								class="ml-5 my-auto d-flex flex-column justify-content-around"
								style="float: left; height: 100%;">
								<div class="py-1">帳號：${comment.authorName}</div>
								<div>
									<fmt:formatDate value="${comment.publishTime}"
										pattern="yyyy-MM-dd HH:mm" />
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</div>

				<!-- 左下區 -->
				<div class=" my-5 mx-auto contentBox" style="width: 100%;">
					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th scope="col" class="text-center text_title1">檢舉內容</th>
								<th scope="col" class="text-center text_title1">檢舉人數</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row" class="text-center text_title2">惡意洗版</th>
								<td class="text-center">${item0}</td>
							</tr>
							<tr>
								<th scope="row" class="text-center text_title2">惡意攻擊他人</th>
								<td class="text-center">${item1}</td>
							</tr>
							<tr>
								<th scope="row" class="text-center text_title2">包含色情、血腥等，令人不舒服之內容</th>
								<td class="text-center">${item2}</td>
							</tr>
							<tr>
								<th scope="row" class="text-center text_title2">包含廣告、商業宣傳之內容</th>
								<td class="text-center">${item3}</td>
							</tr>
							<tr>
								<th scope="row" class="text-center text_title2">與本板主題無關</th>
								<td class="text-center">${item4}</td>
							</tr>
						</tbody>
					</table>
				</div>

				<!--留言區 -->
				<c:if test="${cmd == 'comment'|| cmd == 'deleteComment'}">
					<div class="my-5 py-4 pl-4 mx-auto"
						style="background: rgba(255, 255, 255, 0.438);">
						<div class="text_title3 pl-2">留言：</div>
						<div class="pt-3 pl-5 text_title2">${comment.content}</div>
						<div class="row button_button pt-4 pb-3">
							<c:if test="${cmd == 'comment'}">
								<div
									class="col-6 d-flex justify-content-center align-items-center my-2 button_button1">
									<a href="<c:url value='/article/deleteArticle/${cmd}/${id}'/>">
										<button>刪除</button>
									</a>
								</div>
								<div
									class="col-6 d-flex justify-content-center align-items-center my-2 button_button2">
									<a href="<c:url value='/article/reserveArticle/${cmd}/${id}'/>"><button>保留</button></a>
								</div>
							</c:if>
						</div>
					</div>
				</c:if>

			</div>
			<div class="col-lg-12 col-xl-6 pt-5" style="width: 550px;">
				<!-- 右 -->
				<div class=" mb-2 px-1 contentBox">
					<div
						class="w-100 pb-2 pt-5 d-flex align-items-center justify-content-between">
						<div class="text_title3 pl-5">${article.title}</div>
						<div class="text_title2 pr-5" style="float: right;">
							<span class="badge mr-2 text-white"
								<c:choose>
									<c:when test="${article.category.categoryTitle=='惡魔'}">
										style="background-color: #005caf;"
									</c:when>
									<c:otherwise>
										style="background-color: pink;"
									</c:otherwise>
								</c:choose>>${article.category.categoryTitle}</span>
							<span
								<c:choose>
									<c:when test="${article.category.categoryName=='工作'}">
										class="badge badge-info mr-2"
									</c:when>
									<c:when test="${article.category.categoryName=='感情'}">
										class="badge badge-danger mr-2"
									</c:when>
									<c:when test="${article.category.categoryName=='生活'}">
										class="badge badge-warning mr-2"
									</c:when>
									<c:otherwise>
										class="badge badge-secondary mr-2"
									</c:otherwise>
								</c:choose>>${article.category.categoryName}</span>
						</div>
					</div>

					<div class="px-4 pb-2">
						<div class="py-5" style="text-align: center;">
							<img
								<c:if test="${not empty article.image}">src="<spring:url value='/article/getArticleImage/${article.articleId}' />"</c:if>
								style="max-width: 500px; max-height: 220px;">
						</div>
						<div class="px-4 py-3 text_title2"
							style="clear: both; overflow: auto; height: 500px;">${content}</div>
						<div
							class="col-8 d-flex justify-content-center align-items-center my-3"></div>
					</div>


					<c:if test="${cmd=='article'|| cmd=='deleteArticle'}">
						<div class="row button_button pb-3">
							<c:if test="${cmd=='article'}">
								<div
									class="col-6 d-flex justify-content-center align-items-center my-2 button_button1">
									<a href="<c:url value='/article/deleteArticle/${cmd}/${id}'/>">
										<button>刪除</button>
									</a>
								</div>
								<div
									class="col-6 d-flex justify-content-center align-items-center my-2 button_button2">
									<a href="<c:url value='/article/reserveArticle/${cmd}/${id}'/>">
										<button>保留</button>
									</a>
								</div>

							</c:if>
						</div>
					</c:if>

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

	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
		integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
		integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
		crossorigin="anonymous"></script>
	<!-- icon -->
	<script src="https://kit.fontawesome.com/041970ba48.js"
		crossorigin="anonymous"></script>
	<!-- 	<script -->
	<%-- 		src="<spring:url value='/js/article/articleContext.js' /> "></script> --%>

</body>
</html>