 $(document).ready(function(){
	
	$('#letterForm').submit(function(e){
		var form = this;	
		e.preventDefault();
			 $('.content').addClass('animate__backOutUp animate__slow');

	            setTimeout(() => {
	        			$('.fakeLetter').css('opacity','1');
	        			$('.fakeLetter').addClass('animate__fadeOutDown animate__slow');
	        		
	        	}, 1500);
	            
	            setTimeout(() => {
					form.submit();
				}, 3000);

	})
	
	
 })