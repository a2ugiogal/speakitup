function doFirst() {
  articlePicture = document.getElementById("articlePicture");
  fileSelect = document.getElementById("fileSelect");

  fileSelect.addEventListener("change", function() {
    readFile = new FileReader();
    readFile.readAsDataURL(fileSelect.files[0]);
    readFile.addEventListener("load", function() {
      source = this.result;
      articlePicture.src = source;
      articlePicture.style.maxWidth = "200px";
      articlePicture.style.maxHeight = "100px";
    });
  });
}
window.addEventListener("load", doFirst);
