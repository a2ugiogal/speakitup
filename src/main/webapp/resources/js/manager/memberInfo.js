$(document).ready(function(){
	$('#getArticles').css('background','rgb(117, 75, 75)').css('color','#fff')
})


//封鎖帳號跟解除封鎖帳號
$('.Reportdeletebutton').click(function(e){
	var type = $(e.target).text();
	reportAjax(type);
})


function reportAjax(type){
	var id = $('#memberId').val();
	if(type == "封鎖帳號"){
		xhr = new XMLHttpRequest(); 
		$.ajax({
      		url : "/member/changeMemberStatus/" + id + "?memberLock=封鎖帳號",
      		type : 'POST',
      		success : function() {
      			$('.Reportdeletebutton').text('解除封鎖');
      		}
		
      	});
		
	}if(type=="解除封鎖"){
		xhr = new XMLHttpRequest();
		$.ajax({
      		url : "/member/changeMemberStatus/" + id + "?memberLock=解除封鎖",
      		type : 'POST',
      		success : function() {
      			$('.Reportdeletebutton').text('封鎖帳號');
      		}
      	});
		
	}
	
	}



$('#getComments').click((e)=>{
	var type = "comment";
	getMemberInfoAjax(type);
	$(e.target).parent().parent().find('.nav-link:not(#getComments)').css('background','#F1F1F1').css('color','rgb(117, 75, 75)');
	$(e.target).css('background','rgb(117, 75, 75)').css('color','#fff')
})

$('#getArticles').click((e)=>{
	var type = "article";
	getMemberInfoAjax(type);
	$(e.target).parent().parent().find('.nav-link:not(#getArticles)').css('background','#F1F1F1').css('color','rgb(117, 75, 75)');
	$(e.target).css('background','rgb(117, 75, 75)').css('color','#fff')
})

$('#getDeletedArticles').click((e)=>{
	var type = "deleteArticle";
	getMemberInfoAjax(type);
	$(e.target).parent().parent().find('.nav-link:not(#getDeletedArticles)').css('background','#F1F1F1').css('color','rgb(117, 75, 75)');
	$(e.target).css('background','rgb(117, 75, 75)').css('color','#fff')
})

$('#getDeletedComment').click((e)=>{
	var type = "deleteComment";
	getMemberInfoAjax(type);
	$(e.target).parent().parent().find('.nav-link:not(#getDeletedComment)').css('background','#F1F1F1').css('color','rgb(117, 75, 75)');
	$(e.target).css('background','rgb(117, 75, 75)').css('color','#fff')
})



//ajax傳值的部分
function getMemberInfoAjax(cmd){
	
	var id = $('#memberId').val();
	
	if(cmd == "comment"|| cmd == "deleteComment"){
		xhr = new XMLHttpRequest(); 
		$.ajax({
				url : "/member/showManageMemberInfo/" + id + "?cmd=" + cmd,
      		type : 'POST',
      		success : function(response) {
      			$('#listNo').text("留言編號");
      			var list = response;
      			let memberInfo_list = $('#memberInfo_list');
      			var inner = "";
      			 $.each(list, function (i, map){
      				 
      				inner+= `<a href="/article/showReportInfo/${map.comment.commentId}/comment" style="text-decoration: none; color: black;">`;
          			inner+= `<div class="row">`;
          			inner+= `<div class="col-3 d-flex justify-content-center align-items-center my-2">${map.comment.commentId}</div>`;
          			inner+= `<div class="col-3 d-flex justify-content-center align-items-center my-2">${map.comment.publishTime}`;
          			inner+=`</div>`;
        			inner+= `<div class="col-3 d-flex justify-content-center align-items-center my-2">${map.comment.content}</div>`;
        			inner+= `<div class="col-3 d-flex justify-content-center align-items-center my-2">${map.reportNum}</div>`;
        			inner+=`</div></a>`
      			 })
      			memberInfo_list.html(inner);
      		}
		
      	});
	
	}
	if(cmd == "article" || cmd == "deleteArticle"){
		xhr = new XMLHttpRequest(); 
		$.ajax({
				url : "/member/showManageMemberInfo/" + id + "?cmd=" + cmd,
				type : 'POST',
				success : function(response) {
					
	      			$('#listNo').text("文章編號");
	      			var list = response;
	      			let memberInfo_list = $('#memberInfo_list');
	      			var inner = "";
	      			 $.each(list, function (i, map){
	      				 
	      				inner+= `<a href="/article/showReportInfo/${map.article.articleId}/article" style="text-decoration: none; color: black;">`;
	      				inner+= `<div class="row">`;
	      				inner+= `<div class="col-3 d-flex justify-content-center align-items-center my-2">${map.article.articleId}</div>`;
	      				inner+= `<div class="col-3 d-flex justify-content-center align-items-center my-2">${map.article.publishTime}`;
	      				inner+=`</div>`;
	    				inner+= `<div class="col-3 d-flex justify-content-center align-items-center my-2">${map.article.title}</div>`;
	    				inner+= `<div　class="col-3 d-flex justify-content-center align-items-center my-2">${map.reportNum}</div>`;
	    				inner+=`</div></a>`;
	
	      			 })
	      			 memberInfo_list.html(inner);
      		}
		
      	});
		
	}
}

