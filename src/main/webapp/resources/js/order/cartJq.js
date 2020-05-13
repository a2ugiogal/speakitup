$(document).ready(() => {
	
	$('.singleQty').change((e)=>{
		var newqty = $(e.target).val()
		var productPrice = $(e.target).parent().prev().text();
		var singleTotal = $(e.target).parents().next().text();
		var newSingleTotal = newqty * productPrice		
		alert(singleTotal)
		alert(newSingleTotal)
		
//		singleTotal = newSingleTotal;
//		$(e.target).parents().find('.singleTotal').text() = newSingleTotal;
		
//		singleTotal.innerText  = singleTotal2
	})
	
})
