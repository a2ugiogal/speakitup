function doFirst() {
	allCheck = document.getElementById("allCheck");
	choose = document.getElementsByClassName("choose");

	for (let i = 0; i < choose.length; i++) {
		choose[i].addEventListener("change", checkMoney);
	}

	checkMoney();
	
}

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

	totalPrice.innerText = totalMoney;

	// 檢查全選
	allChecked = true;
	for (let i = 0; i < choose.length; i++) {
		if (!choose[i].checked) {
			allCheck.checked = false;
			allChecked = false;
		}
	}
	allCheck.checked = allChecked;
}

function checkShoppingCart(ShoppingCart) {
	if (ShoppingCart == null) {
		alert('購物車內無商品，前往購物')
	}
}

/*更改購物車AJAX*/
function deleteCart(formatId) {
	alert(formatId)
//	checkMoney();
	xhr = new XMLHttpRequest();
	$.ajax({
	url : "/speakitup/order/updateShoppingCart?cmd=DEL&productFormatId=" + formatId,
	type : 'GET',
	success : function(){}
});
	
}

function modifyQuantity(key, index) {

	var x = "newQty" + index
	var newQty = document.getElementById(x).value;
	alert(newQty)
	productPrice = $('#'+ x).parent().prev().text();
	
	xhr = new XMLHttpRequest();
	$.ajax({
	url : "/speakitup/order/updateShoppingCart?cmd=QTY&productFormatId=" + key + "&newQty=" + newQty,
	type : 'GET',
	success : function(){}
});
}

function modifyFormat(key, index){
	var x = "newFmt" + index
	var newFmt  = document.getElementById(x).value;
	alert(newFmt)
//	checkMoney();
	xhr = new XMLHttpRequest();
	$.ajax({
	url : "/speakitup/order/updateShoppingCart?cmd=FMT&productFormatId=" + key + "&newFmt=" + newFmt,
	type : 'GET',
	success : function(){}
});
}

function changeChoose(key, index){
	var choose = document.getElementsByClassName("choose")[index].checked;
//	checkMoney();
	xhr = new XMLHttpRequest();
	$.ajax({
	url : "/speakitup/order/updateShoppingCart?cmd=CHS&productFormatId=" + key + "&choose=" + choose,
	type : 'GET',
	success : function(){}
});
}

function changeAll(){
	var chooseAll = document.getElementById("allCheck").checked;
//	checkMoney();
	xhr = new XMLHttpRequest();
	$.ajax({
	url : "/speakitup/order/updateShoppingCart?cmd=CSA&chooseAll=" + chooseAll,
	type : 'GET',
	success : function(){}
});
}

//function checkMoneyAfter(){
//	singleTotal = document.getElementsByClassName("singleTotal");
//	totalPrice = document.getElementById("totalPrice");
//	
//	totalPrice = totalPrice.innerText;
//	productPrice =  
//	alert(totalPrice)
//	
//	totalPriceNew = totalPrice + 
//}


window.addEventListener("load", doFirst);

