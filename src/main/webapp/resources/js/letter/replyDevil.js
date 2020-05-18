// $(document).ready(function () {
//	 
//	 
//	 
//	 
//	$('#submitbtn').click((e)=>{
//		
//		setInterval(() => {
//            $('.replyContentBox').css('transform','translateX(-700px)')
//            .css('transition','ease-in-out 2s').css('z-index','9999')
//
//
//        },200)
//        setTimeout(function(){
//           
//            $('.contentBox').css('display','none')
//            $('.replyContentBox').addClass('animate__fadeOutRight')
//            
//        },2500)
//
//        setTimeout(function(){
//            $('.replyContentBox').css('width','100px').css('height','80px')
//            $('.replyContentBox').css('display','none')
//       },3500)
//	})
//	
//	goToReply();
//	
////	}
// })
// 
// function goToReply(){
//	 
//	 document.forms[0].action = "<c:url value='/letter/sendReplyContent' /> ";
//	 document.forms[0].method = "POST";
//	 document.forms[0].submit();
// }