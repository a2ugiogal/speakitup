$(document).ready(() => {
	
	watchReply();
	back();
	
    $('.angelLabel').find('input[type="checkbox"]').click((e)=>{

        e.preventDefault;
        xhr = new XMLHttpRequest();  
        if($(e.target).prop('checked') == true){
        	$.ajax({
        		url : "/speakitup/letter/myLetters/devil",
        		type : 'GET',
        		success : function(response) {
        			success(response,"devil");
        		}
        	});
            $('body').css('background','black')
            $(e.target).parent().removeClass('angelLabel')
            $(e.target).parent().addClass('devilLabel')
        }else{
        	$.ajax({
        		url : "/speakitup/letter/myLetters/angel",
        		type : 'GET',
        		success : function(response) {
        			success(response,"angel");
        		}

        	});
        	$('body').css('background','#fff')
            $(e.target).parent().removeClass('devilLabel')
            $(e.target).parent().addClass('angelLabel')
            

        }
    })
    
    
});

    
function success(response,type){
	
	response = JSON.parse(response);
	let letters = $('#showMyLetters');
	let inner="";
	if(type == 'devil'){
		class1 = "letterBoxDevil";
		class2 = "sendBoxDevil";
		class3 = "sendBoxBotDevil";
		class4 = "feedbackBtn";
		class5 = "replyBoxDevil";
	}else{
		class1 = "letterBox";
		class2 = "sendBox";
		class3 = "sendBoxBotAngel";
		class4 = "feedbackBtnAngel";
		class5 = "replyBox";
	}
		
	for(i=0;i<response.length;i++){
		inner+="<div class='"+class1+"'>";
		inner+="<div class='"+class2+"'>";
		inner+="<p><h2>"+(i+1)+"</h2></p>";
		inner+="<p><h2>"+response[i].letterTitle+"</h2></p>";
		inner+="<p><h3>惡魔</h3></p>";
		inner+="<p><h5>"+response[i].sendTime+"</h5></p>";
		inner+="<p>"+response[i].letterContent+"</p>";
		inner+="<div class='"+class3+"'>";	
		inner+="<div class='watchReply'>看回信</div>";
		inner+="<div class='btnDiv'>";
		inner+="<ul>";
		inner+="<li>";
		inner+="<label class='"+class4+"'>";
		if(response[i].feedback == 'like'){
			inner+="<input type='checkbox' checked='checked' class='like"+ response[i].letterId +"'>";
			inner+="<div class='iconBox' onclick='likeFeedback("+response[i].letterId+")'>";
			inner+="<i class='far fa-handshake'></i>";
			inner+="</div>";
		}else{
			inner+="<input type='checkbox' class='like"+ response[i].letterId +"'>";
			inner+="<div class='iconBox' onclick='likeFeedback("+response[i].letterId+")'>";
			inner+="<i class='far fa-handshake'></i>";
			inner+=" </div>";
		}
		inner+="</label>";
		inner+="</li>";
		inner+="<li>";
		inner+="<label class='hateBtn' >";
		inner+="<input type='checkbox' class='hate"+ response[i].letterId +"'>";
		inner+="<div class='iconBox' onclick='deleteFeedback("+response[i].letterId+")'>";
		inner+="<i class='fas fa-exclamation-triangle'></i>";
		inner+="</div>";
		inner+="</label>";
		inner+="</li>";
		inner+="</ul>";
		inner+="</div>";
		inner+="</div>";
		inner+="</div>";
		inner+="<div class='"+class5+" animated'>";
		inner+="<p><h3>回信內容</h3></p>";
		inner+="<p>"+response[i].replyContent+"</p>";
		inner+="<div class='back'>返回</div>";
		inner+="</div>";
		inner+="</div>";
		}
		letters.html(inner);		
		watchReply();
		back();

}

function watchReply(){
	$(".watchReply").click((e)=>{
        e.preventDefault();
        if($(e.target).parent().parent().next().hasClass('fadeOutUp') == true){
            $(e.target).parent().parent().next().removeClass('fadeOutUp')
       
        }
        $(e.target).parent().parent().next().addClass('fadeInDown');
        $(e.target).parent().parent().next().css('z-index','1');
        $(e.target).parent().parent().css('z-index','-1');
    });
}

function back(){
	$('.back').click((e) => {
        e.preventDefault();
        $(e.target).parent().addClass('fadeOutUp');
        $(e.target).parent().removeClass('fadeInDown')

        setTimeout(()=>{
            $(e.target).parent().prev().css('z-index','1');
            $(e.target).parent().css('z-index','-1');
        },500)
        
    });
}
//正面回饋鈕
//function likeFeedback(id){
//	$('#likeFeedback').click((e)=>{
//		e.preventDefault();
//		id = $('#likeLetterId').val();
//		alert(id)
//		$('.hate'+id).prop('checked',false);
//		xhr = new XMLHttpRequest();
//	     $.ajax({
//    		url : "/speakitup/letter/likeLetter?id=" + id,
//    		type : "POST",
//    		success : function() {
//    			
//    		}
//    	});
//	})
//	
//	
//
//
//
//
////覆面回饋鈕
////function deleteFeedback(id){
//		$('#hateFeedback').click((e)=>{
//			e.preventDefault();
//			id = $('#hateLetterId').val();
//			alert(id)
//			$('.like'+id).prop('checked',false);
//			xhr = new XMLHttpRequest();
//		     $.ajax({
//		 		url : "/speakitup/letter/deleteLetter?id=" + id,
//		 		type : "POST",
//		 		success : function(){
//		 		}
//		 	});
//		})
//	
////}

function likeFeedback(id){
	$('.hate'+id).prop('checked',false);
     xhr = new XMLHttpRequest();
     $.ajax({
 		url : "/speakitup/letter/likeLetter?id=" + id,
 		type : "POST",
 		success : function(){}
 	});
//     $("#likeModal").modal("hide");
     //如果按了不喜歡就不能有喜歡 兩個鍵不會同時一起壓下去

	
}

//覆面回饋鈕
function deleteFeedback(id){
	$('.like'+id).prop('checked',false);
     xhr = new XMLHttpRequest();
     $.ajax({
 		url : "/speakitup/letter/deleteLetter?id=" + id,
 		type : "POST",
 		success : function(){}
 	});
}

