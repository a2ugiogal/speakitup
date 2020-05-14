function doFirst() {
	allCheck = document.getElementById("allCheck");
	choose = document.getElementsByClassName("choose");
	
	for (let i = 0; i < choose.length; i++) {
		choose[i].addEventListener("change", checkMoney);
	}
	allCheck.addEventListener("change", allChecked);
	checkMoney();
}

window.addEventListener("load", doFirst);

// 計算總金額(有勾選的)
function checkMoney() {
	singleTotal = document.getElementsByClassName("singleTotal");
	totalPrice = document.getElementById("totalPrice");
	let totalMoney = 0;
	for (let i = 0; i < choose.length; i++) {
		if (choose[i].checked) {
			totalMoney += parseInt(singleTotal[i].innerText);
		}

	}

	if (totalMoney != 0) {
		allCheck.checked = true;
	} else {
		allCheck.checked = false;
	}
	totalPrice.innerText = totalMoney;

}

function checkShoppingCart(ShoppingCart) {
	if (ShoppingCart == null) {
		alert('購物車內無商品，前往購物')
	}
}

// 商品全選
function allChecked() {
	if ($(this).prop('checked') == true) {
		$('body').find('.choose').prop('checked', true);
		checkMoney();
	} else {
		$('body').find('.choose').prop('checked', false);
		checkMoney();
	}
}

// 更動數量
$('.singleQty').change((e)=>{
	var productPrice = $(e.target).parent().prev().text();
	var singleQty = $(e.target).val()
	var productFormatId = $(e.target).attr('id').replace("newQty","");
	alert(productFormatId)
	xhr = new XMLHttpRequest();
	 $.ajax({
	 url : "/speakitup/order/updateShoppingCart?cmd=QTY&productFormatId=" + productFormatId +
	 "&newQty=" + singleQty,
	 type : 'POST',
	 success : function(){}
	 });
	 singleTotal = productPrice * singleQty
		$(e.target).parent().next().text(singleTotal);
	
	checkMoney();

})

//刪除商品
//$('.remove-product').click((e)=>{
//	var productFormatId = $(e.target).parent().parent().find('.product-format').attr('id');
//	alert(productFormatId)
//	
////	if(productFormatId){
////		productFormatId = 0;
////	}
//	xhr = new XMLHttpRequest();
//	 $.ajax({
//	 url : "/speakitup/order/updateShoppingCart?cmd=DEL&productFormatId=" + productFormatId,
//	 type : 'POST',
//	 success : function(){}
//	 });
//	 $(e.target).parent().parent().remove();
//		checkMoney();
//})

//更改規格
$('.changeFormat').change((e)=>{
	var newFormat = $(e.target).val()
	alert(newFormat)
})
	 
/* 更改購物車AJAX */
// function deleteCart(formatId) {
//
// xhr = new XMLHttpRequest();
// $.ajax({
// url : "/speakitup/order/updateShoppingCart?cmd=DEL&productFormatId=" +
// formatId,
// type : 'GET',
// success : function(){}
// });
//	
// }
//
// function modifyQuantity(key, index) {
//
// var x = "newQty" + index
// var newQty = document.getElementById(x).value;
//
// productPrice = $('#'+ x).parent().prev().text();
//	
// xhr = new XMLHttpRequest();
// $.ajax({
// url : "/speakitup/order/updateShoppingCart?cmd=QTY&productFormatId=" + key +
// "&newQty=" + newQty,
// type : 'GET',
// success : function(){}
// });
// }
//
// function modifyFormat(key, index){
// var x = "newFmt" + index
// var newFmt = document.getElementById(x).value;
//
// xhr = new XMLHttpRequest();
// $.ajax({
// url : "/speakitup/order/updateShoppingCart?cmd=FMT&productFormatId=" + key +
// "&newFmt=" + newFmt,
// type : 'GET',
// success : function(){}
// });
// }
//
// function changeChoose(key, index){
// var choose = document.getElementsByClassName("choose")[index].checked;
//
// xhr = new XMLHttpRequest();
// $.ajax({
// url : "/speakitup/order/updateShoppingCart?cmd=CHS&productFormatId=" + key +
// "&choose=" + choose,
// type : 'GET',
// success : function(){}
// });
// }
//
// function changeAll(){
// var chooseAll = document.getElementById("allCheck").checked;
//
// xhr = new XMLHttpRequest();
// $.ajax({
// url : "/speakitup/order/updateShoppingCart?cmd=CSA&chooseAll=" + chooseAll,
// type : 'GET',
// success : function(){}
// });
// }

// function checkMoneyAfter(){
// singleTotal = document.getElementsByClassName("singleTotal");
// totalPrice = document.getElementById("totalPrice");
//	
// totalPrice = totalPrice.innerText;
// productPrice =
// alert(totalPrice)
//	
// totalPriceNew = totalPrice +
// }

