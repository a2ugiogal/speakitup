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

	
	allChecked = true;
	for (let i = 0; i < choose.length; i++) {
		if (!choose[i].checked) {
			allCheck.checked = false;
			allChecked = false;
		}
	}
	allCheck.checked = allChecked;
	totalPrice.innerText = totalMoney;

}

function checkShoppingCart(ShoppingCart) {
	if (ShoppingCart == null) {
		alert('購物車內無商品，前往購物')
	}
}

// 商品全選
function allChecked() {
	var chooseAll = document.getElementById("allCheck").checked;
	if ($(this).prop('checked') == true) {
		$('body').find('.choose').prop('checked', true);
		checkMoney();
	} else {
		$('body').find('.choose').prop('checked', false);
		checkMoney();
	}
	xhr = new XMLHttpRequest();
	$.ajax({
		 url : "/order/updateShoppingCart?cmd=CSA&chooseAll=" + chooseAll,
		 type : 'GET',
		 success : function(){}
		 });
}

//商品選擇
$('.choose').change((e)=>{
	var productFormatId = $(e.target).parent().prev().val();
	var choose = $(e.target).prop('checked');
	xhr = new XMLHttpRequest();
	 $.ajax({
	 url : "/order/updateShoppingCart?cmd=CHS&productFormatId=" + productFormatId +
	 "&choose=" + choose,
	 type : 'GET',
	 success : function(){}
	 });
})

// 更動數量
$('.singleQty').change((e)=>{
	var productPrice = $(e.target).parent().prev().text();
	var singleQty = $(e.target).val()
	var productFormatId = $(e.target).parent().parent().find('input').val();
	singleTotal = productPrice * singleQty
	$(e.target).parent().next().text(singleTotal);
	checkMoney();
	xhr = new XMLHttpRequest();
	 $.ajax({
	 url : "/order/updateShoppingCart?cmd=QTY&productFormatId=" + productFormatId +
	 "&newQty=" + singleQty,
	 type : 'GET',
	 success : function(){}
	 });
	 

})

// 更改規格
$('.changeFormat').change((e)=>{
	var newFormat = $(e.target).val()
	var productFormatId = $(e.target).parent().attr('id');
	 xhr = new XMLHttpRequest();
	 $.ajax({
	 url : "/order/updateShoppingCart?cmd=FMT&productFormatId=" + productFormatId +
	 "&newFmt=" + newFormat,
	 type : 'GET',
	 success : function(){}
	 });
	 
})
// 刪除商品
 $('.product-removal').click(function(){
	 var productFormatId = $(this).attr('id');
	  $(this).parent().remove();
	 checkMoney();
	 xhr = new XMLHttpRequest();
	 $.ajax({
	 url : "/order/updateShoppingCart?cmd=DEL&productFormatId=" + productFormatId,
	 type : 'GET',
	 success : function(){
		
	 }
	 });
	
	 })

