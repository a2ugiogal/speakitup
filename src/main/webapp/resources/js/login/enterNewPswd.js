function doFirst(){
	passwordError = document.getElementById("passwordError");
	enterPassword = document.getElementById("enterPassword");
	checkPassword = document.getElementById("checkPassword");
	checkbtn = document.getElementById("checkbtn");

	enterPassword.addEventListener("blur",check)
	checkPassword.addEventListener("blur",checkpswd);
	checkbtn.addEventListener("click",btncheckpswd);
	
	enterPassword.addEventListener("change",hideText)
	checkPassword.addEventListener("change",hideText);
	
	
	
}

function check(){
	if (enterPassword.value != checkPassword.value && checkPassword.value != "") {
	    passwordError.style.display = "block";
	    passwordError.style.color = "red";
	    checkPassword.value = "";
	    
	  } else {
	    passwordError.style.display = "none";
	    checkbtn.disabled = false;
	  }
}

function checkpswd(){
	if(enterPassword.value != checkPassword.value){
		passwordError.style.display = "block";
		passwordError.style.color = "red";
		checkPassword.value = "";
	}else {
	    passwordError.style.display = "none";
	    checkbtn.disabled = false;
	  }
}


function btncheckpswd(){
	if (enterPassword.value == checkPassword.value && checkPassword.value != ""){
		passwordError.style.display = "none";
		checkbtn.disabled = false; 
		
	}else{
		checkbtn.disabled = true;
		 	passwordError.style.display = "block";
		    passwordError.style.color = "red";
	}
}

function hideText(){
	passwordError.style.display = "none";
	checkbtn.disabled = false;
}

window.addEventListener("load",doFirst);