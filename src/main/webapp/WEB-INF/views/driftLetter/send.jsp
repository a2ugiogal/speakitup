<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<spring:url value='/css/letter/send.css' /> ">
    <script src="<spring:url value='/js/letter/sendReply.js' /> " ></script>
<title>寄信</title>
</head>
<body>
	<div class="container">
        <div class="box">
            <div class="imgBox">
                <img class="happyImg" src="<spring:url value='/image/letter/sendAngel.png' /> ">
            </div>
            <div class="contentBoxHappy">
                <div>
                    <h2 style="text-align: center;">寄出天使信<i class="far fa-envelope"></i></h2>
                    <br>
                    <p>心情低落時，可以選擇寄封天使漂流信，當對方接收到此信時，會給予正向的回饋及鼓勵，
                        得到回覆後也可以依照對方的內容給予評價，讓我們能更致力於維護天使區所帶來的正能量，
                        讓你重拾信心，繼續面對下一個跳戰，但是信寄出後不保證能立刻收到回信，漂流信會不斷在空中漂流
                        直到有人接到此漂流信。
                    </p>

                    <a class="angelA" href="<spring:url value='/letter/sendAngelZone' /> " >點擊進入<i class="fas fa-sign-in-alt"></i></a>
                </div>
            </div>
        </div>
        <div class="box">
            <div class="imgBox">
                <img class="sadImg" src="<spring:url value='/image/letter/replyDark.png' /> ">
            </div>
            <div class ="contentBoxSad">
                <div>
                    <h2 style="text-align: center;">寄出惡魔信<i class="far fa-envelope"></i></h2>
                    <br>
                    <p>聽膩俗套的鼓勵時，可以選擇寄封惡魔漂流信，對方會給予負面的回饋及滿滿的負能量，
			                        並不是說對方可以進行人生攻擊式的回覆，而是透過負面又詼諧的方式讓寄信者得到前所未有的感受，或許此類型
			                        的回覆能使您對挑戰一笑置之，給予當頭棒喝讓您能繼續向前，得到回覆後也可以依照對方的內容給予評價，
			                        讓我們能更致力於維護惡魔區所帶來的負能量，讓你重拾信心或是失去信心(?)，繼續面對下一個跳戰
                    </p>
                    <a class="darkA" href="<spring:url value='/letter/sendDevilZone' /> ">點擊進入<i class="fas fa-sign-in-alt"></i></a>
                </div>
                
            </div>
        </div>
     
    </div>
</body>
</html>