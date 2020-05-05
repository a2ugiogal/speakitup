<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>要抒啦管理員--文章檢舉內容</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<style>
.scroll::-webkit-scrollbar {
	display: none;
}
</style>
</head>
<body>
	<div class="w-75 border my-5 mx-auto p-4">
		<div class="my-4 border border-dark p-4">
			<div class="d-flex">
				<img src="<spring:url value='/personPage/getUserImage/${mb.id}'/>"
					style="max-width: 200px; max-height: 100px;" />
				<div class="ml-4 my-auto" style="height: 100px;">
					<div>${mb.memberId}${mb.gender}</div>
					<div>${mb.permission}</div>
					<div>刪除文章/留言：${reportTimes}</div>
				</div>
				<div class="ml-5">
					<c:choose>
						<c:when test="${mb.status=='正常'}">
							<a
								href="<spring:url value='/member/changeMemberStatus/${id}?memberLock=封鎖帳號&reportTimes=${reportTimes}'/>"><input
								type="button" value="封鎖帳號"></a>
						</c:when>
						<c:otherwise>
							<a
								href="<spring:url value='/member/changeMemberStatus/${id}?memberLock=解除封鎖&reportTimes=${reportTimes}'/>"><input
								type="button" value="解除封鎖"></a>
						</c:otherwise>
					</c:choose>

				</div>
			</div>
			<div>電話：${mb.phone}</div>
			<div>
				地址：<span>${mb.city}</span><span>${mb.area}</span><span>${mb.address}</span>
			</div>
			<div>E-mail：${mb.email}</div>
		</div>
		<!-- 標頭============================= -->
		<div class="my-4 border border-dark p-4">
			<ul class="nav nav-tabs nav-justified">
				<li class="nav-item"><a class="nav-link"
					href="<spring:url value='/member/showManageMemberInfo/${id}?cmd=article&reportTimes=${reportTimes}'/>"
					style="text-decoration: none; color: black;">文章</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<spring:url value='/member/showManageMemberInfo/${id}?cmd=comment&reportTimes=${reportTimes}'/>"
					style="text-decoration: none; color: black;">留言</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<spring:url value='/member/showManageMemberInfo/${id}?cmd=deleteArticle&reportTimes=${reportTimes}'/>"
					style="text-decoration: none; color: black;">被刪除文章</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<spring:url value='/member/showManageMemberInfo/${id}?cmd=deleteComment&reportTimes=${reportTimes}'/>"
					style="text-decoration: none; color: black;">被刪除留言</a></li>
			</ul>

			<!-- 文章留言列表============== -->
			<c:choose>
				<c:when test="${not empty article_map}">
			<div class="row">
				<div
					class="col-2 d-flex justify-content-center align-items-center my-2">
					文章編號</div>
				<div
					class="col-4 d-flex justify-content-center align-items-center my-2">
					發文日期</div>
				<div
					class="col-4 d-flex justify-content-center align-items-center my-2">
					標題</div>
				<div
					class="col-2 d-flex justify-content-center align-items-center my-2">
					檢舉數</div>
			</div>
			<div class="scroll" style="height: 300px; overflow-y: scroll;">
			<c:forEach var="entry" items="${article_map}">
							<a
								href="<spring:url value='/article/showReportInfo/${entry.key.articleId}/${cmd}'/>"
								style="text-decoration: none; color: black;">
								<div class="row">
									<div
										class="col-2 d-flex justify-content-center align-items-center my-2">
										${entry.key.articleId}</div>
									<div
										class="col-4 d-flex justify-content-center align-items-center my-2">
										<fmt:formatDate value="${entry.key.publishTime}"
											pattern="yyyy-MM-dd HH:mm" />
									</div>
									<div
										class="col-4 d-flex justify-content-center align-items-center my-2">
										${entry.key.title}</div>
									<div
										class="col-2 d-flex justify-content-center align-items-center my-2">
										${entry.value}</div>
								</div>
							</a>
						</c:forEach>
						</div>
			</c:when>
			<c:otherwise>
			<div class="row">
				<div
					class="col-2 d-flex justify-content-center align-items-center my-2">
					留言編號</div>
				<div
					class="col-4 d-flex justify-content-center align-items-center my-2">
					發文日期</div>
				<div
					class="col-4 d-flex justify-content-center align-items-center my-2">
					標題</div>
				<div
					class="col-2 d-flex justify-content-center align-items-center my-2">
					檢舉數</div>
			</div>
			<div class="scroll" style="height: 300px; overflow-y: scroll;">
			<c:forEach var="entry" items="${comment_map}">
							<a
								href="<spring:url value='/article/showReportInfo/${entry.key.commentId}/${cmd}'/>"
								style="text-decoration: none; color: black;">
								<div class="row">
									<div
										class="col-2 d-flex justify-content-center align-items-center my-2">
										${entry.key.commentId}</div>
									<div
										class="col-4 d-flex justify-content-center align-items-center my-2">
										<fmt:formatDate value="${entry.key.publishTime}"
											pattern="yyyy-MM-dd HH:mm" />
									</div>
									<div
										class="col-4 d-flex justify-content-center align-items-center my-2">
										${entry.key.content}</div>
									<div
										class="col-2 d-flex justify-content-center align-items-center my-2">
										${entry.value}</div>
								</div>
							</a>
						</c:forEach>
						</div>
			</c:otherwise>
</c:choose>
		</div>
	</div>


	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
		integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
		integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
		crossorigin="anonymous"></script>
	<script
		src="<spring:url value='/js/article/articleContext.js' /> "></script>

</body>
</html>