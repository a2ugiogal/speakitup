$(document).ready(() => {
	
//	<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
	
    $('.angelLabel').find('input[type="checkbox"]').click((e)=>{
        e.preventDefault;
        xhr = new XMLHttpRequest();  
        if($(e.target).prop('checked') == true){
        	$.ajax({
        		url : "/speakitup/letter/myLetters/devil",
        		type : 'GET',
        		success : function(response) {
        			response = JSON.parse(response);
        			let letters = $('#showMyLetters');
        			let inner="";
        			
        			for(i=0;i<response.length;i++){
        				inner+="<div class='letterBoxDevil'>";
        				inner+="<div class='sendBoxDevil animated'>";
        				inner+="<h2>"+(i+1)+"</h2>";
        				inner+="<h2>"+response[i].letterTitle+"</h2>";
        				inner+="<h3>惡魔</h3>";
        				inner+="<h3>寄信內容</h3>";
        				inner+="<p>"+response[i].letterContent+"</p>";
        				inner+="<div class='sendBoxBotDevil'>";	
        				inner+="<div class='watchReply'>看回信</div>";
        				inner+="<div>";
        				inner+="<ul>";
        				inner+="<li>";
        				inner+="<label class='feedbackBtn'>";
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
        				inner+="<div class='replyBoxDevil animated'>";
        				inner+="<h3>回信內容</h3>";
        				inner+="<p>"+response[i].replyContent+"</p>";
        				inner+="<div class='back'>返回</div>";
        				inner+="</div>";
        				inner+="</div>";
        				
        			}
        			letters.html(inner);
        			$(".watchReply").click((e)=>{
        	        	
        	            e.preventDefault();
        	            if($(e.target).parent().parent().next().hasClass('fadeOutUp') == true){
        	                $(e.target).parent().parent().next().removeClass('fadeOutUp')
        	           
        	            }
        	            $(e.target).parent().parent().next().addClass('fadeInDown');
        	            $(e.target).parent().parent().next().css('z-index','1');
        	            $(e.target).parent().parent().css('z-index','-1');
        	        });


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
        	});
            $('body').css('background','black')
            $(e.target).parent().removeClass('angelLabel')
            $(e.target).parent().addClass('devilLabel')
            
            
        }else{
        	$.ajax({
        		url : "/speakitup/letter/myLetters/angel",
        		type : 'GET',
        		success : function(response) {
        			response = JSON.parse(response);
        			let letters = $('#showMyLetters');
        			let inner="";
        			for(i=0;i<response.length;i++){
        				inner+="<div class='letterBox'>";
        				inner+="<div class='sendBox animated'>";
        				inner+="<h2>"+(i+1)+"</h2>";
        				inner+="<h2>"+response[i].letterTitle+"</h2>";
        				inner+="<h3>惡魔</h3>";
        				inner+="<h3>寄信內容</h3>";
        				inner+="<p>"+response[i].letterContent+"</p>";
        				inner+="<div class='sendBoxBotAngel'>";	
        				inner+="<div class='watchReply'>看回信</div>";
        				inner+="<div>";
        				inner+="<ul>";
        				inner+="<li>";
        				inner+="<label class='feedbackBtnAngel'>";
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
        				inner+="<div class='replyBox animated'>";
        				inner+="<h3>回信內容</h3>";
        				inner+="<p>"+response[i].replyContent+"</p>";
        				inner+="<div class='back'>返回</div>";
        				inner+="</div>";
        				inner+="</div>";
        				
        			}
        			letters.html(inner);
        			$(".watchReply").click((e)=>{
        	        	
        	            e.preventDefault();
        	            if($(e.target).parent().parent().next().hasClass('fadeOutUp') == true){
        	                $(e.target).parent().parent().next().removeClass('fadeOutUp')
        	           
        	            }
        	            $(e.target).parent().parent().next().addClass('fadeInDown');
        	            $(e.target).parent().parent().next().css('z-index','1');
        	            $(e.target).parent().parent().css('z-index','-1');
        	        });


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

        	});
        	$('body').css('background','#fff')
            $(e.target).parent().removeClass('devilLabel')
            $(e.target).parent().addClass('angelLabel')

        }
        
        
        
    })
     
    
    
   
    
});

    
//function success(response,type){
//	alert();
//	 response = JSON.parse(response);
//	let letters = $('#showMyLetters');
//	let inner="";
////	if(response[0].length===0){
////		inner+="<tr>";
////		inner+="<td colspan='3' align='center'> 查無資料 </td>";
////		inner+="</tr>";
////	}
//	if(type == 'devil'){
//		
//		for(i=0;i<response.length;i++){
//			inner+="<div class='letterBoxDevil'>";
//			inner+="<div class='sendBoxDevil animated'>";
//			inner+="<h2>"+(i+1)+"</h2>";
//			inner+="<h2>"+response[i].letterTitle+"</h2>";
//			inner+="<h3>惡魔</h3>";
//			inner+="<h3>寄信內容</h3>";
//			inner+="<p>"+response[i].letterContent+"</p>";
//			inner+="<div class='sendBoxBotDevil'>";	
//			inner+="<div class='watchReply'>看回信</div>";
//			inner+="<div>";
//			inner+="<ul>";
//			inner+="<li>";
//			inner+="<label class='feedbackBtn'>";
//			inner+="<input type='checkbox'>";
//			inner+="<div class='iconBox'>";
//			inner+="<i class='far fa-handshake'></i>";
//			inner+=" </div>";
//			inner+="</label>";
//			inner+="</li>";
//			inner+="<li>";
//			inner+="<label class='hateBtn'>";
//			inner+="<input type='checkbox'>";
//			inner+="<div class='iconBox'>";
//			inner+="<i class='fas fa-exclamation-triangle'></i>";
//			inner+="</div>";
//			inner+="</label>";
//			inner+="</li>";
//			inner+="</ul>";
//			inner+="</div>";
//			inner+="</div>";
//			inner+="</div>";
//			inner+="<div class='replyBoxDevil animated fadeOutUp'>";
//			inner+="<h3>回信內容</h3>";
//			inner+="<p>"+response[i].replyContent+"</p>";
//			inner+="<div class='back'>返回</div>";
//			inner+="</div>";
//			inner+="</div>";
//			
//		}
//		letters.html(inner);
//	}if(type == 'angel'){
//		for(i=0;i<response.length;i++){
//			inner+="<div class='letterBox'>";
//			inner+="<div class='sendBox animated'>";
//			inner+="<h2>"+(i+1)+"</h2>";
//			inner+="<h2>"+response[i].letterTitle+"</h2>";
//			inner+="<h3>惡魔</h3>";
//			inner+="<h3>寄信內容</h3>";
//			inner+="<p>"+response[i].letterContent+"</p>";
//			inner+="<div class='sendBoxBotAngel'>";	
//			inner+="<div class='watchReply'>看回信</div>";
//			inner+="<div>";
//			inner+="<ul>";
//			inner+="<li>";
//			inner+="<label class='feedbackBtnAngel'>";
//			inner+="<input type='checkbox'>";
//			inner+="<div class='iconBox'>";
//			inner+="<i class='far fa-handshake'></i>";
//			inner+=" </div>";
//			inner+="</label>";
//			inner+="</li>";
//			inner+="<li>";
//			inner+="<label class='hateBtn'>";
//			inner+="<input type='checkbox'>";
//			inner+="<div class='iconBox'>";
//			inner+="<i class='fas fa-exclamation-triangle'></i>";
//			inner+="</div>";
//			inner+="</label>";
//			inner+="</li>";
//			inner+="</ul>";
//			inner+="</div>";
//			inner+="</div>";
//			inner+="</div>";
//			inner+="<div class='replyBox animated'>";
//			inner+="<h3>回信內容</h3>";
//			inner+="<p>"+response[i].replyContent+"</p>";
//			inner+="<div class='back'>返回</div>";
//			inner+="</div>";
//			inner+="</div>";
//			
//		}
//		letters.html(inner);
//		
//	}
//	
//	$(".watchReply").click((e)=>{
//    	alert(123);
//        e.preventDefault();
//        if($(e.target).parent().parent().next().hasClass('fadeOutUp') == true){
//            $(e.target).parent().parent().next().removeClass('fadeOutUp')
//       
//        }
//        $(e.target).parent().parent().next().addClass('fadeInDown');
//        $(e.target).parent().parent().next().css('z-index','1');
//        $(e.target).parent().parent().css('z-index','-1');
//    });
//	$('.back').click((e) => {
//    	alert(123);
//        e.preventDefault();
//        $(e.target).parent().addClass('fadeOutUp');
//        $(e.target).parent().removeClass('fadeInDown')
//
//        setTimeout(()=>{
//            $(e.target).parent().prev().css('z-index','1');
//            $(e.target).parent().css('z-index','-1');
//        },500)
//        
//    });
//}
//
//
//
