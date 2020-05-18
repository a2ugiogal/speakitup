function doFirst() {
	edit = document.getElementById("edit");
	fileSelect = document.getElementById("fileSelect");
	personalUpdates = document.getElementsByClassName("personalUpdate");
	headPicture = document.getElementById("headPicture");
	btSubmit = document.getElementById("btSubmit");
	btCancel = document.getElementById("btCancel");
	emailTitle = document.getElementsByClassName("personalTitle")[3];
	city = document.getElementById("city");
	area = document.getElementById("area");
	address = document.getElementById("address");
	phone = document.getElementById("phone");

	edit.addEventListener("click", update);

	// 在更動畫面裡，選擇照片後改變上面顯示的照片
	fileSelect.addEventListener("change", function() {
		readFile = new FileReader();
		readFile.readAsDataURL(fileSelect.files[0]);
		readFile.addEventListener("load", function() {
			source = this.result;
			headPicture.src = source;
			headPicture.style.maxWidth = "120px";
			headPicture.style.maxHeight = "120px";
		});
	});
}

function update() {
	fileSelect = document.getElementById("fileSelect");
	btSubmit = document.getElementById("btSubmit");
	btCancel = document.getElementById("btCancel");
	// 下拉式地址
	new TwCitySelector();
	// 下拉式地址

	fileSelect.style.visibility = "visible";
	btSubmit.style.visibility = "visible";
	btCancel.style.visibility = "visible";

	// 清空td裡的字
	for (let i = 0; i < personalUpdates.length; i++) {
		personalUpdates[i].innerText = "";
	}

	// 動態新增下拉式地址
	let addressSelect = document.createElement("div");
	addressSelect.setAttribute("role", "tw-city-selector");
	addressSelect.setAttribute("data-county-value", city.innerText);
	addressSelect.setAttribute("data-district-value", area.innerText);
	addressSelect.id = "address";
	personalUpdates[1].appendChild(addressSelect);

	// 動態新增input
	let updatePhone = document.createElement("input");
	let updateAddress = document.createElement("input");
	updateToInput(0, updatePhone, "text", phone.innerText, "phone");
	updateToInput(1, updateAddress, "text", address.innerText, "address");
	updatePhone.placeholder = "0912345678";
	updatePhone.maxLength = "10";
	updatePhone.addEventListener("keyup", function() {
		this.value = this.value.replace(/[^\d]/g, "");
	});
}
// 設定input屬性
function updateToInput(index, inputTitle, inputType, inputValue, inputName) {
	inputTitle.type = inputType;
	inputTitle.value = inputValue;
	// inputTitle.name = inputName;
	inputTitle.id = inputName+"Str";
	inputTitle.className = "form-control";
	personalUpdates[index].appendChild(inputTitle);
}

window.addEventListener("load", doFirst);

/* AJAX(取消) */
$("#btCancel").click(function(e) {
	ajax('cancel');
});

/* AJAX(修改資料) */
$("#btSubmit").click(function(e) {
	ajax('');
});

function ajax(cancelStr) {
	  var formData = new FormData();
	  formData.append("phone", $("#phoneStr").val());
	  formData.append("county", $(".county").val());
	  formData.append("district", $(".district").val());
	  formData.append("address", $("#addressStr").val());
	  formData.append("cancel", cancelStr);
	  formData.append("file1", document.getElementById("fileSelect").files[0]);
	  $.ajax({
	    type: "POST",
	    url: "/member/personPage",
	    data: formData,
	    dataType: "json",
	    // 告訴jQuery不要去處理發送的數據
	    processData: false,
	    // 告訴jQuery不要去這置Content-Type
	    contentType: false,
	    success: function (response) {
	      var bean = response;
	      // $('#headPicture').attr('src',path);
	      $('#fileSelect').css('visibility', 'hidden');

	      let member_list = $("#right");
	      var htmlStr = "";
	      htmlStr += `<div class="tab-content">`;
	      htmlStr += `<h2 class="m-y-2 mt-5 mb-4">會員檔案</h2>`;
	      htmlStr += `<div class="form-group row">`;
	      htmlStr += `<label class="col-lg-2 col-form-label form-control-label personalTitle">帳號</label>`;
	      htmlStr += `<label class="col-lg-8 col-form-label form-control-label personal">${bean.memberId}</label>`;
	      htmlStr += `</div>`;
	      htmlStr += `<div class="form-group row">`;
	      htmlStr += `<label class="col-lg-2 col-form-label form-control-label personalTitle">性別</label>`;
	      htmlStr += `<label class="col-lg-8 col-form-label form-control-label personal">${bean.gender}</label>`;
	      htmlStr += `</div>`;
	      htmlStr += `<div class="form-group row">`;
	      htmlStr += `<label class="col-lg-2 col-form-label form-control-label personalTitle">生日</label>`;
	      htmlStr += `<label class="col-lg-8 col-form-label form-control-label personal">${bean.birthday}</label>`;
	      htmlStr += `</div>`;
	      htmlStr += `<div class="form-group row">`;
	      htmlStr += `<label class="col-lg-2 col-form-label form-control-label personalTitle">E-mail</label>`;
	      htmlStr += `<label class="col-lg-8 col-form-label form-control-label personal">${bean.email}</label>`;
	      htmlStr += `</div>`;
	      htmlStr += `<div class="form-group row">`;
	      htmlStr += `<label class="col-lg-2 col-form-label form-control-label personalTitle">手機</label>`;
	      htmlStr += `<label class="col-lg-8 col-form-label form-control-label personalUpdate"><span id="phone">${bean.phone}</span></label>`;
	      htmlStr += `</div>`;
	      htmlStr += `<div class="form-group row">`;
	      htmlStr += `<label class="col-lg-2 col-form-label form-control-label personalTitle">地址</label>`;
	      htmlStr += `<label class="col-lg-8 col-form-label form-control-label personalUpdate"><span id="city">${bean.city}</span><span id="area">${bean.area}</span><span id="address">${bean.address}</span></label>`;
	      htmlStr += `</div>`;
	      htmlStr += `<div class="form-group row">`;
	      htmlStr += `<div class="col-lg-10 d-flex justify-content-center">`;
	      htmlStr += `<input type="button" class="btn btn-secondary mr-2" style="visibility: hidden;" id="btCancel" value="取消"/> `;
	      htmlStr += `<input type="button" class="btn btn-primary ml-2" style="visibility: hidden;" id="btSubmit" value="儲存" />`;
	      htmlStr += `</div>`;
	      htmlStr += `</div>`;
	      htmlStr += `</div>`;
	      member_list.html(htmlStr);
	      
	      /* AJAX(取消) */
	      $("#btCancel").click(function(e) {
	      	ajax("cancel");
	      });

	      /* AJAX(修改資料) */
	      $("#btSubmit").click(function(e) {
	      	ajax("");
	      });
	    },
	  });
	}
