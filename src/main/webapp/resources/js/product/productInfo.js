//按下加入購物車的小小動畫
$(document).ready(function() {
	$("#joinCart").click(function() {
		$(".cartIcon").change();
	});
});

// 登入浮動視窗
function loginModel() {
	$("#ignismyModal").modal("show");
}

