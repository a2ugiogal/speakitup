//POPUP==============================================================
// 視窗開關
function openForm() {
    document.getElementById("myForm").style.display = "block";
  }
  
  function closeForm() {
    document.getElementById("myForm").style.display = "none";
  }

//BOT==============================================================

        //答案隨機取用，從 0 到 n-1 中選一個亂數
        function random(n) { 
          return Math.floor(Math.random()*n);
        }
        //按下送出
        function say() {
          appendMe(document.getElementById("say").value); // 將使用者輸入的問句放到「對話區」顯示。
          answer(); // 然後回答使用者的問題。
        }

        //清空輸入框
        function clear(){
          document.getElementById("say").value="";
        }
        // 按下enter時
        function keyin(event) {
          var keyCode = event.which; // 取出按下的鍵
          if (keyCode == 13) say(); // 如果是換行字元 \n ，就進行回答動作。
        }
        
  
        
    


          
        
        

        