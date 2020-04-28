$(document).ready(function () {
    $(".wholeContent").click(function (e) { 
        e.preventDefault();
        $(this).parent().css('opacity','0').css('transform-style', 'preserve-3d').css('transition','0.8s')
        .css('transform','rotateX(360deg)')
        $(this).parent().next().css('opacity','1');
        
    });
    
    $('.replyContent').click(function (e) { 
        e.preventDefault();
        if($(this).prev().css('opacity') == '0'){
            $(this).prev().css('opacity','1')
           $(this).css('opacity','0').css('transform-style', 'preserve-3d').css('transition','0.8s')
            .css('transform','rotateX(360deg)');
        }
    });
});