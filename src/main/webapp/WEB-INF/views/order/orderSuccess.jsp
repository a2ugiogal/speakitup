<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/_04_order/success.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css">
<title>要抒拉--訂單完成</title>
</head>
<style>
	body{
  background: #fad2e2;
}
	
</style>
<body>
	<div>
		<div id="text">
			購買成功，商品有可能不會送來 <i class="far fa-smile-wink"></i> <i
				class="far fa-smile-wink"></i> <i class="far fa-smile-wink"></i>
		</div>
		<a href="<c:url value='/order/showHistoryOrder' />">前往歷史訂單</a>
		<div style="display: flex; justify-content: space-around;">
			<div class="loadingio-spinner-rolling-mdyer0yh538">
				<div class="ldio-garpaah2yl8">
					<div></div>
				</div>
			</div>
		</div>

	</div>
</body>
</html>