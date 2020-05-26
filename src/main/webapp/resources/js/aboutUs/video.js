function doFirst(){
    barsize = parseInt(window.getComputedStyle(defaultBar).width) ;

    myMovie = document.getElementById('myMovie');
    playButton = document.getElementById('playButton');
    stopButton = document.getElementById('stopButton');
    upButton = document.getElementById('upButton');
    downButton = document.getElementById('downButton');
    mutedButton = document.getElementById('mutedButton');
    defaultBar = document.getElementById('defaultBar');
    progressBar = document.getElementById('progressBar');
    timeText = document.getElementById('timeText');

    playButton.addEventListener('click',playOrPause)
    stopButton.addEventListener('click',stop)
    upButton.addEventListener('click',volumeUp)
    downButton.addEventListener('click',volumeDown)
    mutedButton.addEventListener('click',volumeMute)
    defaultBar.addEventListener('click',clickedBar)
    defaultBar.addEventListener('mousedown',moveBar)
    defaultBar.addEventListener('mouseup',stopBar)
    myMovie.addEventListener('click',playOrPause)
    myMovie.addEventListener('dblclick',fullScreen)
}

function fullScreen(){
    myMovie.webkitRequestFullScreen();
}

function update(){
    bar = barsize / myMovie.duration * myMovie.currentTime;
    if(!myMovie.ended){
        progressBar.style.width= `${bar}px`;
    }else{
        progressBar.style.width = `0px`;
        playButton.innerText = `play`;
    }
    
}

function updateText(){
    // var gap = Math.round(myMovie.currentTime) - 
    timeTextNew = Math.round(myMovie.currentTime);
     m =  Math.floor(timeTextNew/60);
     s = timeTextNew % 60;
    if(m<1){
        if(s < 10){
            timeText.innerText = "00:0" + s
        }else{
            timeText.innerText = "00:" + s
        }
    }else if(m>=1 && m<10){
        if(s < 10){
            timeText.innerText = "0" + m + ":" + "0" +  s ;
        }else if(s>=10 && s<60){
            timeText.innerText = "0" + m + ":" +  s ;
        }
    }else if(m>=10){
        if(s < 10){
            timeText.innerText =  m + ":" + "0" + s ;
        }else if(s>=10 && s<60){
            timeText.innerText =  m + ":" +  s;
        }
    }
  
}

function clickedBar(e){
    //螢幕到滑鼠 - progressBar左邊到螢幕
    mouseX = e.clientX - progressBar.offsetLeft; 
    newtime = mouseX / (barsize / myMovie.duration)

    progressBar.style.width = `${mouseX}px`;
    myMovie.currentTime = newtime;
}

function moveBar(){
    defaultBar.addEventListener('mousemove',clickedBar);
}
function stopBar() {
    defaultBar.removeEventListener('mousemove',clickedBar);
}

function playOrPause(){
    if(!myMovie.paused && !myMovie.ended){  
        myMovie.pause();                     // 影片暫停
        playButton.innerText = `play`;
    }else{                                  
        myMovie.play();                     // 影片開始
        playButton.innerText = `pause`;
        setInterval(update,500);
        setInterval(updateText,1000)
    }
}

function stop(){
    myMovie.currentTime = 0;
    myMovie.pause(); 
    progressBar.style.width = `0px`;
    playButton.innerText = `play`;
}

function hidden(){
    document.getElementById('volume').style.visibility = 'hidden';
}

function volume(){
    let volumecount = `音量：${(myMovie.volume * 100).toFixed(0)}%`
    return volumecount;
}

function volumeUp(){
    if(!myMovie.muted){
        if(myMovie.volume != 1){
        myMovie.volume += 0.1;
        }
    }else{  // 如果靜音，取消靜音
        myMovie.muted = false;
        document.getElementById('mutedButton').innerText = 'muted';
        document.getElementById('mutedButton').style.color = '#000';
    }
    
    document.getElementById('volume').innerText = volume();
    // 顯示一段時間後，隱藏音量
    document.getElementById('volume').style.visibility = 'visible';
    setTimeout(hidden,1000);
}

function volumeDown(){
    if(!myMovie.muted){
        if(myMovie.volume != 0){
            myMovie.volume -= 0.1;
        }
    }else{  // 如果靜音，取消靜音
        myMovie.muted = false;
        document.getElementById('mutedButton').innerText = 'muted';
        document.getElementById('mutedButton').style.color = '#000';
    }
    
    document.getElementById('volume').innerText = volume();
    // 顯示一段時間後，隱藏音量
    document.getElementById('volume').style.visibility = 'visible';
    setTimeout(hidden,1000);
}

function volumeMute(){
    if(!myMovie.muted){
        myMovie.muted = true;
        document.getElementById('volume').innerText = `音量：靜音`;
        document.getElementById('mutedButton').innerText = 'unmuted';
        // 顯示成紅色以提醒使用者
        document.getElementById('mutedButton').style.color = 'red';
    }else{
        myMovie.muted = false;
        document.getElementById('volume').innerText = volume();
        document.getElementById('mutedButton').innerText = 'muted';
        document.getElementById('mutedButton').style.color = '#000';
    }
    // 顯示一段時間後，隱藏音量
    document.getElementById('volume').style.visibility = 'visible';
    setTimeout(hidden,1000);
}



window.addEventListener('load',doFirst);