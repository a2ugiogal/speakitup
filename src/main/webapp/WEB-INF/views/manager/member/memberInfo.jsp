<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>要抒啦管理員--文章檢舉內容</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.4.1/cerulean/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-LV/SIoc08vbV9CCeAwiz7RJZMI5YntsH8rGov0Y2nysmepqMWVvJqds6y0RaxIXT"
	crossorigin="anonymous" />
<link rel="stylesheet"
	href="<spring:url value='/css/manager/memberInfo.css' />" />
<link rel="stylesheet"
	href="<spring:url value='/css/manager/nav.css' />" />
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


	<div class="pb-5" id="pageBg">
		<div style="height: 60px;"></div>
		<div class="w-75 my-5 mx-auto p-4">
			<div class="my-4 border border-dark px-4 contentBox"
				style="position: relative; border: 1px solid rgba(0, 0, 0, 0.575); border-radius: 0.5em;">
				<div class="row m-0 d-flex py-3">
					<div
						class="col-lg-4 col-xl-2 py-2 mb-2 d-flex align-items-center justify-content-center">
						<img src="<spring:url value='/member/getUserImage/${mb.id}'/>"
							class="rounded-circle border"
							style="width: 100px; height: 100px;" />
					</div>
					<div
						class="col-lg-6 col-xl-3 d-flex flex-column justify-content-around py-2">
						<div>帳號：${mb.memberId}</div>
						<div>權限：${mb.permission}</div>
						<div>狀態：${mb.status}</div>
						<div>刪除文章/留言：${reportTimes}</div>
					</div>
					<div class="Reportbutton d-flex justify-content-end"
						style="position: absolute; top: 55px; right: 5%;">
						<input type="hidden" id="memberId" value="${mb.id}">
						<c:choose>
							<c:when test="${mb.status=='正常'}">
<!-- 								<a -->
<%-- 									href="<spring:url value='/member/changeMemberStatus/${id}?memberLock=封鎖帳號&reportTimes=${reportTimes}'/>" --%>
<!-- 									style=""> -->
									<button class="Reportdeletebutton">封鎖帳號</button>
<!-- 								</a> -->
							</c:when>
							<c:otherwise>
<!-- 								<a -->
<%-- <%-- 									href="<spring:url value='/member/changeMemberStatus/${id}?memberLock=解除封鎖&reportTimes=${reportTimes}'/>"> --%>
								<button	class="Reportdeletebutton">解除封鎖</button>
<!-- 										</a> -->
							</c:otherwise>
						</c:choose>
					</div>
					<div
						class="col-lg-8 col-xl-4 d-flex flex-column justify-content-around py-2">
						<div>性別：${mb.gender}</div>
						<div>電話：${mb.phone}</div>
						<div>
							地址：<span>${mb.city}</span><span>${mb.area}</span><span>${mb.address}</span>
						</div>
						<div>E-mail：${mb.email}</div>
					</div>
				</div>
			</div>
			<!-- 標頭============================= -->
			<div class="my-4 border border-dark px-4 pt-4 contentBox"
				style="border: 1px solid rgba(0, 0, 0, 0.575); border-radius: 0.5em;">
				<ul class="nav nav-pills my-4" id="pills-tab" role="tablist"
					style="border-bottom: 1px solid rgba(0, 0, 0, 0.575);">
					<li class="nav-item col text-sm-center"
						style="padding-left: 0px !important; padding-right: 0px !important;">
						<div
						
						 class="nav-link" id="getArticles">文章</div>
					</li>
					<li class="nav-item col text-sm-center"
						style="padding-left: 0px !important; padding-right: 0px !important;">
						<div class="nav-link" id="getComments">留言</div>
					</li>
					<li class="nav-item col text-sm-center"
						style="padding-left: 0px !important; padding-right: 0px !important;">
						<div class="nav-link" id="getDeletedArticles">被刪除文章</div>
					</li>
					<li class="nav-item col text-sm-center"
						style="padding-left: 0px !important; padding-right: 0px !important;">
						<div class="nav-link" id="getDeletedComment">被刪除留言</div>
					</li>
				</ul>

				<!-- 文章留言列表============== -->
				<div class="row">
					<div
						class="col-3 d-flex justify-content-center align-items-center my-2" id="listNo">
						<c:choose>
							<c:when test="${not empty article_map}">文章編號</c:when>
							<c:otherwise>留言編號</c:otherwise>
						</c:choose>
					</div>
					<div
						class="col-3 d-flex justify-content-center align-items-center my-2">
						發文日期</div>
					<div
						class="col-3 d-flex justify-content-center align-items-center my-2">
						標題</div>
					<div
						class="col-3 d-flex justify-content-center align-items-center my-2">
						檢舉數</div>
				</div>

				<div style="height: 400px; overflow-y: scroll;" id="memberInfo_list">
					<c:choose>
						<c:when test="${not empty article_map}">
							<c:forEach var="entry" items="${article_map}">
								<a
									href="<spring:url value='/article/showReportInfo/${entry.key.articleId}/${cmd}'/>"
									style="text-decoration: none; color: black;">
									<div class="row">
										<div
											class="col-3 d-flex justify-content-center align-items-center my-2">
											${entry.key.articleId}</div>
										<div
											class="col-3 d-flex justify-content-center align-items-center my-2">
											<fmt:formatDate value="${entry.key.publishTime}"
												pattern="yyyy-MM-dd HH:mm" />
										</div>
										<div
											class="col-3 d-flex justify-content-center align-items-center my-2">
											${entry.key.title}</div>
										<div
											class="col-3 d-flex justify-content-center align-items-center my-2">
											${entry.value}</div>
									</div>
								</a>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach var="entry" items="${comment_map}">
								<a
									href="<spring:url value='/article/showReportInfo/${entry.key.commentId}/${cmd}'/>"
									style="text-decoration: none; color: black;">
									<div class="row">
										<div
											class="col-3 d-flex justify-content-center align-items-center my-2">
											${entry.key.commentId}</div>
										<div
											class="col-3 d-flex justify-content-center align-items-center my-2">
											<fmt:formatDate value="${entry.key.publishTime}"
												pattern="yyyy-MM-dd HH:mm" />
										</div>
										<div
											class="col-3 d-flex justify-content-center align-items-center my-2">
											${entry.key.content}</div>
										<div
											class="col-3 d-flex justify-content-center align-items-center my-2">
											${entry.value}</div>
									</div>
								</a>
							</c:forEach>
						</c:otherwise>
					</c:choose>
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
	<script src="https://kit.fontawesome.com/041970ba48.js"
		crossorigin="anonymous"></script>
		<script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>
	<script src="<spring:url value='/js/manager/memberInfo.js' /> "></script>

</body>
</html>