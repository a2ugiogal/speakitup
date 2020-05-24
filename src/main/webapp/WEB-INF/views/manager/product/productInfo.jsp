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
<link rel="stylesheet"
	href="<spring:url value='/css/manager/nav.css' />" />
<link rel="stylesheet"
	href="<spring:url value='/css/manager/productInfo.css' />" />
</head>
<body>
	<!-- =======================導覽列================= -->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top p-0"
		id="navBody">
		<div class="mr-auto">
			<button id="hamberger-btn" class="navbar-toggler ml-3" type="button"
				data-toggle="collapse" data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<a class="navbar-brand ml-3" href="<spring:url value='/' />"> <img
				src="<spring:url value='/image/logo/logo_trans_92px.png' /> "
				height="50px" /> 要抒拉
			</a>
		</div>
		<div class="navbar-nav flex-row ml-auto"
			style="position: absolute; right: 250px; top: 10px;">
			<form class="form-inline mr-5">
				<input class="form-control mr-sm-2" type="search" id="search"
					placeholder="Search" aria-label="Search" />
				<button class="btn d-flex justify-content-center" type="submit"
					id="search-btn">Search</button>
			</form>
		</div>
		<div class="navbar-nav flex-row ml-auto"
			style="position: absolute; right: 0; top: 10px;">
			<!-- ==========判斷是否登入======== -->
			<c:choose>
				<c:when test="${empty LoginOK}">
					<a class="navbar-brand mr-5"
						href="<spring:url value='/member/login' />">登入</a>
					<a class="navbar-brand mr-5"
						href="<spring:url value='/member/register' />">註冊</a>
				</c:when>
				<c:otherwise>
					<div style="width: 160px;">
						<a id="nav-memberId" class="mr-4"
							href="<spring:url value='/member/personPage' />"
							style="text-decoration: none;"> <img id="nav-memberPicture"
							src="<spring:url value='/member/getUserImage/${LoginOK.id}' />"
							width="45px" height="45px" class="rounded-circle mr-2" />
							${LoginOK.memberId}
						</a>
					</div>
					<a class="navbar-brand mr-5"
						href="<spring:url value='/member/logout' />">登出</a>
				</c:otherwise>
			</c:choose>
		</div>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item dropdown mx-2"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> 論壇 </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item"
							href="<spring:url value='/article/showPageArticles?categoryTitle=天使' />">天使板</a>
						<a class="dropdown-item"
							href="<spring:url value='/article/showPageArticles?categoryTitle=惡魔' />">惡魔板</a>
					</div></li>
				<li class="nav-item dropdown mx-2"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> 商城 </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="/product/productHome">首頁</a> <a
							class="dropdown-item"
							href="<spring:url value='/order/shoppingCartList' />">購物車</a> <a
							class="dropdown-item"
							href="<spring:url value='/order/showHistoryOrder' />">歷史訂單</a>
					</div></li>
				<li class="nav-item mx-2"><a class="nav-link"
					href="<spring:url value='/letter/letterHome' />">漂流瓶</a></li>
				<c:if test="${LoginOK.permission=='管理員'}">
					<li class="nav-item dropdown mx-2"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"> 管理後台 </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<a class="dropdown-item"
								href="<spring:url value='/article/showReports' />">檢舉專區</a> <a
								class="dropdown-item"
								href="<spring:url value='/member/showMembers' />">帳號管理</a> <a
								class="dropdown-item"
								href="<spring:url value='/order/showOrders' />">訂單管理</a><a
								class="dropdown-item"
								href="<spring:url value='/product/showProducts' />">商品管理</a>
						</div></li>
				</c:if>
				<li class="nav-item dropdown mx-2 mb-1"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> 關於我們 </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="<spring:url value='/aboutUs/createIdea' />">創建理念</a> <a
							class="dropdown-item" href="<spring:url value='/aboutUs/groupInfo' />">團隊介紹</a> <a class="dropdown-item"
							href="#">聯絡我們</a>
					</div></li>
			</ul>
		</div>
	</nav>
	<!-- 導覽列 -->


	<div class="pb-5" id="pageBg">
		<div style="height: 60px;"></div>
		<div class="w-75 my-5 mx-auto p-5">
			<form:form method="post" enctype="multipart/form-data"
				modelAttribute="productBean">
				<div class="row m-0 mb-5">
					<!-- 左基本資料======================= -->
					<div class="col-lg-12 col-xl-6 p-0">
						<div class="m-3 p-4 px-5 contentBox">
							<div
								class="form-group row mx-0 d-flex justify-content-center align-items-center text-center">
								<img class="my-2 border"
									src="<spring:url value='/product/getProductImage/${productId}' />"
									id="headPicture" style="width: 250px; height: 250px;" />
							</div>
							<div
								class="form-group row mx-0 d-flex justify-content-cneter align-items-center text-center">
								<div id="file">
									<form:input name="memberMultipartFile" type="file"
										id="fileSelect" path="productImage"
										style="visibility: hidden;" />
									<label for="fileSelect" id="fileLabel"
										class="d-flex align-items-center justify-content-center rounded">上傳商品圖片</label>
								</div>
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
											class="form-control"
											onkeyup="value=value.replace(/[^\d]/g,'')" />
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

										<div
											<c:choose>
											<c:when test="${productBean.category.categoryTitle=='天使'||productBean.productId==null}"> class="btn btn-outline-secondary active"</c:when>
											<c:otherwise> class="btn btn-outline-secondary"</c:otherwise>
										</c:choose>
											id="angel">
											<input type="radio" required="required" value="天使" />天使
										</div>
										<div
											<c:choose>
											<c:when test="${productBean.category.categoryTitle=='惡魔'}"> class="btn btn-outline-secondary active"</c:when>
											<c:otherwise> class="btn btn-outline-secondary"</c:otherwise>
										</c:choose>
											id="evil">
											<input type="radio" required="required" value="惡魔" />惡魔
										</div>
									</div>
								</div>
								<div class="col-4 p-0">
									<select class="form-control" id="angelCategory"
										name="categoryId"
										<c:if test="${productBean.category.categoryTitle=='惡魔'}"> style="display: none;" disabled</c:if>>
										<c:forEach var="entry" items="${angel_set}">
											<option value="${entry.categoryId}"
												<c:if test="${productBean.category.categoryTitle==entry.categoryName}"> select</c:if>>${entry.categoryName}</option>
										</c:forEach>
									</select> <select class="form-control" id="evilCategory"
										name="categoryId"
										<c:if test="${productBean.category.categoryTitle=='天使'||productBean.productId==null}"> style="display: none;" disabled</c:if>>
										<c:forEach var="entry" items="${evil_set}">
											<option value="${entry.categoryId}"
												<c:if test="${productBean.category.categoryTitle==entry.categoryName}"> select</c:if>>${entry.categoryName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
					</div>
					<!-- 右規格========================== -->
					<div class="col-lg-12 col-xl-6 p-0">
						<div class="m-3 p-4 px-5 contentBox">
							<div
								class="d-flex justify-content-start align-items-center text-center my-2">
								<h3>規格：</h3>
								<i class="material-icons"
									style="font-size: 30px;cursor: pointer; <c:if test='${productBean.productId!=null}'> display: none;</c:if>"
									id="addProductFormat">add_circle</i>
							</div>

							<!-- format1============================ -->
							<div class="productFomat row mx-0 mb-3"
								<c:if test="${productBean.productId==null||title1==''}"> style="display: none;"</c:if>>
								<div class="col-10 p-3 border border-dark formatItemsBox">
									<c:choose>
										<c:when test="${productBean.productId==null||title1==''}">
											<!-- 規格細項1=============== -->
											<div class="form-group row mx-0 firstFormatItem">
												<div
													class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
													<input type="text" name="formatTitle1" class="form-control"
														placeholder="規格標題" />
													<h5>：</h5>
												</div>
												<div
													class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
													<input type="text" name="formatContent1"
														class="form-control" placeholder="規格細項" />
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
													<input type="text" name="formatContent1"
														class="form-control" />
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
																	class="form-control" placeholder="規格標題"
																	value="${title1}" readonly />
																<h5>：</h5>
															</div>
															<div
																class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
																<input type="text" name="formatContent1"
																	class="form-control" placeholder="規格細項"
																	value="${entry}" readonly />
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
																	style="font-size: 36px; display: none; cursor: pointer;">remove_circle_outline</i>
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
											style="font-size: 30px; cursor: pointer; <c:if test='${productBean.productId!=null}'> display: none;</c:if>">add_circle</i>
									</div>
								</div>

								<div class="col-2">
									<i class="material-icons deleteProductFomat"
										style="font-size: 36px; cursor: pointer; <c:if test='${productBean.productId!=null}'> display: none;</c:if>">remove_circle_outline</i>
								</div>
							</div>

							<!-- format2============================ -->
							<div class="productFomat row mx-0 mb-3"
								<c:if test="${productBean.productId==null||title2==''}"> style="display: none;"</c:if>>
								<div class="col-10 p-3 border border-dark formatItemsBox">
									<c:choose>
										<c:when test="${productBean.productId==null||title2==''}">
											<!-- 規格細項1=============== -->
											<div class="form-group row mx-0 firstFormatItem">
												<div
													class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
													<input type="text" name="formatTitle2" class="form-control"
														placeholder="規格標題" />
													<h5>：</h5>
												</div>
												<div
													class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
													<input type="text" name="formatContent2"
														class="form-control" placeholder="規格細項" />
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
													<input type="text" name="formatContent2"
														class="form-control" />
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
																	class="form-control" placeholder="規格標題"
																	value="${title2}" readonly />
																<h5>：</h5>
															</div>
															<div
																class="col-5 px-0 d-flex justify-content-center align-items-center text-center">
																<input type="text" name="formatContent2"
																	class="form-control" placeholder="規格細項"
																	value="${entry}" readonly />
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
																	style="font-size: 36px; display: none; cursor: pointer;">remove_circle_outline</i>
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
											style="font-size: 30px;cursor: pointer; <c:if test='${productBean.productId!=null}'> display: none;</c:if>">add_circle</i>
									</div>
								</div>

								<div class="col-2">
									<i class="material-icons deleteProductFomat"
										style="font-size: 36px;cursor: pointer; <c:if test='${productBean.productId!=null}'> display: none;</c:if>">remove_circle_outline</i>
								</div>
							</div>

							<div class="text-center my-2" style="color: red; display: none;"
								id="nullInputError">規格欄位不能為空</div>

							<div
								class="d-flex justify-content-center align-items-center text-center my-2">


								<%-- 								<c:choose> --%>
								<%-- 									<c:when test="${productBean==null}"> --%>
								<button type="button" class="btn btn-primary"
									id="checkFormatBtn"
									<c:if test="${productBean.productId!=null}"> style="display: none;" </c:if>>確認規格</button>
								<button type="button" class="btn btn-primary"
									id="changeFormatBtn"
									<c:if test="${productBean.productId==null}"> style="display: none;" </c:if>>修改規格</button>
								<%-- 									</c:when> --%>
								<%-- 									<c:otherwise> --%>
								<!-- 										<button type="button" class="btn btn-primary" -->
								<!-- 											id="checkFormatBtn" style="display: none;">確認規格</button> -->
								<!-- 										<button type="button" class="btn btn-primary" -->
								<!-- 											id="changeFormatBtn">修改規格</button> -->
								<%-- 									</c:otherwise> --%>
								<%-- 								</c:choose> --%>
							</div>
						</div>
					</div>
				</div>

				<!-- 各規格庫存=============================== -->
				<div class="m-3 p-4 px-5 mb-5 contentBox">
					<div class="my-3">
						<h3>填寫庫存：</h3>
					</div>
					<div class="row m-0 mb-5 p-1" id="stocks">
						<c:if test="${productBean.productId!=null}">
							<c:forEach var="content1" items="${content1_set}">
								<div class="col-lg-12 col-xl-6 p-0 mb-1">
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
													<c:forEach var="entry" items="${productBean.productFormat}">
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
				</div>

				<!-- 產品介紹================================== -->
				<div class="m-3 p-4 px-5 mt-5 contentBox">
					<div class="my-3">
						<h3>產品介紹：</h3>
					</div>
					<div class="row m-0 bor mb-3">
						<textarea class="py-2 px-3" name="detailStr" rows="10"
							style="width: 100%; resize: none;" required="required">${detail}</textarea>
					</div>
				</div>

				<div class="text-center">

					<%-- 					<c:choose> --%>
					<%-- 						<c:when test="${productBean.productId==null}"> --%>
					<input class="btn btn-primary mt-3" type="submit" id="submitBtn"
						<c:if test="${productBean.productId==null}">disabled="disabled"</c:if>
						value="確認" />
					<%-- 						</c:when> --%>
					<%-- 						<c:otherwise> --%>
					<!-- 							<input class="btn btn-primary mt-3" type="submit" id="submitBtn" -->
					<!-- 								value="確認" /> -->
					<%-- 						</c:otherwise> --%>
					<%-- 					</c:choose> --%>
				</div>
			</form:form>
		</div>
	</div>

	<!--========= footer================= -->
	<!-- Footer -->
	<footer class="page-footer font-small stylish-color-dark pt-2">
		<!-- Footer Links -->
		<div class="container text-center text-md-left mt-3">
			<!-- Grid row -->
			<div class="row">
				<div
					class="col-md-2 d-flex justify-content-center align-items-center">
					<img
						src="https://github.com/sun0722a/yaoshula/blob/master/src/logo/logo_trans_140px.png?raw=true"
						width="120px" alt="" />
				</div>
				<!-- Grid column -->

				<div class="col-md-4 mx-auto">
					<!-- Content -->
					<h5 class="font-weight-bold text-uppercase mb-3">要抒啦！ 網路論壇&商城
					</h5>
					<p id="footer-introdution" class="text-secondary">
						是個能夠預期回應溫度的論壇空間。希望在亂世間提供一個烏托邦式的空間，讓大家可以盡情釋放壓力，得到慰藉❤️。</p>
					<div class="d-flex"></div>
				</div>
				<!-- Grid column -->

				<hr class="clearfix w-100 d-md-none" />

				<!-- Grid column -->
				<div class="col-md-2 mx-auto">
					<!-- Links -->
					<h5 class="font-weight-bold text-uppercase mb-3">論壇</h5>

					<ul class="list-unstyled">
						<li><a
							href="<spring:url value='/article/showPageArticles?categoryTitle=天使' />">天使版</a>
						</li>
						<li><a
							href="<spring:url value='/article/showPageArticles?categoryTitle=惡魔' />">惡魔版</a>
						</li>
						<li><a href="<spring:url value='/letter/letterHome' />">漂流信</a>
						</li>
					</ul>
				</div>
				<!-- Grid column -->

				<hr class="clearfix w-100 d-md-none" />

				<!-- Grid column -->
				<div class="col-md-2 mx-auto">
					<!-- Links -->
					<h5 class="font-weight-bold text-uppercase mb-3">商城</h5>

					<ul class="list-unstyled">
						<li><a href="<spring:url value='/product/productHome' />">商城首頁</a>
						</li>
						<li><a href="<spring:url value='/order/shoppingCartList' />">我的購物車</a>
						</li>
						<li><a href="<spring:url value='/order/showHistoryOrder' />">歷史訂單</a>
						</li>
					</ul>
				</div>
				<!-- Grid column -->

				<hr class="clearfix w-100 d-md-none" />

				<!-- Grid column -->
				<div class="col-md-2 mx-auto">
					<!-- Links -->
					<h5 class="font-weight-bold text-uppercase mb-3">關於我們</h5>

					<ul class="list-unstyled">
						<li><a href="<spring:url value='/aboutUs/contact' />">聯絡我們</a>
						</li>
						<li><a href="#!">服務條款</a></li>
						<li><a href="#!">隱私權政策</a></li>
					</ul>
				</div>
				<!-- Grid column -->
			</div>
			<!-- Grid row -->
		</div>

		<!-- Copyright -->
		<div class="footer-copyright text-center mt-0 pb-3"
			style="font-size: 15px;">© 2020 Copyright © 2020 Speak It Up.
			All rights reserved</div>
		<!-- Copyright -->
	</footer>
	<!-- Footer -->

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
					<input type="button" class="btn"
						style="background: rgb(136, 116, 116) !important; color: #fff;"
						value="仍要修改" id="checkChangeFormat" />
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
	<script src="<spring:url value='/js/manager/productInfo.js' />"></script>

</body>
</html>