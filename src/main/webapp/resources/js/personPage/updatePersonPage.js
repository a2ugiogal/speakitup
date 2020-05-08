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
	inputTitle.name = inputName;
	inputTitle.className = "form-control";
	personalUpdates[index].appendChild(inputTitle);
}

window.addEventListener("load", doFirst);
