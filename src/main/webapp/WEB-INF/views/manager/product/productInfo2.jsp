<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>要抒拉管理員--商品管理細節</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous" />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet" />
	<link rel="shortcut icon" href="<spring:url value='/image/logo/logo_trans_92px.png' /> ">
<script src="<spring:url value='/js/manager/productInfo.js' />"></script>

<style>
</style>
</head>
<body>
	<div class="w-75 my-5 mx-auto border p-5">
		<form:form method="post" enctype="multipart/form-data"
			modelAttribute="productBean">
			<div class="row m-0 mb-5">
				<!-- 左基本資料======================= -->
				<div class="col-md-12 col-lg-6 border">
					<div
						class="form-group row mx-0 d-flex justify-content-center align-items-center text-center">
						<img class="mb-3"
							src="<spring:url value='/product/getProductImage/${productId}' />"
							id="headPicture" style="max-width: 75%;" />
						<form:input id="fileSelect" path="productImage" type="file" />
						<!-- 							<input -->
						<!-- 							name="memberMultipartFile" type="file" id="fileSelect" /> -->
					</div>
					<div class="form-group row mx-0">
						<label class="col-4 col-form-label">商品名稱：</label>
						<div class="col-8 p-0">
							<form:input path="productName" type="text" class="form-control"
								required="required" />
							<!-- 														<input type="text" name="productName" class="form-control" -->
							<%-- 															required="required" value="${product.productName}" /> --%>
						</div>
					</div>
					<div class="form-group row mx-0">
						<label class="col-4 col-form-label">價格：</label>
						<div class="col-8 p-0">
							<div class="input-group">
								<div class="input-group-prepend">
									<div class="input-group-text">$</div>
								</div>
								<form:input path="price" required="required" type="text"
									class="form-control" onkeyup="value=value.replace(/[^\d]/g,'')" />
								<!-- 								<input type="text" name="price" class="form-control" -->
								<%-- 									required="required" value="${product.price}" --%>
								<!-- 									onkeyup="value=value.replace(/[^\d]/g,'')" /> -->
							</div>
						</div>
					</div>
					<div class="form-group row mx-0">
						<label class="col-4 col-form-label">商品分類：</label>
						<div class="col-4 p-0">
							<div class="btn-group-horizontal btn-group-toggle mb-5"
								data-toggle="buttons">
								<div class="btn btn-outline-secondary active" id="angel">
									<input type="radio" required="required" value="天使" />天使
								</div>
								<div class="btn btn-outline-secondary" id="evil">
									<input type="radio" required="required" value="惡魔" />惡魔
								</div>
							</div>
						</div>
						<div class="col-4 p-0">
							<select class="form-control" id="angelCategory" name="categoryId">
								<c:forEach var="entry" items="${angel_set}">
									<option value="${entry.categoryId}">${entry.categoryName}</option>
								</c:forEach>
							</select> <select class="form-control" id="evilCategory"
								style="display: none;" name="categoryId" disabled>
								<c:forEach var="entry" items="${evil_set}">
									<option value="${entry.categoryId}">${entry.categoryName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</div>
				<!-- 右規格========================== -->
				<div class="col-md-12 col-lg-6 border">
					<div
						class="d-flex justify-content-start align-items-center text-center my-2">
						<h3>規格：</h3>
						<i class="material-icons"
							style="font-size: 30px; <c:if test='${product!=null}'> display: none;</c:if>"
							id="addProductFormat">add_circle</i>
					</div>

					<!-- format1============================ -->
					<div class="productFomat row mx-0 mb-3"
						<c:if test="${product==null||title1==''}"> style="display: none;"</c:if>>
						<div class="col-10 p-3 border border-dark formatItemsBox">
							<c:choose>
								<c:when test="${product==null||title1==''}">
									<!-- 規格細項1=============== -->
									<div class="form-group row mx-0 firstFormatItem">
										<div
											class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
											<input type="text" name="formatTitle1"
												class="form-control p-0" placeholder="規格標題" />
											<h5>：</h5>
										</div>
										<div
											class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
											<input type="text" name="formatContent1" class="form-control"
												placeholder="規格細項" />
										</div>
										<div
											class="col-2 d-flex justify-content-center align-items-center text-center"></div>
									</div>

									<!-- 規格細項2=============== -->
									<div class="form-group row mx-0 secondFormatItem">
										<div
											class="col-5 px-0 d-flex justify-content-center align-items-center text-center"></div>
										<div
											class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
											<input type="text" name="formatContent1" class="form-control" />
										</div>
										<div
											class="col-2 d-flex justify-content-center align-items-center text-center"></div>
									</div>
								</c:when>
								<c:otherwise>
									<c:forEach var="entry" varStatus="count"
										items="${content1_set}">
										<c:choose>
											<c:when test="${count.first}">
												<!-- 規格細項1=============== -->
												<div class="form-group row mx-0 firstFormatItem">
													<div
														class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
														<input type="text" name="formatTitle1"
															class="form-control p-0" placeholder="規格標題"
															value="${title1}" readonly />
														<h5>：</h5>
													</div>
													<div
														class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
														<input type="text" name="formatContent1"
															class="form-control" placeholder="規格細項" value="${entry}"
															readonly />
													</div>

													<div
														class="col-2 d-flex justify-content-center align-items-center text-center"></div>
												</div>
											</c:when>
											<c:when test="${count.index==1}">
												<!-- 規格細項2=============== -->
												<div class="form-group row mx-0 secondFormatItem">
													<div
														class="col-5 px-0 d-flex justify-content-center align-items-center text-center"></div>
													<div
														class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
														<input type="text" name="formatContent1"
															class="form-control" value="${entry}" readonly />
													</div>

													<div
														class="col-2 d-flex justify-content-center align-items-center text-center"></div>
												</div>
											</c:when>
											<c:otherwise>
												<!-- 規格細項3456789...=============== -->
												<div class="form-group row mx-0">
													<div
														class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
													</div>
													<div
														class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
														<input type="text" name="formatContent1"
															class="form-control" value="${entry}" readonly>
													</div>
													<div
														class="col-2 d-flex justify-content-center align-items-center text-center">
														<i class="material-icons deleteProductFormatItem "
															style="font-size: 36px; display: none;">remove_circle_outline</i>
													</div>
												</div>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:otherwise>
							</c:choose>

							<div
								class="d-flex justify-content-center align-items-center text-center my-2 addProductFormatItemDiv">
								<i class="material-icons addProductFormatItem"
									style="font-size: 30px; <c:if test='${product!=null}'> display: none;</c:if>">add_circle</i>
							</div>
						</div>

						<div class="col-2">
							<i class="material-icons deleteProductFomat"
								style="font-size: 36px; <c:if test='${product!=null}'> display: none;</c:if>">remove_circle_outline</i>
						</div>
					</div>

					<!-- format2============================ -->
					<div class="productFomat row mx-0 mb-3"
						<c:if test="${product==null||title2==''}"> style="display: none;"</c:if>>
						<div class="col-10 p-3 border border-dark formatItemsBox">
							<c:choose>
								<c:when test="${product==null||title2==''}">
									<!-- 規格細項1=============== -->
									<div class="form-group row mx-0 firstFormatItem">
										<div
											class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
											<input type="text" name="formatTitle2"
												class="form-control p-0" placeholder="規格標題" />
											<h5>：</h5>
										</div>
										<div
											class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
											<input type="text" name="formatContent2" class="form-control"
												placeholder="規格細項" />
										</div>
										<div
											class="col-2 d-flex justify-content-center align-items-center text-center"></div>
									</div>

									<!-- 規格細項2=============== -->
									<div class="form-group row mx-0 secondFormatItem">
										<div
											class="col-5 px-0 d-flex justify-content-center align-items-center text-center"></div>
										<div
											class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
											<input type="text" name="formatContent2" class="form-control" />
										</div>
										<div
											class="col-2 d-flex justify-content-center align-items-center text-center"></div>
									</div>
								</c:when>
								<c:otherwise>
									<c:forEach var="entry" varStatus="count"
										items="${content2_set}">
										<c:choose>
											<c:when test="${count.first}">
												<!-- 規格細項1=============== -->
												<div class="form-group row mx-0 firstFormatItem">
													<div
														class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
														<input type="text" name="formatTitle2"
															class="form-control p-0" placeholder="規格標題"
															value="${title2}" readonly />
														<h5>：</h5>
													</div>
													<div
														class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
														<input type="text" name="formatContent2"
															class="form-control" placeholder="規格細項" value="${entry}"
															readonly />
													</div>
													<div
														class="col-2 d-flex justify-content-center align-items-center text-center"></div>
												</div>
											</c:when>
											<c:when test="${count.index==1}">
												<!-- 規格細項2=============== -->
												<div class="form-group row mx-0 secondFormatItem">
													<div
														class="col-5 px-0 d-flex justify-content-center align-items-center text-center"></div>
													<div
														class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
														<input type="text" name="formatContent2"
															class="form-control" value="${entry}" readonly />
													</div>

													<div
														class="col-2 d-flex justify-content-center align-items-center text-center"></div>
												</div>
											</c:when>
											<c:otherwise>
												<!-- 規格細項3456789...=============== -->
												<div class="form-group row mx-0">
													<div
														class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
													</div>
													<div
														class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
														<input type="text" name="formatContent2"
															class="form-control" value="${entry}" readonly>
													</div>
													<div
														class="col-2 d-flex justify-content-center align-items-center text-center">
														<i class="material-icons deleteProductFormatItem"
															style="font-size: 36px; display: none;">remove_circle_outline</i>
													</div>
												</div>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:otherwise>
							</c:choose>

							<div
								class="d-flex justify-content-center align-items-center text-center my-2 addProductFormatItemDiv">
								<i class="material-icons addProductFormatItem"
									style="font-size: 30px; <c:if test='${product!=null}'> display: none;</c:if>">add_circle</i>
							</div>
						</div>

						<div class="col-2">
							<i class="material-icons deleteProductFomat"
								style="font-size: 36px; <c:if test='${product!=null}'> display: none;</c:if>">remove_circle_outline</i>
						</div>
					</div>

					<div class="text-center my-2" style="color: red; display: none;"
						id="nullInputError">規格欄位不能為空</div>

					<div
						class="d-flex justify-content-center align-items-center text-center my-2">
						<c:choose>
							<c:when test="${product==null}">
								<button type="button" class="btn btn-primary"
									id="checkFormatBtn">確認規格</button>
								<button type="button" class="btn btn-primary"
									id="changeFormatBtn" style="display: none;">修改規格</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-primary"
									id="checkFormatBtn" style="display: none;">確認規格</button>
								<button type="button" class="btn btn-primary"
									id="changeFormatBtn">修改規格</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>

			<!-- 各規格庫存=============================== -->
			<div>
				<h3>填寫庫存：</h3>
			</div>
			<div class="row m-0 mb-5 p-1" id="stocks">
				<c:if test="${product!=null}">
					<c:forEach var="content1" items="${content1_set}">
						<div class="col-md-12 col-lg-6 p-0 mb-1">
							<div class="border border-dark m-2">
								<table class="table text-center">
									<thead class="thead-light">
										<tr>
											<th scope="col">規格</th>
											<th scope="col">庫存</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="content2" items="${content2_set}">
											<c:forEach var="entry" items="${product.productFormat}">
												<c:if
													test="${entry.formatContent1==content1&&entry.formatContent2==content2}">
													<tr>
														<th scope="row">${content1}-${content2}</th>
														<td><input class="text-center" type="number"
															name="stock" value="${entry.stock}" /></td>
													</tr>
												</c:if>
											</c:forEach>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</c:forEach>
				</c:if>
			</div>

			<!-- 產品介紹================================== -->
			<div>
				<h3>產品介紹：</h3>
			</div>
			<div class="row m-0 bor">
				<textarea name="detailStr" rows="10" style="width: 100%;"
					required="required">${detail}</textarea>
			</div>

			<div class="text-center">
				<c:choose>
					<c:when test="${product==null}">
						<input class="btn btn-primary mt-3" type="submit" id="submitBtn"
							disabled="disabled" value="確認" />
					</c:when>
					<c:otherwise>
						<input class="btn btn-primary mt-3" type="submit" id="submitBtn"
							value="確認" />
					</c:otherwise>
				</c:choose>
			</div>
		</form:form>
	</div>

	<!-- 確認要修改/確認規格 浮動視窗========== -->
	<div class="modal fade" id="checkChangeFormatModal" tabindex="-1"
		role="dialog" aria-labelledby="checkChangeFormatModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<h6 id="modalBody">
						如要修改規格<br> 庫存需重新輸入喔~
					</h6>
				</div>
				<div class="modal-footer">
					<input type="button" class="btn btn-primary" value="仍要修改"
						id="checkChangeFormat" />
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

</body>
</html>