//我的回覆
function appendMe(line) { // 將 line 放到「對話區」顯示。
    var dialogBox = document.getElementById("dialogBox"); // 取出對話框 
    question = document.createElement('div');
    question.align='right';
    question.style.margin = '15px';
    questionSpan = document.createElement('span');
    questionSpan.setAttribute("class",'speech-bubble');
    questionSpan.style.backgroundColor ="#0e2640";
    questionSpan.style.color ="white";
    questionSpan.innerHTML =line; 
    question.appendChild(questionSpan);
    dialogBox.appendChild(question);
    dialogBox.scrollTop = dialogBox.scrollHeight; // 捲動到最下方。
  }