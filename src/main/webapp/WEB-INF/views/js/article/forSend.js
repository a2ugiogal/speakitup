function doFirst(){
    letterContent = document.getElementById('letterContent');
    contentLength = document.getElementById('contentLength');
    submitbtn = document.getElementById('submitbtn');
    errorText = document.getElementById('errorText');
    
    letterContent.addEventListener('keyup',textlength);
    
//    submitbtn.addEventListener('click',check);

    
}

function textlength() {
    var lengthNo = letterContent.value.length
    contentLength.innerHTML = 250 - lengthNo;

    if(letterContent.value.length > 10){
        submitbtn.disabled = false;
//        errorText.style.visibility = 'hidden'
    }else{
        submitbtn.disabled = true;
    }
}

//function check(){
//	if(letterContent.value.length < 10){
//		errorText.style.visibility = 'visible';
//		errorText.style.color = 'red';
//		submitbtn.disabled = true;
//	}else{
//		errorText.style.visibility = 'hidden';
//	}
//}


window.addEventListener('load',doFirst);