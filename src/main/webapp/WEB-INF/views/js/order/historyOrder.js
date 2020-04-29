function doFirst() {
  orderRow = document.getElementsByClassName("orderRow");
  orderItems = document.getElementsByClassName("orderItems");
  orderWaitShip = document.getElementsByClassName("待出貨");
  orderAlreadyShip = document.getElementsByClassName("已出貨");
  orderFinish = document.getElementsByClassName("完成");
  all = document.getElementById("all");
  waitShip = document.getElementById("waitShip");
  alreadyShip = document.getElementById("alreadyShip");
  finish = document.getElementById("finish");

  for (let i = 0; i < orderRow.length; i++) {
    orderRow[i].addEventListener("click", function () {
      if (orderItems[i].style.display == "none") {
        orderItems[i].style.display = "";
      } else {
        orderItems[i].style.display = "none";
      }
    });
  }

  all.addEventListener("click", select);
  waitShip.addEventListener("click", select);
  alreadyShip.addEventListener("click", select);
  finish.addEventListener("click", select);
}

function select(e) {
  for (let i = 0; i < orderItems.length; i++) {
    orderItems[i].style.display = "none";
  }
  for (let i = 0; i < orderWaitShip.length; i++) {
    orderWaitShip[i].style.display = "none";
  }
  for (let i = 0; i < orderAlreadyShip.length; i++) {
    orderAlreadyShip[i].style.display = "none";
  }
  for (let i = 0; i < orderFinish.length; i++) {
    orderFinish[i].style.display = "none";
  }

  if (e.target.id == "waitShip") {
    for (let i = 0; i < orderWaitShip.length; i++) {
      orderWaitShip[i].style.display = "";
    }
  } else if (e.target.id == "alreadyShip") {
    for (let i = 0; i < orderAlreadyShip.length; i++) {
      orderAlreadyShip[i].style.display = "";
    }
  } else if (e.target.id == "finish") {
    for (let i = 0; i < orderFinish.length; i++) {
      orderFinish[i].style.display = "";
    }
  } else {
    for (let i = 0; i < orderWaitShip.length; i++) {
      orderWaitShip[i].style.display = "";
    }
    for (let i = 0; i < orderAlreadyShip.length; i++) {
      orderAlreadyShip[i].style.display = "";
    }
    for (let i = 0; i < orderFinish.length; i++) {
      orderFinish[i].style.display = "";
    }
  }
}

window.addEventListener("load", doFirst);
