$(document).ready(() => {

    
    $(".watchReply").click((e)=>{
        e.preventDefault();
        if($(e.target).parent().next().hasClass('fadeOutUp') == true){
            $(e.target).parent().next().removeClass('fadeOutUp')
        }
        $(e.target).parent().next().addClass('fadeInDown');
        $(e.target).parent().next().css('z-index','1');
        $(e.target).parent().css('z-index','-1');
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

    
    
});