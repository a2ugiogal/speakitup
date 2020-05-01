function doFirst(){
	submitbtn = document.getElementById('submitbtn');
	emailInput = document.getElementById('emailInput');
	emailError = document.getElementById('emailError');
	
	submitbtn.addEventListener('click',checkEmail);
	emailInput.addEventListener('focus',disabledBtn)
}

function checkEmail(){
	if(!emailInput.value.includes('@')){
		emailError.style.display = 'block';
		emailError.style.color = 'red';
		submitbtn.disabled = true;
	}else{
		emailError.style.display = 'none';
		submitbtn.disabled = false;
		alert("請前往信箱確認信件");
	}
}

function disabledBtn(){
	submitbtn.disabled = false;
}

window.addEventListener('load',doFirst);