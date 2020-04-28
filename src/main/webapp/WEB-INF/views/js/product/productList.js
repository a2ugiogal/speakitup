function doFirst() {
	nowPage = document.getElementById("nowPage");
	pageForm = document.getElementById("pageForm");
	arrange = document.getElementById("arrange");
	searchForm = document.getElementById("searchForm");

	arrange.addEventListener("change", function() {
		searchForm.submit();
	});
	nowPage.addEventListener("change", function() {
		pageForm.submit();
	});
}

window.addEventListener("load", doFirst);
