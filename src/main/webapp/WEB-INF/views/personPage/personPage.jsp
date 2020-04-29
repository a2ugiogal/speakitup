<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>要抒拉--個人頁面</title>
<link rel="stylesheet"
	href="<spring:url value='/css/personPage/personPage.css' /> " />
<script
	src="<spring:url value='/js/personPage/updatePersonPage.js' /> "></script>

<!-- 下拉式地址 -->
<script
	src="https://cdn.jsdelivr.net/npm/tw-city-selector@2.1.0/dist/tw-city-selector.min.js"></script>
<!-- 下拉式地址 -->

</head>
<body>
<%-- 	<jsp:include page="/fragment/topMenuTemp.jsp" /> --%>

	<div class="side_menu">
		<span><a href="">個人頁面</a></span> 
		<span><a href="<spring:url value='/personPage/showMyArticles' />">我的文章</a></span>
		<span><a href="<spring:url value='/' /> ">回首頁</a></span> 
	</div>

	<form:form  modelAttribute="memberBean" method="POST" enctype='multipart/form-data' id="personForm">
		<div id="personPage">
			<div>
				<img src="<spring:url value='/image/personPage/icons8-edit-144.png ' /> " id="edit" />
			</div>
			<div id="boxHeadPicture">
				<img
					src="<spring:url value='/personPage/getUserImage/${LoginOK.id}' /> "
					id="headPicture" />
			</div>
			<div id="boxFileSelect">

				<form:input type="file" path="memberImage"
					style="visibility: hidden;" id="fileSelect"
 						value='/personPage/getUserImage/${LoginOK.id}'/>
						
			</div>

			<table>
				<tr>
					<td class="personalTitle">帳號：&nbsp&nbsp</td>
					<td class="personal">${LoginOK.memberId}</td>
				</tr>
				<tr>
					<td class="personalTitle">性別：&nbsp&nbsp</td>
					<td class="personal">${LoginOK.gender}</td>
				</tr>
				<tr>
					<td class="personalTitle">生日：&nbsp&nbsp</td>
					<td class="personal">${LoginOK.birthday}</td>
				</tr>
				<tr>
					<td class="personalTitle">E-mail：&nbsp&nbsp</td>
					<td class="personalUpdate">${LoginOK.email}</td>
				</tr>
				<tr>
					<td class="personalTitle">手機：&nbsp&nbsp</td>
					<td class="personalUpdate">${LoginOK.phone}</td>
				</tr>
				<tr>
					<td class="personalTitle">地址：&nbsp&nbsp</td>
					<td class="personalUpdate"><span id="city">${LoginOK.city}</span><span
						id="area">${LoginOK.area}</span><span id="address">${LoginOK.address}</span></td>
				</tr>
				<tr>
					<td colspan="2">
						<div align="center">
							<input id="btSubmit" type="submit" value="儲存" style="visibility: hidden;" /> 
							<input type="submit" id="btCancel" value="取消" style="visibility: hidden;" name="cancel" />
						</div>
					</td>
				</tr>
			</table>
		</div>
	</form:form>
</body>
</html>
		