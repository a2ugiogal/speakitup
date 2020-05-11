function doFirst() {
  articlePicture = document.getElementById("articlePicture");
  fileSelect = document.getElementById("fileSelect");

  fileSelect.addEventListener("change", function () {
    readFile = new FileReader();
    readFile.readAsDataURL(fileSelect.files[0]);
    readFile.addEventListener("load", function () {
      source = this.result;
      articlePicture.src = source;
      articlePicture.style.maxWidth = "70%";
      articlePicture.style.maxHeight = "200px";
    });
  });

  categoryTitle = document.getElementsByName('categoryTitle')[0];
  container = document.getElementsByClassName('container')[0];
  fileLabel = document.getElementById('fileLabel');
  submitBt = document.getElementById('submitBt');
  angel = document.getElementById("angel");
  evil = document.getElementById("evil");
  categoryTitle.addEventListener('change', function () {
    if (this.value == "惡魔") {
      container.classList.add('changeBgB');
      container.classList.remove('changeBgR');
      fileLabel.classList.add('changeBtB');
      fileLabel.classList.remove('changeBtR');
      submitBt.classList.add('changeBtB');
      submitBt.classList.remove('changeBtR');
    } else if (this.value == "天使") {
      container.classList.add('changeBgR');
      container.classList.remove('changeBgB');
      fileLabel.classList.add('changeBtR');
      fileLabel.classList.remove('changeBtB');
      submitBt.classList.add('changeBtR');
      submitBt.classList.remove('changeBtB');
    }
  });
}

window.addEventListener("load", doFirst);
