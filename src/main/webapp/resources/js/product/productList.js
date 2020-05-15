function doFirst() {
	nowPage = document.getElementById("nowPage");
	pageForm = document.getElementById("pageForm");
	nowPage.addEventListener("change", function() {
		pageForm.submit();
	});
}

window.addEventListener("load", doFirst);

/* 超過字變成... */
$(function() {
	var len = 100; // 超過140個字以"..."取代
	$(".card-text").each(
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

/* AJAX(排序) */
$("#arrange").change(function(e) {
	ajax();
});

function ajax() {
	  $.ajax({
	    type: "GET",
	    url: "/product/showPageProductsAjax",
	    data: {
	      arrange: $("#arrange").val(),
	      search: $("#search").val(),
	      categoryTitle: $("#categoryTitle").val(),
	      categoryName: $("#categoryName").val(),
	    },
	    dataType: "json",
	    success: function (response) {
	      /* 下拉式選單(頁碼)->1 */
	      options = document.getElementsByClassName("options");
	      arrangeNew = document.getElementsByClassName("arrangeNew");
	      options[0].selected = true;
	      for (let i = 0; i < arrangeNew.length; i++) {
	        arrangeNew[i].value = $("#arrange").val();
	      }
	      /* 隱藏上頁、顯示下頁 */
	      pageItem = document.getElementsByClassName("page-item");
	      pageItem[0].style.visibility= 'hidden';
	      pageItem[1].style.visibility= 'visible';
	      /* 改變上下頁路徑(pageNo、arrange) */
	      pageLink = document.getElementsByClassName("page-link");
	      var hrefStr = pageLink[1].href;
	      var longPart = hrefStr.split("?");
	      var part = longPart[1].split("&");
	      var hrefNew = "";
	      hrefNew += longPart[0]+"?";
	      hrefNew += "pageNo=2&";
	      hrefNew += part[1]+"&";
	      hrefNew += "arrange="+$("#arrange").val()+"&";
	      hrefNew += part[3]+"&";
	      hrefNew += part[4];
	      pageLink[1].href = hrefNew;
	      /* 商品列顯示 */
	      var list = response;
	      let product_list = $("#product_list");
	      var htmlStr = "";
	      $.each(list, function (i, map) {
	        htmlStr += `<a href="/product/showProductInfo/${map.product.productId}" style="text-decoration: none;">`;
	        htmlStr += `<div class="col-lg-6 col-xl-4 p-0 py-3 d-flex justify-content-center">`;
	        htmlStr += `<div class="card text-center h-100 border-0 box-shadow">`;
	        htmlStr += `<img src="/product/getProductImage/${map.product.productId}" class="card-img-top img_high" />`;
	        htmlStr += `<div class="card-body">`;
	        htmlStr += `<h5 class="card-title" style="font-weight: bold;">${map.product.productName}</h5>`;
	        /* 超過字變成... */
	        var len = 100; // 超過45個字以"..."取代
	        var content = "";
	        if (map.content.length > len) {
	          content =
	            map.content.replace(/<br>/g, "，").substring(0, len - 1) + "...";
	        } else {
	          content = map.content;
	        }
	        htmlStr += `<p class="card-text" style="color: #495057">${content}</p>`;
	        /* 超過字變成... */
	        htmlStr += `</div>`;
	        htmlStr += `<div class="card-footer border-top-0 bg-white mb-3">`;
	        htmlStr += `<div class="btn-group" role="group" aria-label="First group"></div>`;
	        htmlStr += ` <span style="color: #495057 !important; font-size: 20px">$ ${map.product.price}</span><a></a>`;
	        htmlStr += `</div>`;
	        htmlStr += `</div>`;
	        htmlStr += `</div>`;
	        htmlStr += `</a>`;
	      });
	      product_list.html(htmlStr);
	    },
	  });
	}