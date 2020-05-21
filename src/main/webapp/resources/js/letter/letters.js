$(document).ready(() => {
	if($('.letterBox').length > 0){
		$('#showMyLetters').css('display','grid')
	}else{
		$('#showMyLetters').css('display','inline')
	}
	watchReply();
	back();
	
    $('.angelLabel').find('input[type="checkbox"]').click((e)=>{

        e.preventDefault;
        xhr = new XMLHttpRequest();  
        if($(e.target).prop('checked') == true){
        	$.ajax({
        		url : "/letter/myLetters/devil",
        		type : 'POST',
        		success : function(response) {
        			if(response == "noLetters"){
        				$('.showAngelLetters').css('display','none')
//        				$('#showMyLetters').css('display','inline')
        			}
        			else{
        				success(response,"devil");
//        				$('#showMyLetters').css('display','grid')
        				$('.showDevilLetters').css('display','grid')
        			}
        		}
        	});
            $('body').css('background','black')
            $('.letter').css('color','#fff')
           
            $(e.target).parent().removeClass('angelLabel')
            $(e.target).parent().addClass('devilLabel')
        }else{
        	$.ajax({
        		url : "/letter/myLetters/angel",
        		type : 'POST',
        		success : function(response) {
        			if(response == "noLetters"){
        				$('.showDevilLetters').css('display','none')
//        				$('#showMyLetters').css('display','inline')
        			}
        			else{
        				success(response,"angel");
//        				$('#showMyLetters').css('display','grid')
        				$('.showAngelLetters').css('display','grid')
        			}
        		}

        	});
        	$('body').css('background','#fff')
        	$('.letter').css('color','black')
        	
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
		class3 = "newLettersDevil";
		class4 = "sendBoxBotDevil";
		class52 = "btnDivDevil";
		class5 = "btnDivDevilChecked";
		class6 = "feedbackBtn";
		class7 = "likeDevil";
		class8 = "likeFeedbackDevil";
		class9 = "hateDevil";
		class10 = "deleteFeedbackDevil";
		class11 = "replyBoxDevil";
	}else{
		class1 = "letterBox";
		class2 = "sendBox";
		class3 = "newLetters";
		class4 = "sendBoxBotAngel";
		class5 = "btnDiv";
		class6 = "feedbackBtnAngel";
		class7 = "likeAngel";
		class8 = "likeFeedbackAngel";
		class9 = "hateAngel";
		class10 = "deleteFeedbackAngel";
		class11 = "replyBox";
	}
	
	if(type == 'devil'){
		inner+="<div class='showDevilLetters'>";
	}else{
		inner+="<div class='showAngelLetters'>";
	}
	
	for(i=0;i<response.length;i++){
		inner+="<div class='"+class1+"'>";
		inner+="<div class='"+class2+"'>";
		if(i<5){
			inner+="<div class='"+class3+"'>";
			inner+="<i class='fas fa-bullhorn'></i></div>";
		}
		inner+="<p><h2>"+(i+1)+"</h2></p>";
		inner+="<p><h2>"+response[i].letterTitle+"</h2></p>";
		inner+="<p><h3>"+response[i].letterCategory+"</h3></p>";
		inner+="<p><h5>"+response[i].sendTime+"</h5></p>";
		inner+="<pre>"+response[i].letterContent+"</pre>";
		inner+="<div class='"+class4+"'>";	
		inner+="<div class='watchReply'>看回信</div>";
		if(type=="devil" && response[i].feedback == null){	
			inner+="<div class='"+class52+"' id='"+response[i].letterId+"'>";
		}else{
			inner+="<div class='"+class5+"' id='"+response[i].letterId+"'>";
		}
		inner+="<ul>";
		inner+="<li>";
		inner+="<label class='"+class6+"'>";
		if(response[i].feedback == 'like'){
			inner+="<input type='checkbox' checked='checked' class='"+class7+""+ response[i].letterId +"'>";
			inner+="<div class='iconBox' onclick='"+class8+"("+response[i].letterId+")'>";
			inner+="<i class='far fa-handshake'></i>";
			inner+="</div>";
		}else{
			inner+="<input type='checkbox' class='"+class7+""+ response[i].letterId +"'>";
			inner+="<div class='iconBox' onclick='"+class8+"("+response[i].letterId+")'>";
			inner+="<i class='far fa-handshake'></i>";
			inner+=" </div>";
		}
		inner+="</label>";
		inner+="</li>";
		inner+="<li>";
		inner+="<label class='hateBtn' >";
		if(response[i].feedback == 'dislike'){
			inner+="<input type='checkbox' checked='checked' class='"+class9+""+ response[i].letterId +"'>";
			inner+="<div class='iconBox' onclick='"+class10+"("+response[i].letterId+")'>";
			inner+="<i class='fas fa-exclamation-triangle'></i>";
		}else{
			inner+="<input type='checkbox' class='"+class9+""+ response[i].letterId +"'>";
			inner+="<div class='iconBox' onclick='"+class10+"("+response[i].letterId+")'>";
			inner+="<i class='fas fa-exclamation-triangle'></i>";
		}
		inner+="</div>";
		inner+="</label>";
		inner+="</li>";
		inner+="</ul>";
		inner+="</div>";
		inner+="</div>";
		inner+="</div>";
		inner+="<div class='"+class11+" animated'>";
		inner+="<p><h3>回信內容</h3></p>";
		inner+="<pre>"+response[i].replyContent+"</pre>";
		inner+="<div class='back'>返回</div>";
		inner+="</div>";
		inner+="</div>";
		}
		letters.html(inner);		
		watchReply();
		back();

}




//看回信內容
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

//返回
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

//天使信件的喜歡
function likeFeedbackAngel(id){
	$('.hateAngel'+id).prop('checked',false);
     xhr = new XMLHttpRequest();
     $.ajax({
 		url : "/letter/likeLetter?id=" + id,
 		type : "POST",
 		success : function(){}
 	});
     //如果按了不喜歡就不能有喜歡 兩個鍵不會同時一起壓下去
     
}

//惡魔信件的喜歡
function likeFeedbackDevil(id){
	$('.hateDevil'+id).prop('checked',false);
     xhr = new XMLHttpRequest();
     $.ajax({
 		url : "/letter/likeLetter?id=" + id,
 		type : "POST",
 		success : function(){}
 	});
     //如果按了不喜歡就不能有喜歡 兩個鍵不會同時一起壓下去
     
     if($('.likeDevil' + id).prop('checked') == true){
    	 $('body').find('#' + id).removeClass('btnDivDevilChecked').addClass('btnDivDevil')
     }else{
    	 $('body').find('#' + id).removeClass('btnDivDevil').addClass('btnDivDevilChecked')
     }
}

//天使信件的不喜歡
function deleteFeedbackAngel(id){
	$('.likeAngel'+id).prop('checked',false);
     xhr = new XMLHttpRequest();
     $.ajax({
 		url : "/letter/deleteLetter?id=" + id,
 		type : "POST",
 		success : function(){}
 	});
     
//     if($('.hate' + id).prop('checked') == true){
//    	 $('body').find('#' + id).removeClass('btnDivDevilChecked').addClass('btnDivDevil')
//     }else{
//    	 $('body').find('#' + id).removeClass('btnDivDevil').addClass('btnDivDevilChecked')
//     }
}

//惡魔信件的不喜歡
function deleteFeedbackDevil(id){
	$('.likeDevil'+id).prop('checked',false);
     xhr = new XMLHttpRequest();
     $.ajax({
 		url : "/letter/deleteLetter?id=" + id,
 		type : "POST",
 		success : function(){}
 	});
     
     if($('.hateDevil' + id).prop('checked') == true){
    	 $('body').find('#' + id).removeClass('btnDivDevilChecked').addClass('btnDivDevil')
     }else{
    	 $('body').find('#' + id).removeClass('btnDivDevil').addClass('btnDivDevilChecked')
     }
}

