//由<body>的onLoad事件處理函數觸發此函數
function doFirst() {
	document.getElementById("inputmemberId").focus(); // 將游標放在userId欄位內
}
function closeToast() {
	toast = document.getElementById("toast-email");
	toast.style.display = 'none';
}

window.addEventListener("load", doFirst);