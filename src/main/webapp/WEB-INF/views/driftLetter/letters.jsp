<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@500&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<link rel="stylesheet" href="<spring:url value='/css/letter/letters.css' /> ">
<link rel="stylesheet" href="<spring:url value='/css/letter/nav.css' /> ">

<title>我的信件</title>
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
	
	
	<div id="showMyLetters" class="mainBox animated fadeIn">
			<c:if test="${letterCategory == '天使'}">
					<c:forEach var='letters' items='${letters}' varStatus="letterNo">
						<!--1-->
						<div class="letterBox">
							<div class="sendBox animated">
								<c:if test="${letterNo.count <6}">
									<div class="newLetters"><i class="fas fa-bullhorn"></i></div>
								</c:if>
								<p><h2>${letterNo.count}</h2></p>
								<p><h2>${letters.letterTitle}</h2></p>
								<p><h3>${letterCategory}</h3></p>
								<p><h5>${letters.sendTime}</h5></p>
								<p>${letters.letterContent}</p>
<%-- 								<div id="${letters.letterId}" style="display:none"></div> --%>
								<div class="sendBoxBotAngel">
								<div class="watchReply">看回信</div>
								<div class="btnDiv">
								<ul>
                            <li>
                             <label class="feedbackBtnAngel">
                             	<c:choose>
	                             	<c:when test="${letters.feedback == 'like'}">
	                             		 <input type="checkbox" checked="checked" class="likeAngel${letters.letterId}">
	                                 <div class="iconBox" onclick="likeFeedbackAngel(${letters.letterId})" >
	                                     <i class="far fa-handshake"></i>
	                                  </div>
	                             	</c:when>
	                             	<c:otherwise>
		                             	<input type="checkbox"   class="likeAngel${letters.letterId}">
	                                 	<div class="iconBox"  onclick="likeFeedbackAngel(${letters.letterId})">
	                                     	<i class="far fa-handshake"></i>
	                                  </div>
	                             	</c:otherwise>
                             	</c:choose>      
                              </label>
                            </li>
                            <li>
                             <label class="hateBtn">
                             	<c:choose>
                             		<c:when test="${letters.feedback == 'dislike'}">
                             			<input type="checkbox" checked="checked" class="hateAngel${letters.letterId}">
                                 		<div class="iconBox" onclick="deleteFeedbackAngel(${letters.letterId})">
                                     		<i class="fas fa-exclamation-triangle"></i>
                                  		</div>
                             		</c:when>
                             		<c:otherwise>
                             			<input type="checkbox" class="hateAngel${letters.letterId}">
                                 		<div class="iconBox" onclick="deleteFeedbackAngel(${letters.letterId})">
                                     		<i class="fas fa-exclamation-triangle"></i>
                                  		</div>
                             		</c:otherwise>
                             	</c:choose>
                              </label>
                            </li>
                        </ul>
                        </div>
							</div>
							</div>
							<div class="replyBox animated">
								<p><h3>回信內容</h3></p>
								<p>${letters.replyContent}</p>
								<div class="back">返回</div>
							</div>
						</div>		
					</c:forEach>
			</c:if>
<%-- 				<c:when test="${letterCategory == '惡魔'}"> --%>
<!-- 					<div class="containerAngel"> -->
<%-- 						<c:forEach var='letters' items='${letters}' varStatus="letterNo"> --%>
<!-- 							1 -->
<!-- 							<div class="letterBox"> -->
<!-- 								<div class="sendBox animated"> -->
<%-- 									<h2>${letterNo.count}</h2> --%>
<%-- 									<h3>${letterCategory}</h3> --%>
<!-- 									<h3>寄信內容</h3> -->
<%-- 									<p>${letters.letterContent}</p> --%>
<!-- 									<div class="watchReply">看回信</div> -->
<!-- 								</div> -->
<!-- 								<div class="replyBox animated"> -->
<!-- 									<h3> -->
<%-- 										回信內容<img src="<spring:url value='/image/letter/replyIcon.svg' /> " --%>
<!-- 											style="width: 30px;"> -->
<!-- 									</h3> -->
<%-- 									<p>${letters.replyContent}</p> --%>
<!-- 									<div class="back">返回</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
		
<%-- 						</c:forEach> --%>
<!-- 					</div> -->
<%-- 				</c:when> --%>
	</div>
	<label class="angelLabel">
        <input type="checkbox" name="letterType">
        <span class="check"></span>
        <span class="btn"></span>
    </label>
	
	<!-- 給予喜歡的浮動視窗 -->
<!-- 	<div class="modal fade" id="likeModal" role="dialog"> -->
<!-- 		<div class="modal-dialog"> -->
<!-- 			<div class="modal-content"> -->
<!-- 				<div class="modal-header"> -->
<!-- 					<h5>要給予對方正面回饋嗎</h5> -->
<!-- 					<button type="button" class="close closeBtn" data-dismiss="modal" -->
<!-- 						aria-label="" > -->
<!-- 						<span>×</span> -->
<!-- 					</button> -->
<!-- 				</div> -->

<!-- 				<div class="modal-body"> -->
<!-- 				<input type="hidden" id="likeLetterId"> -->
					
<!-- 					<p> -->
<!-- 						<button type="button" id="sendLike" class="btn btn-light ml-3">沒錯</button> -->
<!-- 					</p> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
	
	
<!-- 	<div class="modal fade" id="unlikeModal" role="dialog"> -->
<!-- 		<div class="modal-dialog"> -->
<!-- 			<div class="modal-content"> -->
<!-- 				<div class="modal-header"> -->
<!-- 				<h5>要給予對方負面回饋嗎</h5> -->
<!-- 					<button type="button" class="close closeBtn" data-dismiss="modal" -->
<!-- 						aria-label="" > -->
<!-- 						<span>×</span> -->
<!-- 					</button> -->
<!-- 				</div> -->

<!-- 				<div class="modal-body"> -->
<!-- 				<input type="hidden" id="unlikeLetterId"> -->
					
<!-- 					<p> -->
<!-- 						<button type="button" class="btn btn-light ml-3" id="sendUnlike">沒錯</button> -->
<!-- 					</p> -->
					
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
	
	
<!-- 	<script src="https://code.jquery.com/jquery-3.5.1.min.js" -->
<!-- 		integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" -->
<!-- 		crossorigin="anonymous"></script> -->
<!-- 	<script -->
<!-- 		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" -->
<!-- 		integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" -->
<!-- 		crossorigin="anonymous"></script> -->
<!-- 	<script -->
<!-- 		src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" -->
<!-- 		integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" -->
<!-- 		crossorigin="anonymous"></script> -->
	<script src="https://kit.fontawesome.com/a076d05399.js"></script>
	<script src="<spring:url value='/js/letter/letters.js' /> "></script>
</body>
</html>