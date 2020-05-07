<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@500&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="<spring:url value='/css/letter/letters.css' /> ">

<script src="<spring:url value='/js/letter/letters.js' /> "></script>
<title>我的信件</title>
</head>
<body>
	<div class="container">
		<c:forEach var='letters' items='${letters}' varStatus="letterNo">
			<!--1-->
			<div class="letterBox">
				<div class="sendBox animated">
					<h2>${letterNo.count}</h2>
					<h3>
						天使<img src="<spring:url value='/image/letter/angel.png' /> "
							style="width: 30px;">
					</h3>
					<h3>寄信內容</h3>
					<p>${letters.letterContent}</p>
					<div class="watchReply">看回信</div>
				</div>
				<div class="replyBox animated">
					<h3>
						回信內容<img src="<spring:url value='/image/letter/replyIcon.svg' /> "
							style="width: 30px;">
					</h3>
					<p>${letters.replyContent}</p>
					<div class="back">返回</div>
				</div>
			</div>

		</c:forEach>
	</div>



</body>
</html>