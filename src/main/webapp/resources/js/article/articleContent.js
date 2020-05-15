function doFirst() {
  commentPage = document.getElementById("commentPage");
  totalPage = document.getElementById("totalPage");
  commentPageNo = parseInt(commentPage.innerText);
  totalPageNo = parseInt(totalPage.innerText);
  lastPage = document.getElementById("lastPage");
  nextPage = document.getElementById("nextPage");
  lastPage.addEventListener("click", showLastPage);
  nextPage.addEventListener("click", showNextPage);
  speechArea = document.getElementsByClassName("speechArea");

  if (commentPageNo == totalPageNo) {
    nextPage.style.visibility = "hidden";
  }

  // 送出留言
// commentForm = document.getElementById("commentForm");
// $("#sendCommentBtn").click(function () {
// $("#myCommentContent").fadeOut();
// setTimeout(() => {
// $("#commentArea").slideToggle();
// }, 200);
// $("#bgGray").fadeOut();
// commentForm.submit();
// });

}

// 送出留言
function sendComment(articleId) {
  $.ajax({
    type: "POST",
    url: "/speakitup/article/addComment/"+articleId,
    data: {
      content:$("#contentText").val()
    },
    dataType: "json",
    success: function (response) {
    	speechArea = document.getElementsByClassName("speechArea");
    	commentCount = document.getElementsByClassName("commentCount");
    	commentPage = document.getElementById("commentPage");
    	SAL = speechArea.length;
    	CCL = commentCount.length;
    	totalPage = document.getElementById("totalPage");
    	commentPage = document.getElementById("commentPage");
    	if(CCL%6==0&&CCL!=0){
    		totalPage.innerText=parseInt(totalPage.innerText)+1;
    		nextPage.style.visibility = "";
    	}
    	
    	inner="";
    	if($(".speechDad").length % 3 != 0){
    		inner = speechArea[SAL-1].innerHTML;
            $(".speechArea").last().remove();
    	}
        // 分左右ㄉ(speechTop、commentSpace、bgBubbleLeft)
        if ($(".speechArea").length % 2 == 0) {
          speechTop = "";
          speechTop += ` <div class="vh-100 p-3 speechArea"`;
          if ($(".speechArea").length >= parseInt(commentPage.innerText)*2||$(".speechArea").length < parseInt(commentPage.innerText)*2-2) {
            speechTop += ` style="display: none;"`;
          }
          speechTop += `>`;
          
          commentSpace="";
          if(CCL%3==0){
        	  commentSpace+=`<div class="col-3 p-0"></div>`;
          }else if(CCL%3==2){
        	  commentSpace+=`<div class="col-1 p-0"></div>`;
          }
          
          bgBubbleLeft=`style="transform: scaleX(-1);" `;
        	  
        } else {
          speechTop = "";
          speechTop += `<div class="vh-100 p-3 speechArea"`;
          speechTop += ` style="left: 72%;`;
          if ($(".speechArea").length >= parseInt(commentPage.innerText)*2||$(".speechArea").length < parseInt(commentPage.innerText)*2-2) {
            speechTop += ` display: none;`;
          }
          speechTop += ` "`;
          speechTop += ` >`;
          
          commentSpace="";
          if(CCL%3==1){
        	  commentSpace+=`<div class="col-3 p-0"></div>`;
          }else if(CCL%3==2){
        	  commentSpace+=`<div class="col-1 p-0"></div>`;
          }
          
          bgBubbleLeft="";
        }
        // speechContent
        speechContent = "";
        speechContent += ` <div style="height: 4%;"></div>`;
        speechContent += ` <div class="row m-0 d-flex align-items-center" style="height: 28%;">`;
        speechContent += ` ${commentSpace}`;
        speechContent += ` <div class="col-9 p-0 speechDad">`;
        speechContent += ` <img class="speech-balloon1" src="/speakitup/image/article/speech-bubble-removebg-preview.png"`;
        speechContent += ` ${bgBubbleLeft}`;
        speechContent += ` />`;
        speechContent += ` <div style="height: 5%;"></div>`;
        speechContent += ` <div class="d-flex justify-content-end" style="height: 20%;">`;
        speechContent += ` <i class="fas fa-exclamation-circle" style="font-size: 30px;" title="檢舉" onclick="showReportModal('${response.commentId}')"></i>`;
        speechContent += ` </div>`;
        speechContent += ` <div class="comment"><pre>${response.content}</pre></div>`;
        count = CCL + 1;
        speechContent += ` <div class="commentCount">${count}</div>`;
        speechContent += `<div class="d-flex justify-content-end commentDate">`;
        /* DateFormat */
        var formattedDate = new Date(response.publishTime);
        var d = formattedDate.getDate();
        if (formattedDate.getDate() < 10) {
          d = "0" + d;
        }
        var m = formattedDate.getMonth();
        m += 1; // JavaScript months are 0-11
        if (formattedDate.getMonth() < 10) {
          m = "0" + m;
        }
        var y = formattedDate.getFullYear();
        var h = formattedDate.getHours();
        var mm = formattedDate.getMinutes();
        /* DateFormat */
        speechContent += ` ${y}-${m}-${d} ${h}:${mm}`;
        speechContent += ` </div>`;
        speechContent += ` </div>`;
        speechContent += ` </div>`;

        // speechBottom
        speechBottom = `</div>`;

        if (inner == "") {
        	finalText=speechTop+` <div style="height: 60px;"></div> `+speechContent+speechBottom;
        	$("#commentsDiv").append(finalText);
        } else {
          finalText=speechTop+inner+speechContent+speechBottom
          $("#commentsDiv").append(finalText);
        }
        
        
      },
  });
  
  $("#myCommentContent").fadeOut();
  setTimeout(() => {
    $("#commentArea").slideToggle();
  }, 200);
  $("#bgGray").fadeOut();
  setTimeout(() => {
	  $("#contentText").val("");
  }, 200);
  
}


