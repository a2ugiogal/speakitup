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
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="<spring:url value='/css/letter/letters.css' /> ">
<script src="<spring:url value='/js/letter/letters.js' /> "></script>
<title>我的信件</title>
</head>
<body>
<a href="<spring:url value='/letter/letterHome' /> ">回漂流信首頁</a>
<a href="<spring:url value='/' /> ">回首頁</a>
	<div class="container">
		<c:forEach var='letters' items='${letters}' varStatus="letterNo" >
			<div class="box">
				<div class="content">
					<h2>${letterNo.count}</h2>
					<h3>${letters.letterCategory}<img
							src="<spring:url value='/image/letter/angel.png' /> "
							style="width: 30px;">
					</h3>
					<h3>寄信內容</h3>
					<p>${letters.letterContent}</p>
					<a class="wholeContent" href="#">看完整內容</a>
				</div>
				<div class="replyContent">
					<h3>
						回信內容<img src="<spring:url value='/image/letter/replyIcon.svg' /> "
							style="width: 30px;">
					</h3>
					<p>${letters.replyContent}</p>
					<a class="back" href="#">返回</a>
				</div>
			</div>
		</c:forEach>
		
	</div>
</body>
</html>