<<<<<<< HEAD



function addShoppinCart(qty,content1,content2) {
	xhr = new XMLHttpRequest();
	$.ajax({
		url : "/speakitup/order/shoppingCart?qty=" + qty.value+ "&content1="
		+content1.value +"&content2=" + content2.value,
		type : 'POST',
		success : function() {}
=======
//按下加入購物車的小小動畫
$(document).ready(function() {
	$("#joinCart").click(function() {
		$(".cartIcon").change();
>>>>>>> d6feb26c51c61c420a4be8862e508af60ad7b78b
	});
	addCartAnimation()
}

function addCartnoContent2(qty,content1){
	xhr = new XMLHttpRequest();
	$.ajax({
	url : "/speakitup/order/shoppingCart?qty=" + qty.value + "&content1=" + content1.value,
	type : 'POST',
	success : function() {}
});
	addCartAnimation()
}

function addCartQtyOnly(qty){
	xhr = new XMLHttpRequest();
	$.ajax({
	url : "/speakitup/order/shoppingCart?qty=" + qty.value,
	type : 'POST',
	success : function() {}
});
	addCartAnimation()
}


function addCartAnimation(){
	var cart = $('.addToCartLoc');
	var imgtodrag = $('body').find('.productImg').find('img').eq(0);
	if (imgtodrag) {
		var imgclone = imgtodrag.clone().offset({
			top : imgtodrag.offset().top,
			left : imgtodrag.offset().left
		}).css({
			'opacity' : '0.8',
			'position' : 'absolute',
			'height' : '150px',
			'width' : '150px',
			'z-index' : '9999'
		}).appendTo($('body')).animate({
			'top' : cart.offset().top + 10,
			'left' : cart.offset().left + 10,
			'width' : 75,
			'height' : 75
		},800, 'easeInOutExpo');

		imgclone.animate({
			'width' : 0,
			'height' : 0
		}, function() {
			$(this).detach()
		});
	}
}
<<<<<<< HEAD

function buyNow() {
	buyForm = document.getElementById("buyForm");
	buyForm.action = "<spring:url value='/order/checkOrder' />";
	buyForm.method = "GET";
	buyForm.submit();
}

=======
>>>>>>> d6feb26c51c61c420a4be8862e508af60ad7b78b

