<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link
	href='https://cdn.jsdelivr.net/npm/boxicons@2.0.5/css/boxicons.min.css'
	rel='stylesheet'>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
    <link rel="stylesheet" href="<spring:url value='/css/letter/sendAngel.css' /> ">
    <script src="<spring:url value='/js/letter/forSend.js' /> "></script>
<title>寄封天使信</title>
</head>
<body>
<form action ="<spring:url value='/letter/sendAngel' />" method="POST">
 <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center ">
    
          <div class="col-xl-10 col-lg-12 col-md-9 mt-5">
    
            <div class="card o-hidden border-0 shadow-lg my-5 " id="cardBody">
              <div class="card-body p-0" >
                <div class="row">
                  <!-- 左側圖片 -->
                  <div class="col-lg-6 d-none d-lg-block pl-3 pt-5 pb-5" >
                	<img src="<spring:url value='/image/letter/toSendAngel.png' /> " id="leftImg" >
<!--                  <span id="writeMode" >123</span> -->
                 </div>
                  <div class="col-lg-6">
                    <div class="pl-5 pt-4 pb-5 pr-5 ml-2" id="borderdiv">
                      
                      <div class="text-center">
                        <h4 class=" text-gray-900 mb-2">天使信件<img src="<spring:url value='/image/letter/angel.png' /> " class="animated  fadeInDown"></h4>
                        <div class="text-center">標題</div>    
                        <input type="text" name="title" id="titleInput">
                        	<br>
                        <span id="contentLength" style="font-size: 12px;">250</span>
                      </div>
                        
                        <div class="form-group">
                          <textarea cols="30" rows="10" id="letterContent" maxlength="250" name="content"></textarea>
                        </div>
                       <div class="text-center">                      
                        <input type="submit"  class="btn btn-primary  btn-block" role="button" id="submitbtn" value="寄出" disabled>
                      </div>                     

                    
                  </div>
                </div>
              </div>
            </div>
    
          </div>
    
        </div>
    
      </div>
      </div>
      </form>
</body>
</html>