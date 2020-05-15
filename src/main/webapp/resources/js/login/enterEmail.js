function doFirst() {
	submitbtn = document.getElementById('submitbtn');
	emailInput = document.getElementById('emailInput');
	emailError = document.getElementById('emailError');

	submitbtn.addEventListener('click', checkEmail);
	emailInput.addEventListener('focus', disabledBtn)
}

function checkEmail() {
	if (!emailInput.value.includes('@')) {
		emailError.innerText = "Email格式不符";
		emailError.style.display = 'block';
		emailError.style.color = 'red';
		submitbtn.disabled = true;
	} else {
		xhr = new XMLHttpRequest();
		xhr.open("GET", "/member/checkEmail?email="
				+ emailInput.value, false);
		xhr.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		xhr.send();
		if (xhr.responseText == "true") {
			emailError.style.display = 'none';
			submitbtn.disabled = false;
			alert("請前往信箱確認信件");
		} else {
			emailError.innerText = "無此信箱，請確認";
			emailError.style.display = 'block';
			emailError.style.color = 'red';
			submitbtn.disabled = true;
		}
	}
}

function disabledBtn() {
	submitbtn.disabled = false;
}

window.addEventListener('load', doFirst);