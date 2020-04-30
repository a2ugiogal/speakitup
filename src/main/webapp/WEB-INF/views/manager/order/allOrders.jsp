<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>要抒拉管理員--訂單管理</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous" />
<script src="<spring:url value='/js/manager/allOrders.js' />"></script>
<script type="text/javascript">
	function checkDate(cmd, orderNo, searchStr) {
		$("#checkOrderDateModal").modal("show");
		var aSend = document.getElementById('aSend');
		let date = new Date();
		let year = date.getFullYear();
		let month = date.getMonth() + 1;
		let day = date.getDate();
		let now = year + "-" + month + "-" + day;
		modalBody = document.getElementById("modalBody");
		if(cmd=="shippingDate"){
		modalBody.innerHTML = "確認訂單編號"+orderNo+"<br>於"+now+"送貨?";
		}else{
		modalBody.innerHTML = "確認訂單編號"+orderNo+"<br>於"+now+"到貨?";
		}
		aSend.href = "<spring:url value='/order/addOrderDate?cmd="+cmd+"&id="+orderNo+"&searchStr="+searchStr+"'/>"
		$("#checkOrderDateModal").modal("hide");
	}
</script>
<style>
.orderItems {
	background: rgba(80, 189, 138, 0.3);
}
</style>
</head>
<body>
	<div class="w-75 my-5 mx-auto">
		<form action="<spring:url value='/order/showOrders' />">
			<div class="input-group my-3">
				<div class="input-group-prepend">
					<span class="input-group-text"><img
						src="<spring:url value='/image/product/search.png' />" /></span>
				</div>
				<input type="search" class="form-control" placeholder="搜尋： 訂單編號"
					name="searchStr" aria-label="Sizing example input"
					aria-describedby="inputGroup-sizing-default" value="${searchStr}" />
				<div class="input-group-append">
					<button class="btn btn-outline-secondary" id="button-addon2">
						搜尋</button>
				</div>
			</div>
		</form>

		<ul class="nav nav-tabs nav-justified p-0">
			<li class="nav-item nav-link" id="all">全部</li>
			<li class="nav-item nav-link" id="waitShip">待出貨</li>
			<li class="nav-item nav-link" id="alreadyShip">已出貨</li>
			<li class="nav-item nav-link" id="finish">完成</li>
		</ul>

		<div class="container-fluid p-0"
			style="border: 1px solid rgba(0, 0, 0, 0.575);">

			<div class="row m-0 border-bottom">
				<div
					class="col-1 text-center d-flex justify-content-center align-items-center my-2"></div>
				<div
					class="col-2 text-center d-flex justify-content-center align-items-center my-2">訂單編號</div>
				<div
					class="col-2 text-center d-flex justify-content-center align-items-center my-2">訂購日期</div>
				<div
					class="col-2 text-center d-flex justify-content-center align-items-center my-2">出貨日期</div>
				<div
					class="col-2 text-center d-flex justify-content-center align-items-center my-2">到貨日期</div>
				<div
					class="col-2 text-center d-flex justify-content-center align-items-center my-2">訂單狀態</div>
				<div
					class="col-1 text-center d-flex justify-content-center align-items-center my-2"></div>
			</div>

			<c:forEach var="entry" varStatus="num" items="${order_list}">
				<div class="row m-0 ${entry.status}" style="min-height: 80px;">
					<div class="col-1 text-center my-2"></div>
					<div
						class="col-2 text-center d-flex justify-content-center align-items-center my-2">${entry.orderNo}</div>
					<div
						class="col-2 text-center d-flex justify-content-center align-items-center my-2">
						<fmt:formatDate value="${entry.orderDate}" pattern="yyyy-MM-dd" />
					</div>
					<div
						class="col-2 text-center d-flex justify-content-center align-items-center my-2">
						<c:choose>
							<c:when test="${entry.shippingDate==null}">
								<i class="fa fa-plus-circle" style="font-size: 30px;"
									onclick="checkDate('shippingDate',${entry.orderNo},${searchStr})"></i>
							</c:when>
							<c:otherwise>
								<fmt:formatDate value="${entry.shippingDate}"
									pattern="yyyy-MM-dd" />
							</c:otherwise>
						</c:choose>
					</div>
					<div
						class="col-2 text-center d-flex justify-content-center align-items-center my-2">
						<c:choose>
							<c:when test="${entry.arriveDate==null}">
								<i class="fa fa-plus-circle" style="font-size: 30px;"
									onclick="checkDate('arriveDate',${entry.orderNo},${searchStr})"></i>
							</c:when>
							<c:otherwise>
								<fmt:formatDate value="${entry.arriveDate}" pattern="yyyy-MM-dd" />
							</c:otherwise>
						</c:choose>
					</div>
					<div
						class="col-2 text-center d-flex justify-content-center align-items-center text-center my-2">${entry.status}</div>
					<div
						class="col-1 m-0 p-0 d-flex justify-content-center align-items-center orderRow"
						data-toggle="collapse" data-target="#collapse${num.index}"
						aria-expanded="false" aria-controls="collapse${num.index}"
						style="background-color: lightblue;">
						<i class="fas fa-angle-down" style="font-size: 30px;"></i>
					</div>
				</div>

				<!-- orderItems======================================================================= -->
				<div class="collapse" id="collapse${num.index}">
					<div class="card card-body w-100 p-0" style="border-width: 0px;">
						<div class="row m-0 orderItems">
							<div
								class="col-2 text-center d-flex justify-content-center align-items-center my-2"></div>
							<div
								class="col-2 text-center d-flex justify-content-center align-items-center my-2">商品名稱</div>
							<div
								class="col-2 text-center d-flex justify-content-center align-items-center my-2">規格</div>
							<div
								class="col-2 text-center d-flex justify-content-center align-items-center my-2">單價</div>
							<div
								class="col-2 text-center d-flex justify-content-center align-items-center my-2">數量</div>
							<div
								class="col-2 text-center d-flex justify-content-center align-items-center my-2">總價</div>

							<c:forEach var="detailMap" items="${orderItem_map}">
								<c:if test="${detailMap.key==entry.orderNo}">
									<c:forEach var="detailEntry" items="${detailMap.value}">
										<div class="col-2 text-center border-top border-light my-2">
											<img
												src="<spring:url value='/product/getProductImage/${detailEntry.productId}' />"
												alt="" style="max-width: 100px;" />
										</div>
										<div
											class="col-2 d-flex justify-content-center align-items-center text-center border-top border-light my-2">
											${detailEntry.productName}</div>
										<div
											class="col-2 d-flex justify-content-center align-items-center text-center border-top border-light my-2">
											<c:choose>
												<c:when
													test="${(orderMap.key.formatContent1=='')&&(orderMap.key.formatContent2=='')}">無 </c:when>
												<c:otherwise>${detailEntry.formatContent1} ${detailEntry.formatContent2}</c:otherwise>
											</c:choose>
										</div>
										<div
											class="col-2 d-flex justify-content-center align-items-center text-center border-top border-light my-2">
											$ ${detailEntry.unitPrice}</div>
										<div
											class="col-2 d-flex justify-content-center align-items-center text-center border-top border-light my-2">
											${detailEntry.quantity}</div>
										<div
											class="col-2 d-flex justify-content-center align-items-center text-center border-top border-light my-2">
											$ ${detailEntry.unitPrice*detailEntry.quantity}</div>
									</c:forEach>

								</c:if>
							</c:forEach>
							<div
								class="col-12 d-flex justify-content-end align-items-center text-center border-top border-light my-2">
								<span style="font-size: 20px;">總金額: $ ${entry.totalPrice}</span>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<!-- 更改日期 浮動視窗========== -->
	<div class="modal fade" id="checkOrderDateModal" tabindex="-1"
		role="dialog" aria-labelledby="checkOrderDateModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" id="modalBody">
					確認訂單編號1<br> 於2020-04-16到貨?
				</div>
				<div class="modal-footer">
					<a
						href="<spring:url value='/order/addOrderDate?cmd=${cmd}&id=${entry.orderNo}&searchStr=${searchStr}' />"
						style="text-decoration: none; color: black;" id="aSend"> <input
						type="button" class="btn btn-primary" value="確認" />
					</a>
				</div>
			</div>
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
	<script src="https://kit.fontawesome.com/a076d05399.js"></script>

</body>
</html>