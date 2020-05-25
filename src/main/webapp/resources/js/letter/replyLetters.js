 $(document).ready(function () {
	 
	$('#letterReplyForm').submit(function(e){
		var form = this;	
		e.preventDefault();
		setInterval(function(){
            $('.replyContentBox').css('transform','translateX(-700px)')
            .css('transition','ease-in-out 2s').css('z-index','9999')

        },200)
        
        setTimeout(function(){
            $('.letterCard').addClass('animate__fadeOutUp animate__slow')
       },2500)
       
        setTimeout(function(){
	        			$('.fakeLetter').css('opacity','1');
	        			$('.fakeLetter').addClass('animate__fadeOutDown animate__slower');
	        		
	        	}, 4000);
       
       setTimeout(function(){
			form.submit();
		}, 5000);
	})
	
	
	
 })
// 
// function goToReply(){
//	 
//	 document.forms[0].action = "<c:url value='/letter/sendReplyContent' /> ";
//	 document.forms[0].method = "POST";
//	 document.forms[0].submit();
// }