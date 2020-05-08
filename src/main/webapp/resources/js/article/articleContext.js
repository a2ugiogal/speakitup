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

  // $("#commentBtnArea").click();

  // 送出留言
  commentForm = document.getElementById("commentForm");
  $("#sendCommentBtn").click(function () {
    $("#myCommentContent").fadeOut();
    setTimeout(() => {
      $("#commentArea").slideToggle();
    }, 200);
    $("#bgGray").fadeOut();
    commentForm.submit();
  });

  // 按愛心
// normal = document.getElementsByClassName("normal")[0];
// normal.addEventListener("click", function () {
//    
// });
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
	if (this.style.color != "red") {
	      xhr = new XMLHttpRequest();
	      id = this.id;
	      xhr.open("GET", "/speakitup/article/likeArticle/" + id, false);
	      xhr.send();
	      likeNum = document.getElementById("likeNum");
	      likeNum.innerText = xhr.responseText;
	      this.style.color = "red";
	      this.style.border = "1px solid red";
	      this.style.cursor = "default";
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
	    "/speakitup/article/report?commentId=" +
	      commentIdInput.value +
	      "&reportItem=" +
	      reportItem,
	    false
	  );
	  xhr.send();
	  $("#reportModal").modal("hide");
	});

window.addEventListener("load", doFirst);
