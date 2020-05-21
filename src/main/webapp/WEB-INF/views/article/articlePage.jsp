<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${categoryTitle}版--要抒啦</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<link href="https://unpkg.com/boxicons@2.0.5/css/boxicons.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="<spring:url value='/css/article/nav.css' /> " />
<link rel="stylesheet"
	href="<spring:url value='/css/loginModel.css' /> " />
<c:choose>
	<c:when test="${categoryTitle=='天使'}">
		<link rel="stylesheet"
			href="<spring:url value='/css/article/articlePageAngel.css' /> " />
	</c:when>
	<c:otherwise>
		<link rel="stylesheet"
			href="<spring:url value='/css/article/articlePageEvil.css' /> " />
	</c:otherwise>
</c:choose>
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
			<input class="form-control mr-sm-2" type="search" id="search"
				placeholder="搜尋: 文章標題" aria-label="Search" name="search"
				style="width: 70% !important;" value="${searchStr}" />
			<button class="btn" type="submit" id="search-btn">搜尋</button>
			<input type="hidden" value="${categoryTitle}" name="categoryTitle"
				id="categoryTitle"> <input type="hidden"
				value="${categoryName}" name="categoryName" id="categoryName">
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
						<a class="dropdown-item" href="#">創建理念</a> <a
							class="dropdown-item" href="#">團隊介紹</a> <a class="dropdown-item"
							href="<spring:url value='/aboutUs/contact' />">聯絡我們</a>
					</div></li>
			</ul>
		</div>
	</nav>
	<!-- 導覽列 -->

	<!-- 置頂按鈕 設定 -->
	<a href="#top_article"> <img id="myBtn"
		src="https://png.pngtree.com/png-clipart/20190705/original/pngtree-vector-up-arrow-icon-png-image_4272127.jpg" />
	</a>

	<!-- ===============main============== -->
	<!-- 判斷上方特效 -->
	<c:choose>
		<c:when test="${categoryTitle=='天使'}">
			<div class="banner"
				style="background: url('<spring:url value='/image/article/sky.jpg' />');background-size: cover;background-position: bottom;">
				<div class="clouds">
					<img src="<spring:url value='/image/article/cloud1.png' />"
						style="--i: 1;" /> <img
						src="<spring:url value='/image/article/cloud2.png' />"
						style="--i: 2;" /> <img
						src="<spring:url value='/image/article/cloud3.png' />"
						style="--i: 3;" /> <img
						src="<spring:url value='/image/article/cloud4.png' />"
						style="--i: 4;" /> <img
						src="<spring:url value='/image/article/cloud5.png' />"
						style="--i: 5;" />
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<section>
				<div class="side" id="side1"
					style="background: url('<spring:url value='/image/article/night.jpg' />');background-size: 100vw 100vh"></div>
				<div class="side" id="side2"
					style="background: url('<spring:url value='/image/article/night.jpg' />');background-size:  100vw 100vh"></div>
			</section>
		</c:otherwise>
	</c:choose>

	<!-- 下方主頁面 -->
	<div class="container-fluid contentBx bg-color">
		<div class="row" id="content">
			<div class="col-2"></div>
			<div class="d-flex justify-content-end col-9 py-3 bg-color"
				style="font-size: 1.2em;">
				<select name="arrange" id="arrange">
					<option value="popular"
						<c:if test="${arrange=='popular'}"> selected </c:if>>熱門 ⇧</option>
					<option value="time"
						<c:if test="${arrange=='time'}"> selected </c:if>>最新⇧</option>
				</select>
			</div>
			<div class="col-1"></div>

			<!-- 左欄 -->
			<div class="col-2"
				style="text-align: center; padding: 80px; position: relative;">
				<div style="margin-bottom: 50px;">
					<!-- 判斷新增文章圖 -->
					<a
						<c:choose>
							<c:when test="${empty LoginOK}">onclick="loginModel()"</c:when>
							<c:otherwise>href="<spring:url value='/article/addArticle' />"</c:otherwise>
						</c:choose>>
						<img
						<c:choose>
							<c:when test="${categoryTitle=='天使'}">
								src="<spring:url value='/image/article/pink.png' />"
							</c:when>
							<c:otherwise>
								src="<spring:url value='/image/article/blue.png' />"
							</c:otherwise>
						</c:choose>
						id="addArticleBtn" width="80%" class="rounded-circle"
						style="transform: scaleX(-1);" />
					</a>
				</div>
				<div id="showHint" class="rounded-circle"
					style="width: 180px; height: 80px; line-height: 80px; text-align: center; display: none !important;">
					來抒發吧！</div>
				<div id="left_list">
					<a
						href="<spring:url value='/article/showPageArticles?categoryTitle=${categoryTitle}&categoryName=' />"
						style="text-decoration: none;">
						<ul
							<c:choose>
						<c:when test="${categoryName==''}">class="select_list list_active"</c:when>
						<c:otherwise>class="select_list"</c:otherwise>
					</c:choose>>全部
						</ul>
					</a> <a
						href="<spring:url value='/article/showPageArticles?categoryTitle=${categoryTitle}&categoryName=生活' />"
						style="text-decoration: none;">
						<ul
							<c:choose>
								<c:when test="${categoryName=='生活'}">class="select_list list_active"</c:when>
								<c:otherwise>class="select_list"</c:otherwise>
							</c:choose>>生活
						</ul>
					</a> <a
						href="<spring:url value='/article/showPageArticles?categoryTitle=${categoryTitle}&categoryName=感情' />"
						style="text-decoration: none;">
						<ul
							<c:choose>
								<c:when test="${categoryName=='感情'}">class="select_list list_active"</c:when>
								<c:otherwise>class="select_list"</c:otherwise>
							</c:choose>>感情
						</ul>
					</a> <a
						href="<spring:url value='/article/showPageArticles?categoryTitle=${categoryTitle}&categoryName=工作' />"
						style="text-decoration: none;">
						<ul
							<c:choose>
								<c:when test="${categoryName=='工作'}">class="select_list list_active"</c:when>
								<c:otherwise>class="select_list"</c:otherwise>
							</c:choose>>工作
						</ul>
					</a> <a
						href="<spring:url value='/article/showPageArticles?categoryTitle=${categoryTitle}&categoryName=時事' />"
						style="text-decoration: none;">
						<ul
							<c:choose>
								<c:when test="${categoryName=='時事'}">class="select_list list_active"</c:when>
								<c:otherwise>class="select_list"</c:otherwise>
							</c:choose>>時事
						</ul>
					</a>
				</div>
			</div>
			<!-- 文章列表 -->
			<div class="col-10" style="overflow-y: auto; height: 86vh;"
				id="article_list">
				<div class="col-11">
					<c:forEach var="entry" items="${articles_map}" varStatus="number">
						<!-- 這是一組開始 -->
						<div class="nayma-timeline-block"
							<c:if test="${number.first}">id="top_article"</c:if>>
							<a
								href="<spring:url value='/article/showArticleContent/${entry.key.articleId}'/>"
								style="text-decoration: none;"> <!-- 白色對話框 -->
								<div class="row nayma-timeline-content">
									<!-- 使用者頭貼 -->
									<div
										class="col-2 d-flex align-items-center justify-content-center">
										<img
											src="<spring:url value='/member/getUserImage/${entry.key.authorId}' /> "
											class="rounded-circle" width="150px" height="150px" />
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
						<!-- 這是一組結束 -->
					</c:forEach>
				</div>
			</div>
		</div>
	</div>

	<!-- 登入浮動視窗============================= -->
	<div class="modal fade" id="ignismyModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="">
						<span>×</span>
					</button>
				</div>

				<div class="modal-body">
					<p class="h3 ml-3 mb-2">請登入再抒唷！</p>
					<p>
						<a
							href="<spring:url value='/member/login?target=/article/showPageArticles?arrange=${arrange}&search=${search}&categoryTitle=${categoryTitle}&categoryName=${categoryName}&loginFilter=true' />"
							style="text-decoration: none; color: black;">
							<button type="button" class="btn btn-light ml-3 login">
								Login Now</button>
						</a>
					</p>
				</div>
			</div>
		</div>
	</div>

	<c:if test="${categoryTitle=='惡魔'}">
		<!--惡魔特效 -->
		<script type="text/javascript">
			var side1 = document.getElementById("side1");
			// scroll的s記得是小寫而不是大寫
			window.addEventListener("scroll", function() {
				side1.style.left = -window.pageYOffset * 7 + "px";
			});
			var side2 = document.getElementById("side2");
			window.addEventListener("scroll", function() {
				side2.style.left = window.pageYOffset * 7 + "px";
			});
		</script>
	</c:if>



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
	<script src="https://kit.fontawesome.com/a076d05399.js"></script>
	<script src="<spring:url value='/js/article/articlePage.js' /> "></script>
</body>
</html>