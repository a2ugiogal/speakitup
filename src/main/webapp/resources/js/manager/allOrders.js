function doFirst() {
	orderRow = document.getElementsByClassName("orderRow");
	orderItems = document.getElementsByClassName("orderItems");
	orderWaitShip = document.getElementsByClassName("待出貨");
	orderAlreadyShip = document.getElementsByClassName("已出貨");
	orderFinish = document.getElementsByClassName("完成");
	all = document.getElementById("all");
	waitShip = document.getElementById("waitShip");
	alreadyShip = document.getElementById("alreadyShip");
	finish = document.getElementById("finish");

	for (let i = 0; i < orderRow.length; i++) {
		orderRow[i].addEventListener("click", function() {
			orderItems[i].style.display = "";
		});
	}

	all.addEventListener("click", select);
	waitShip.addEventListener("click", select);
	alreadyShip.addEventListener("click", select);
	finish.addEventListener("click", select);
}

function select(e) {
	$(".collapseOrder").collapse("hide");

	for (let i = 0; i < orderItems.length; i++) {
		orderItems[i].style.display = "none";
	}
	for (let i = 0; i < orderWaitShip.length; i++) {
		orderWaitShip[i].style.display = "none";
	}
	for (let i = 0; i < orderAlreadyShip.length; i++) {
		orderAlreadyShip[i].style.display = "none";
	}
	for (let i = 0; i < orderFinish.length; i++) {
		orderFinish[i].style.display = "none";
	}

	if (e.target.id == "waitShip") {
		for (let i = 0; i < orderWaitShip.length; i++) {
			orderWaitShip[i].style.display = "";
		}
		this.style.color = "#fff";
		this.style.background = "rgb(119, 99, 99)";
		alreadyShip.style.color = "rgb(117, 75, 75)";
		alreadyShip.style.background = "rgb(230, 230, 230)";
		finish.style.color = "rgb(117, 75, 75)";
		finish.style.background = "rgb(230, 230, 230)";
		all.style.color = "rgb(117, 75, 75)";
		all.style.background = "rgb(230, 230, 230)";
	} else if (e.target.id == "alreadyShip") {
		for (let i = 0; i < orderAlreadyShip.length; i++) {
			orderAlreadyShip[i].style.display = "";
		}
		waitShip.style.color = "rgb(117, 75, 75)";
		waitShip.style.background = "rgb(230, 230, 230)";
		this.style.color = "#fff";
		this.style.background = "rgb(119, 99, 99)";
		finish.style.color = "rgb(117, 75, 75)";
		finish.style.background = "rgb(230, 230, 230)";
		all.style.color = "rgb(117, 75, 75)";
		all.style.background = "rgb(230, 230, 230)";
	} else if (e.target.id == "finish") {
		for (let i = 0; i < orderFinish.length; i++) {
			orderFinish[i].style.display = "";
		}
		waitShip.style.color = "rgb(117, 75, 75)";
		waitShip.style.background = "rgb(230, 230, 230)";
		alreadyShip.style.color = "rgb(117, 75, 75)";
		alreadyShip.style.background = "rgb(230, 230, 230)";
		this.style.color = "#fff";
		this.style.background = "rgb(119, 99, 99)";
		all.style.color = "rgb(117, 75, 75)";
		all.style.background = "rgb(230, 230, 230)";
	} else {
		for (let i = 0; i < orderWaitShip.length; i++) {
			orderWaitShip[i].style.display = "";
		}
		for (let i = 0; i < orderAlreadyShip.length; i++) {
			orderAlreadyShip[i].style.display = "";
		}
		for (let i = 0; i < orderFinish.length; i++) {
			orderFinish[i].style.display = "";
		}
		waitShip.style.color = "rgb(117, 75, 75)";
		waitShip.style.background = "rgb(230, 230, 230)";
		alreadyShip.style.color = "rgb(117, 75, 75)";
		alreadyShip.style.background = "rgb(230, 230, 230)";
		finish.style.color = "rgb(117, 75, 75)";
		finish.style.background = "rgb(230, 230, 230)";
		this.style.color = "#fff";
		this.style.background = "rgb(119, 99, 99)";
	}
}

function closeCallapse() {

}

window.addEventListener("load", doFirst);
