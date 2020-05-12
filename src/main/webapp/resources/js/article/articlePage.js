function doFirst() {
	arrange = document.getElementById("arrange");
	searchForm = document.getElementById("searchForm");

	arrange.addEventListener("change", function() {
		searchForm.submit();
	});
}
window.addEventListener("load", doFirst);

/* 登入浮動視窗 */
function loginModel() {
	$("#ignismyModal").modal("show");
}

/* 新增文章效果 */
$("#addArticleBtn").hover(function() {
	$("#showHint").toggle(650);
});

/* 超過字變成... */
$(function() {
	var len = 45; // 超過140個字以"..."取代
	$(".JQellipsis").each(
			function(i) {
				if ($(this).text().length > len) {
					var text = $(this).html().replace(/<br>/g, "，").substring(
							0, len - 1)
							+ "...";
					$(this).text(text);
				} else {
					var text = $(this).html().replace(/<br>/g, "，");
					text = text.substring(0, text.length - 1);
					$(this).text(text);
				}
			});
});
