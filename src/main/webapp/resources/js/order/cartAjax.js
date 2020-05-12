/*更改購物車AJAX*/
function deleteCart(formatId) {
	alert(formatId)
	xhr = new XMLHttpRequest();
	$.ajax({
	url : "/speakitup/order/updateShoppingCart?cmd=DEL&productFormatId=" + formatId,
	type : 'POST',
	success : function(){}
});
}

function modifyQuantity(key, index) {
	alert(key)
	alert(index)
	xhr = new XMLHttpRequest();
	$.ajax({
	url : "/speakitup/order/updateShoppingCart?cmd=QTY&productFormatId=" + key + "&newQty=" + index,
	type : 'POST',
	success : function(){}
});
}

function modifyFormat(key, index){
	alert(key)
	alert(index)
	xhr = new XMLHttpRequest();
	$.ajax({
	url : "/speakitup/order/updateShoppingCart?cmd=FMT&productFormatId=" + key + "&newFmt=" + index,
	type : 'POST',
	success : function(){}
});
}

function changeChoose(key, index){
	alert(key)
	alert(index)
	var choose = document.getElementsByClassName("choose")[index].checked;
	xhr = new XMLHttpRequest();
	$.ajax({
	url : "/speakitup/order/updateShoppingCart?cmd=CHS&productFormatId=" + key + "&choose=" + choose,
	type : 'POST',
	success : function(){}
});
}

function changeAll(){
	var chooseAll = document.getElementById("allCheck").checked;
	xhr = new XMLHttpRequest();
	$.ajax({
	url : "/speakitup/order/updateShoppingCart?cmd=CSA&chooseAll=" + chooseAll,
	type : 'POST',
	success : function(){}
});
}
