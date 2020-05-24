<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>要抒啦--文章內容</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
	<link rel="shortcut icon" href="<spring:url value='/image/logo/logo_trans_92px.png' /> ">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet" />
<c:choose>
	<c:when test="${article.category.categoryTitle=='天使'}">
		<link rel="stylesheet"
			href="<spring:url value='/css/article/articleContentAngel.css' /> " />
	</c:when>
	<c:otherwise>
		<link rel="stylesheet"
			href="<spring:url value='/css/article/articleContentEvil.css' /> " />
	</c:otherwise>
</c:choose>

<link rel="stylesheet"
	href="<spring:url value='/css/article/nav.css' /> " />
<link rel="stylesheet"
	href="<spring:url value='/css/loginModel.css' /> " />
</head>
<body>
	<!-- =======================導覽列================= -->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top p-0"
		id="navBody">
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
			<form class="form-inline mr-5">
				<input class="form-control mr-sm-2" type="search" id="search"
					placeholder="Search" aria-label="Search" />
				<button class="btn d-flex justify-content-center" type="submit"
					id="search-btn">Search</button>
			</form>
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
						<a id="nav-memberId" class="mr-4"
							href="<spring:url value='/member/personPage' />"
							style="text-decoration: none;"> <img id="nav-memberPicture"
							src="<spring:url value='/member/getUserImage/${LoginOK.id}' />"
							width="45px" height="45px" class="rounded-circle mr-2" />
							${LoginOK.memberId}
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
						<a class="dropdown-item" href="#">首頁</a> <a class="dropdown-item"
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
	<!-- 導覽列 -->


	<!-- 文章留言========================================= -->
	<div id="commentsDiv">
		<c:forEach var="entry" varStatus="number" items="${comments_set}">
			<c:choose>
				<c:when test="${ number.count % 6 >= 1&&number.count % 6 <= 3 }">
					<!-- 左對話氣泡*3=========================== -->
					<c:if test="${ number.count % 6 == 1 }">
						<div class="vh-100 p-3 speechArea"
							<c:if test="${number.count!=1}"> style="display: none;" </c:if>>
							<div style="height: 60px;"></div>
					</c:if>
					<div style="height: 4%;"></div>
					<div class="row m-0 d-flex align-items-center" style="height: 27%;">
						<c:if test="${number.count%3==1}">
							<div class="col-3 p-0"></div>
						</c:if>
						<c:if test="${number.count%3==0}">
							<div class="col-1 p-0"></div>
						</c:if>
						<div class="col-9 p-0 speechDad">
							<img class="speech-balloon1"
								src="<spring:url value='/image/article/speech-bubble-removebg-preview.png' />"
								style="transform: scaleX(-1);" />
							<div style="height: 5%;"></div>
							<div class="d-flex justify-content-start" style="height: 20%;">
								<c:if test="${not empty LoginOK}">
									<i class="fas fa-exclamation-circle" style="font-size: 30px;"
										title="檢舉" onclick="showReportModal('${entry.commentId}')"></i>
								</c:if>
							</div>
							<div class="comment">
								<pre style="white-space:pre-wrap;">${entry.content}</pre>
							</div>
							<div class="commentCount">${number.count}</div>
							<div class="d-flex justify-content-end commentDate">
								<fmt:formatDate value="${entry.publishTime}"
									pattern="yyyy-MM-dd HH:mm" />
							</div>
						</div>
					</div>
					<c:if test="${ number.count % 6 == 3 }">
	</div>
	</c:if>
	</c:when>
	<c:otherwise>
		<!-- 右對話氣泡*3=========================== -->
		<c:if test="${number.count % 6 == 4 }">
			<div class="vh-100 p-3 speechArea"
				style="left: 72%; <c:if test="${number.count!=4}"> display: none; </c:if>">
				<div style="height: 60px;"></div>
		</c:if>
		<div style="height: 4%;"></div>
		<div class="row m-0 d-flex align-items-center" style="height: 27%;">
			<c:if test="${number.count%3==2}">
				<div class="col-3 p-0"></div>
			</c:if>
			<c:if test="${number.count%3==0}">
				<div class="col-1 p-0"></div>
			</c:if>
			<div class="col-9 p-0 speechDad">
				<img class="speech-balloon1"
					src="<spring:url value='/image/article/speech-bubble-removebg-preview.png' />" />
				<div style="height: 5%;"></div>
				<div class="d-flex justify-content-end" style="height: 20%;">
					<c:if test="${not empty LoginOK}">
						<i class="fas fa-exclamation-circle" style="font-size: 30px;"
							title="檢舉" onclick="showReportModal('${entry.commentId}')"></i>
					</c:if>
				</div>
				<div class="comment">
					<pre>${entry.content}</pre>
				</div>
				<div class="commentCount">${number.count}</div>
				<div class="d-flex justify-content-end commentDate">
					<fmt:formatDate value="${entry.publishTime}"
						pattern="yyyy-MM-dd HH:mm" />
				</div>
			</div>
		</div>
		<c:if test="${number.count % 6 == 0 }">
			</div>
		</c:if>
	</c:otherwise>
	</c:choose>
	<c:if test="${number.last&&number.count%3!=0}">
		</div>
	</c:if>
	</c:forEach>
	</div>

	<!-- 文章========================================= -->
	<div class="vh-100">
		<!-- 標題=========================== -->
		<div class="bgColor w-100 h-100"></div>
		<div id="bgGray" class="w-100 h-100"></div>
		<a
			href="<spring:url value='/article/showPageArticles?categoryTitle=${article.category.categoryTitle}' />"><div
				id="turnBackBtn"
				class="d-flex align-items-center justify-content-center">
				<i class='fas fa-list-ul' style='font-size: 20px'></i>&nbsp;
				${article.category.categoryTitle}文章
			</div></a>
		<div class="mx-auto" style="height: 22%;">
			<div style="height: 60px;"></div>
			<div id="articleTitle" class="text-center pt-2 mx-auto">
				<div class="d-flex justify-content-center align-items-center mb-1">
					<h3 style="margin: 0px !important">${article.title}&nbsp;&nbsp;&nbsp;</h3>
					<div
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
						</c:choose>>
						${article.category.categoryName}</div>
				</div>

				<div class="pt-1">
					<img class="rounded-circle border border-dark"
						style="height: 30px; width: 30px;"
						src="<spring:url value='/member/getUserImage/${article.authorId}' />" />
					${article.authorName} &nbsp; &nbsp; &nbsp;
					<fmt:formatDate value="${article.publishTime}"
						pattern="yyyy-MM-dd HH:mm" />
				</div>
			</div>
			<div class="d-flex justify-content-center align-items-center p-1">
				<i id="lastPage" class="fas fa-caret-left"
					style="font-size: 36px; cursor: pointer; visibility: hidden;"></i>
				<div class="text-center" style="width: 150px;">
					<span id="commentPage">1</span> / <span id="totalPage"> <c:set
							var="commentsLength" value="${fn:length(comments_set)}"></c:set>
						<c:choose>
							<c:when test="${commentsLength==0}">1</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${commentsLength%6==0}">
										<fmt:parseNumber integerOnly="true"
											value="${fn:length(comments_set)/6}" />
									</c:when>
									<c:otherwise>
										<fmt:parseNumber integerOnly="true"
											value="${fn:length(comments_set)/6+1}" />
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</span>
				</div>
				<i id="nextPage" class="fas fa-caret-right"
					style="font-size: 36px; cursor: pointer;"></i>
			</div>
		</div>
		<div id="headDad">
			<!-- 頭的範圍(文章內容都放在裡面)======================= -->
			<div id="head">
				<img id="bgImg"
					src="<spring:url value='/image/article/humaanHead-removebg-preview.png' />" />
				<div style="height: 7%;">
					<div class="d-flex justify-content-end pt-2" style="width: 85%;">
						<c:if test="${not empty LoginOK}">
							<i class="fas fa-exclamation-circle" style="font-size: 30px;"
								title="檢舉" onclick="showReportModal('')"></i>
						</c:if>
					</div>
				</div>
				<div id="articlePicture" class="row">
					<div class="col-2"></div>

					<div class="col-8">
						<div class="text-center">
							<img
								<c:if test="${not empty article.image}">src="<spring:url value='/article/getArticleImage/${article.articleId}' />"</c:if>
								style="max-height: 180px; max-width: 100%;" />
						</div>
					</div>

					<div
						class="col-2 p-0 pl-2 pt-5 d-flex align-items-end justify-content-center">
						<div class="d-flex align-items-center justify-content-center">
							<c:set var="articleIds"
								value="${fn:split(LoginOK.likeArticles, ',')}"></c:set>

							<div id="heart">
								<div id="${article.articleId}"
									<c:choose>
										<c:when test="${empty LoginOK}">onclick="loginModel()"</c:when>
										<c:otherwise>onclick="likeIt()"</c:otherwise>
									</c:choose>
									class="normal d-flex align-items-center justify-content-center rounded-circle"
									<c:forEach var="entry" items="${articleIds}">
											<c:if test="${entry==''+article.articleId}">style="border: 1px solid red;color: red;cursor: default;" </c:if>
									</c:forEach>
									style="border: 1px solid black; color: black;">
									<i class="fas fa-heart"
										style="font-size: 30px; margin-top: 2px;" title="愛心"></i>
								</div>
							</div>
							<span style="margin-left: 3px;" id="likeNum">${article.likes}</span>
						</div>
					</div>
				</div>

				<div id="articleContent">
					<div class="m-2">${content}</div>
				</div>

				<div id="commentBtnArea"
					<c:choose>
						<c:when test="${empty LoginOK}">onclick="loginModel()"</c:when>
						<c:otherwise>onclick="wantComment()"</c:otherwise>
					</c:choose>
					class="p-2 rounded-pill d-flex align-items-center justify-content-center">
					<i class="far fa-comment mx-1" style="font-size: 30px;"></i>
					<div class="m-1">我要留言</div>
				</div>
				<!-- 可留言區============================ -->
				<%-- 				<form method="POST" id="commentForm" --%>
				<%-- 					action="<spring:url value='/article/addComment/${article.articleId} '/> "> --%>
				<div id="commentArea">
					<img id="myCommentBg"
						src="<spring:url value='/image/article/speech-bubble-removebg-preview.png' />" />
				</div>
				<div id="myCommentContent" class="text-center"
					style="display: none;">
					<div style="margin-top: 43px; margin-bottom: 8px;">
						<img class="rounded-circle border-dark border my-auto"
							style="width: 40px; height: 40px;"
							src="<spring:url value='/member/getUserImage/${LoginOK.id}' />" />
						<span>&nbsp; &nbsp; ${LoginOK.memberId}</span>
					</div>
					<div class="mt-3 mb-2">
						<textarea
							style="width: 70%; resize: none; outline: none; border-radius: 10px; padding: 5px;"
							id="contentText" rows="3" placeholder=" 留言..."></textarea>
					</div>
					<div id="sendCommentBtn"
						class="border p-2 rounded-circle d-flex justify-content-center align-items-center"
						onclick="sendComment(${article.articleId})">
						<i class="material-icons"
							style="font-size: 34px; margin-left: 5px; margin-top: 1px;">subdirectory_arrow_right</i>
					</div>
				</div>
				<%-- 				</form> --%>
			</div>
		</div>
	</div>

	<!-- 檢舉 浮動視窗========== -->
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog"
		aria-labelledby="reportModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="reportModalLabel">檢舉</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<input type="radio" name="reportItem" value="惡意洗版" id="惡意洗版"
						checked /><label for="惡意洗版">惡意洗版</label><br /> <input
						type="radio" name="reportItem" value="惡意攻擊他人" id="惡意攻擊他人" /><label
						for="惡意攻擊他人">惡意攻擊他人</label><br /> <input type="radio"
						name="reportItem" value="包含色情、血腥等，令人不舒服之內容" id="包含色情、血腥等，令人不舒服之內容" /><label
						for="包含色情、血腥等，令人不舒服之內容">包含色情、血腥等，令人不舒服之內容</label><br /> <input
						type="radio" name="reportItem" value="包含廣告、商業宣傳之內容"
						id="包含廣告、商業宣傳之內容" /><label for="包含廣告、商業宣傳之內容">包含廣告、商業宣傳之內容</label><br />
					<input type="radio" name="reportItem" value="與本板主題無關" id="與本板主題無關" /><label
						for="與本板主題無關">與本板主題無關</label>
				</div>
				<input type="hidden" id="commentIdInput" value="">
				<div class="modal-footer">
					<input type="button" class="btn btn-primary" value="送出"
						id="sendReport" />
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
							href="<spring:url value='/member/login?target=/article/showArticleContent/${article.articleId}&loginFilter=true' />"
							style="text-decoration: none; color: black;">
							<button type="button" class="btn btn-light ml-3 login">
								Login Now</button>
						</a>
					</p>
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
	<script src="https://kit.fontawesome.com/a076d05399.js"></script>
	<script src="<spring:url value='/js/article/articleContent.js' /> "></script>

</body>
</html>