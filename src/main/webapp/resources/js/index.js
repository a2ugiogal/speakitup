;(function () {
  //=====首頁標題動畫====
  //等一秒網頁載入才開始動畫
  window.setInterval(() => {
    const title = document.getElementById('eyesNo')
    title.setAttribute('style', 'animation-play-state:running;')
  }, 1000)
  //等前面動畫跑完再執行第二句
  window.setTimeout(() => {
    document.getElementById('listenYouWant').style.visibility = 'visible'
  }, 4500)

  //=====假的訂閱效果=====
  $('#btn-to-subscribe').click(function (e) {
    //防止刷新頁面
    e.preventDefault()
    //取得input值
    let subscribeEmail = $('#subscribe-email').val()
    //檢查有人空白就提交
    //!subscribeEmail是空值的話就是true
    if (!subscribeEmail) {
      alert('親~還沒輸入email就按，你要我怎麼寄？')
      return
    }
    //延遲一下再彈出modal並清空input、騙評審
    setTimeout(function () {
      showAlert()
      $('#subscribe-email').val('')
    }, 800)

    function showAlert() {
      const modalContent = `好的呢！我們會把超優惠券寄到${subscribeEmail}`
      const modalTitle = '訂閱成功！'
      //bootstrap寫好的modal()方法
      //更換標題和內文
      $('.modal-title').html(modalTitle)
      $('.modal-body').html(modalContent)
      //彈出
      $('#my-modal-subscribe').modal('show')
    }
  })
})()
