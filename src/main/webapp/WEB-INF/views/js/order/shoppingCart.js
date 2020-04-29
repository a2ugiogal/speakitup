function doFirst() {
	count = document.getElementsByClassName("count");
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

window.addEventListener("load", doFirst);
