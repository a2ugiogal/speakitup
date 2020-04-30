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
   alert(reportItem + " , " + commentIdInput.value);
    xhr = new XMLHttpRequest();
    xhr.open(
      "POST",
      "/speakitup/article/report?commentId=" + commentIdInput.value + "&reportItem=" + reportItem ,
      false
    );
    xhr.send();
  $("#reportModal").modal("hide");
});
