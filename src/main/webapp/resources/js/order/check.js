function doFirst() {
	singlePrice = document.getElementsByClassName("singlePrice");

	let totalMoney = 0;
	for (let i = 0; i < singlePrice.length; i++) {
		totalMoney += parseInt(singlePrice[i].innerText);
	}
	totalPrice.innerText = totalMoney;
}
window.addEventListener("load", doFirst);
