<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.4.1/cerulean/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-LV/SIoc08vbV9CCeAwiz7RJZMI5YntsH8rGov0Y2nysmepqMWVvJqds6y0RaxIXT"
	crossorigin="anonymous" />
<link rel="stylesheet" href="<spring:url value='/css/game/game.css' /> " />
<title>遊戲--要抒啦</title>
</head>
<body class="d-flex justify-content-center align-items-center">
	<input type="hidden" value="${range}" id="range">
	<!-- 		loading -->
	<div class="preloader">
		<div class="counter">5</div>
	</div>
	<!-- 		game -->
	<div class="hold"
		style="background: url('<spring:url value='/image/article/night.jpg' />');
	background-size: 100vw 100vh;"></div>
	<div id="finish" style="display: none;">
		<div id="victory">VICTORY!</div>
		<div
			class="d-flex justify-content-center align-items-center mb-3 mr-2 totalTime"
			style="display: none;">
			花費時間:
			<time id="time"></time>
			秒
		</div>
		<div class="d-flex justify-content-center align-items-center">
			<a href="<spring:url value='/' />" class="m-2"
				style="text-decoration: none; color: #495057;">回首頁</a> <a
				class="m-2" onclick="showGameModel()"
				style="text-decoration: none; color: #495057;">再來一次</a>
		</div>
	</div>

	<!-- 遊戲浮動視窗============================= -->
	<div class="modal fade" id="gameModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header pb-0">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="">
						<span>×</span>
					</button>
				</div>

				<form action="<spring:url value='/game'/>">
					<div class="modal-body">
						<p class="h3 ml-3 mb-5" style="color: rgb(33, 37, 41);">請選擇難度</p>
						<div id="rangeValue" class="ml-4 mb-2" style="font-size: 20px"></div>
						<input type="range" min="5" max="55" value="30" id="rangeNew"
							name="range" class="ml-4" onmousemove="changeValue()">
						<p class="d-flex justify-content-center mt-5">
							<button type="submit"
								class="btn btn-light close rounded-circle p-3"
								style="border: 3px solid #343a40">GO!</button>
						</p>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script> -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"
		integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"
		integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"
		integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k"
		crossorigin="anonymous"></script>
	<script type="text/javascript">
		function showGameModel() {
			$("#gameModal").modal("show");
			changeValue();
		}
		function changeValue() {
			$("#rangeValue").text(
					$("#rangeNew").val() + ' X ' + $("#rangeNew").val());
		}
	</script>
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							let range = $('#range').val();
							let num = range * range;
							let content = "";
							let colorArr = [];
							//隨機的顏色
							for (let i = 0; i < range; i++) {
								let colorR = Math.floor(Math.random() * 256);
								let colorG = Math.floor(Math.random() * 256);
								let colorB = Math.floor(Math.random() * 256);
								colorArr[colorArr.length] = 'rgb(' + colorR
										+ ',' + colorG + ',' + colorB + ')';
							}
							for (let i = 0; i < num; i++) {
								content += "<span class='outside'><div class='silde' id="+i+"></div></span>";
							}
							$(".hold").append(content);

							$('.outside').css('width',
									$(window).width() / range);
							$('.outside').css('height',
									$(window).height() / range);

							// mouseover:每次事件觸發時執行的功能
							$(".silde")
									.mouseover(
											function() {
												$(this).addClass("fall");
												let randomNo = Math.floor(Math
														.random()
														* range);
												let id = $(this).attr('id')
												$('#' + id).css('background',
														colorArr[randomNo]);

												let check = true;

												silde = document
														.getElementsByClassName('silde');
												for (let i = 0; i < silde.length; i++) {
													if (silde[i].className != 'silde fall') {
														check = false;
														break;
													}
												}
												if (check) {
													clearInterval(count);
													$('#finish').css('display',
															'block');
													$('.totalTime').css(
															'display', 'block');
												}
											});

							// loading
							// setInterval（）方法以指定的時間後執行，並回傳此定時器的編號
							var count = setInterval(function() {
								// parseInt() 函数可解析一个字符串，并返回一个整数。
								var c = parseInt($('.counter').text());
								// .toString()可以將所有的的資料都轉換為字串
								$('.counter').text((--c).toString());
								if (c == 0) {
									// clearInterval（）來停止時間
									clearInterval(count);
									// addClass() 方法向被选元素添加一个或多个类。
									$('.counter').addClass('hide')
									$('.preloader').addClass('active')
								}
							}, 500)

							setTimeout(
									function() {

										var startTime = new Date();
										count = setInterval(
												function() { // count = ID值
													document
															.getElementById('time').innerHTML = (((new Date() - startTime) / 1000)
															.toFixed(2));
												}, 1);

									}, 2500);

						});
	</script>
</body>
</html>