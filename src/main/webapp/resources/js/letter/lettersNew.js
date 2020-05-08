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
		inner+="<h2>"+(i+1)+"</h2>";
		inner+="<h2>"+response[i].letterTitle+"</h2>";
		inner+="<h3>惡魔</h3>";
		inner+="<h3>寄信內容</h3>";
		inner+="<p>"+response[i].letterContent+"</p>";
		inner+="<div class='"+class3+"'>";	
		inner+="<div class='watchReply'>看回信</div>";
		inner+="<div>";
		inner+="<ul>";
		inner+="<li>";
		inner+="<label class='"+class4+"'>";
		inner+="<input type='checkbox'>";
		inner+="<div class='iconBox'>";
		inner+="<i class='far fa-handshake'></i>";
		inner+=" </div>";
		inner+="</label>";
		inner+="</li>";
		inner+="<li>";
		inner+="<label class='hateBtn'>";
		inner+="<input type='checkbox'>";
		inner+="<div class='iconBox'>";
		inner+="<i class='fas fa-exclamation-triangle'></i>";
		inner+="</div>";
		inner+="</label>";
		inner+="</li>";
		inner+="</ul>";
		inner+="</div>";
		inner+="</div>";
		inner+="</div>";
		inner+="<div class='"+class5+" animated'>";
		inner+="<h3>回信內容</h3>";
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

