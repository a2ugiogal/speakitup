//漂流信的倒數計時器
function doFirst(){
	var start = new Date;
    start.setHours(18,20,00)
    function updateTime(){
        var now = new Date().getTime();
        if(now > start){
            start.setDate(start.getDate() + 1);
        }
        gap = start - now;
        var second = 1000;
        var minute = second * 60;
        var hour = minute * 60;

        var h = Math.floor(gap/(hour))
        var m = Math.floor((gap % (hour)) /(minute))
        var s = Math.floor((gap % (minute)) /(second))
        
        
        document.getElementById('hour').innerText = h;
        document.getElementById('minute').innerText = m;
        document.getElementById('second').innerText = s;
        if(h<10){
        	document.getElementById('hour').innerText = "0" + h;
        }
        if(m<10){
        	document.getElementById('minute').innerText = "0" + m;
        }
        if(s<10){
        	document.getElementById('second').innerText = "0" + s;
        	
        }
        if(h == 0 && m == 0 && s<=5){
    		document.getElementById('hour').style.color="#E70E02";
    		document.getElementById('minute').style.color="#E70E02";
    		document.getElementById('second').style.color="#E70E02";
    	}else{
    		document.getElementById('second').style.color="#fff";
    	}
        
        if(h == 0 && m == 0 && s == 0){
        	window.location = "http://localhost:8080/letter/letterHomeForUpdate"
//        	window.location = "https://speakitup.nctu.me/letter/letterHomeForUpdate"
        }
    }

    setInterval(() => {
        updateTime();
    }, 1000);

} 
window.addEventListener('load',doFirst)
