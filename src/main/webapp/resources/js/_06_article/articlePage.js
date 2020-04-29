function doFirst() {
	arrange = document.getElementById("arrange");
	searchForm = document.getElementById("searchForm");

	arrange.addEventListener("change", function() {
		searchForm.submit();
	});
}

window.addEventListener("load", doFirst);