// 登入浮動視窗
function loginModel() {
  $("#ignismyModal").modal("show");
}

// 我要留言
function wantComment() {
  myCommentContent = document.getElementById("myCommentContent");
  mccd = myCommentContent.style.display;
  if (mccd == "none") {
    setTimeout(() => {
      $("#myCommentContent").fadeIn();
    }, 300);
    $("#commentArea").slideToggle();
  } else {
    $("#myCommentContent").fadeOut();
    setTimeout(() => {
      $("#commentArea").slideToggle();
    }, 200);
  }
  $("#bgGray").slideToggle();
}

// 按愛心
function likeIt(){
	normal = document.getElementsByClassName("normal")[0];
	if (normal.style.color != "red") {
	      xhr = new XMLHttpRequest();
	      id = normal.id;
	      xhr.open("GET", "/speakitup/article/likeArticle/" + id, false);
	      xhr.send();
	      likeNum = document.getElementById("likeNum");
	      likeNum.innerText = xhr.responseText;
	      normal.style.color = "red";
	      normal.style.border = "1px solid red";
	      normal.style.cursor = "default";
	    }
}

function showLastPage() {
  maxSpeechArea = Math.min(speechArea.length - 1, commentPageNo * 2 - 1);
  for (let n = commentPageNo * 2 - 2; n <= maxSpeechArea; n++) {
    speechArea[n].style.display = "none";
  }
  commentPageNo--;
  if (commentPageNo == 1) {
    lastPage.style.visibility = "hidden";
    nextPage.style.visibility = "";
  } else {
    nextPage.style.visibility = "";
  }
  commentPage.innerText = commentPageNo;
  for (let n = commentPageNo * 2 - 2; n <= commentPageNo * 2 - 1; n++) {
    speechArea[n].style.display = "";
  }
}

function showNextPage() {
  for (let n = commentPageNo * 2 - 2; n <= commentPageNo * 2 - 1; n++) {
    speechArea[n].style.display = "none";
  }
  commentPageNo++;
  if (commentPageNo == totalPageNo) {
    nextPage.style.visibility = "hidden";
    lastPage.style.visibility = "";
  } else {
    lastPage.style.visibility = "";
  }
  commentPage.innerText = commentPageNo;
  maxSpeechArea = Math.min(speechArea.length - 1, commentPageNo * 2 - 1);
  for (let n = commentPageNo * 2 - 2; n <= maxSpeechArea; n++) {
    speechArea[n].style.display = "";
  }
}

function showReportModal(commentId) {
	  $("#reportModal").modal("show");
	  commentIdInput = document.getElementById("commentIdInput");
	  commentIdInput.value = commentId;
	}

	$("#sendReport").on("click", function () {
	  commentIdInput = document.getElementById("commentIdInput");
	  reportItems = document.getElementsByName("reportItem");
	  reportItem = null;
	  for (i = 0; i < reportItems.length; i++) {
	    if (reportItems[i].checked) {
	      reportItem = reportItems[i].value;
	    }
	  }
	  xhr = new XMLHttpRequest();
	  xhr.open(
	    "GET",
	    "/article/report?reportItem=" + reportItem + "&commentId=" + commentIdInput.value,
	    false
	  );
	  xhr.setRequestHeader("Content-Type",
		"application/x-www-form-urlencoded");
	  xhr.send();
	  $("#reportModal").modal("hide");
	});

window.addEventListener("load", doFirst);
