function doFirst() {
  btEdit = document.getElementById("btEdit");
  fileSelect = document.getElementById("fileSelect");
  headPicture = document.getElementById("headPicture");

  btEdit.addEventListener("mouseover", function() {
    btEdit.style.border = "2px solid rgb(2, 117, 69)";
    btEdit.style.background = "rgb(26, 202, 129)";
  });
  btEdit.addEventListener("mouseout", function() {
    btEdit.style.border = "2px solid #fff";
    btEdit.style.background = "rgb(118, 206, 169)";
  });

  // 在更動畫面裡，選擇照片後改變上面顯示的照片
  fileSelect.addEventListener("change", function() {
    readFile = new FileReader();
    readFile.readAsDataURL(fileSelect.files[0]);
    readFile.addEventListener("load", function() {
      source = this.result;
      headPicture.src = source;
      headPicture.style.maxWidth = "50%";
      headPicture.style.maxHeight = "200px";
    });
  });

}

window.addEventListener("load", doFirst);
