<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<spring:url value='/css/letter/replyAngel.css' /> ">
    <script src="<spring:url value='/js/letter/forSend.js' /> "></script>
<title>Insert title here</title>
</head>
<body>
<form action="<c:url value='/letter/sendReplyContent' /> " method="POST">
	<div class="container">
        <div class="card">
            <div class="contentBox">
                <div class="content">
                    <h4>${lb.letterTitle}</h4>
                    <br>
                    <h5>${lb.letterCategory}</h5>
                    <p>${lb.letterContent}</p>
                </div>
            </div>
            <div class="replyContentBox">
                <div class="replyContent">
                    <h2>回應內容</h2>
                    <input type="hidden" value="${lb.letterId}" name="id">
                    <p><textarea name="replyContent" id="" cols="30" rows="10" maxlength="250"></textarea></p>
                   <input type="submit" name="devil" class="btn btn-primary btn-user btn-block" role="button" id="submitbtn" value="寄出">
                </div>
            </div>
        </div>
    </div>
       </form>
</body>
</html>