function doFirst(){
	contentBoxHappy = document.getElementsByClassName('contentBoxHappy');
	contentBoxSad = document.getElementsByClassName('contentBoxSad');
	
	contentBoxHappy.style.display = 'none';
	contentBoxSad.style.display = 'none';
}

window.addEventListener('load',doFirst);