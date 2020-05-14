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

/* AJAX(搜尋) */
$("#search-btn").click(function(e) {
	ajax();
});

/* AJAX(排序) */
$("#arrange").change(function (e) {
	ajax();
});

function ajax(){
	$.ajax({
		  type: "GET",
		  url: "/speakitup/article/showPageArticlesAjax",
		  data: {
		    search: $("#search").val(),
		    arrange:$('#arrange').val(),
		    categoryTitle: $("#categoryTitle").val(),
		    categoryName: $("#categoryName").val(),
		  },
		  dataType: "json",
		  success: function (response) {
		    var list = response;
		    let article_list = $("#article_list");
		    var htmlStr = "";
		    htmlStr += '<div class="col-11">';
		    $.each(list, function (i, map) {
		      if (i == 0) {
		        htmlStr += `<div class="nayma-timeline-block" id="top_article">`;
		      } else {
		        htmlStr += `<div class="nayma-timeline-block">`;
		      }
		      htmlStr += `<a href="/speakitup/article/showArticleContent/${map.article.articleId}" style="text-decoration: none;"> `;
		      htmlStr += `<div class="row nayma-timeline-content"> `;
		      htmlStr += `<div class="col-2 d-flex align-items-center justify-content-center">`;
		      htmlStr += `<img src="/speakitup/member/getUserImage/${map.article.authorId}" class="rounded-circle" width="150px" height="150px"/>`;
		      htmlStr += `</div>`;
		      htmlStr += `<div class="col-8">`;
		      htmlStr += `<h2 class="mt-2">${map.article.title}</h2>`;
		      if (map.article.category.categoryTitle == "惡魔") {
		        htmlStr += `<span class="badge mr-2 mt-1 text-white" style="background-color: #005caf;">${map.article.category.categoryTitle}</span> `;
		      } else {
		        htmlStr += `<span class="badge mr-2 mt-1 text-white" style="background-color: pink;">${map.article.category.categoryTitle}</span> `;
		      }
		      if (map.article.category.categoryName == "工作") {
		        htmlStr += `<span class="badge badge-info mr-2 mt-1">${map.article.category.categoryName}</span>`;
		      } else if (map.article.category.categoryName == "感情") {
		        htmlStr += `<span class="badge badge-danger mr-2 mt-1">${map.article.category.categoryName}</span>`;
		      } else if (map.article.category.categoryName == "生活") {
		        htmlStr += `<span class="badge badge-warning mr-2 mt-1">${map.article.category.categoryName}</span>`;
		      } else {
		        htmlStr += `<span class="badge badge-secondary mr-2 mt-1">${map.article.category.categoryName}</span>`;
		      }
		      /* 超過字變成... */
		      var len = 45; // 超過45個字以"..."取代
		      var content = "";
		      if (map.content.length > len) {
		        content =
		          map.content.replace(/<br>/g, "，").substring(0, len - 1) + "...";
		      } else {
		        content = map.content;
		      }
		      /* 超過字變成... */
		      htmlStr += `<p class="JQellipsis" style="color: #212529">${content}</p>`;
		      htmlStr += `<div class="row d-flex align-items-center mb-2">`;
		      /* DateFormat */
		      var formattedDate = new Date(map.article.publishTime);
		      var d = formattedDate.getDate();
		      if(formattedDate.getDate()<10){
		    	  d = "0" + d;
		      }
		      var m = formattedDate.getMonth();
		      m += 1; // JavaScript months are 0-11
		      if(formattedDate.getMonth()<10){
		    	  m = "0" + m;
		      }
		      var y = formattedDate.getFullYear();
		      /* DateFormat */
		      htmlStr += `<p class="my-0 col-4 text-secondary"> 發表於 ${y}-${m}-${d}</p>`;
		      htmlStr += `<i class="my-0 p-0 h5 bx bx-heart-circle col-1 text-danger"><span class="h6 ml-1 text-secondary"><i>${map.article.likes}</i></span></i>`;
		      htmlStr += `<i class="my-0 p-0 h5 bx bx-message-detail col-1 text-info"><span class="h6 ml-1 text-secondary"><i>`;
		      htmlStr += ` ${map.article.articleComments.length}`;
		      htmlStr += `</i></span></i>`;
		      htmlStr += `</div>`;
		      htmlStr += `</div>`;
		      htmlStr += `<div class="col-2 d-flex align-items-center justify-content-center">`;
		      /* 未完待續 */
		      if (map.article.fileName!=null) {
		    	  htmlStr += `<img src="/speakitup/article/getArticleImage/${map.article.articleId}" class="" width="145px" height="145px" />`;
			  }
		      /* 未完待續 */
		      htmlStr += `</div>`;
		      htmlStr += `</div>`;

		      htmlStr += `</a>`;
		      htmlStr += `</div>`;
		    });
		    htmlStr += `</div>`;
		    article_list.html(htmlStr);
		  },
		});
}


