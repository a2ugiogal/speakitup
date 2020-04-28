var storage = sessionStorage;
function doFirst(){

    //取得有加入購物車的清單
    let itemString = storage.getItem('addItemList');
    let items = itemString.substr(0,itemString.length-2).split(', ');
    // console.log(items);

    //動態新增購物車欄位
    newSection = document.createElement('section');
    newTable = document.createElement('table');

    total = 0;


    for(let key in items){
        let itemInfo = storage.getItem(items[key]);
        createCartList(items[key], itemsInfo);

         //去找商品的價錢 index可能會有改變
        let price = parseInt(itemInfo.split('|')[2]);
        total += price;
    }
               
    
    document.getElementById('total').innerText = total;

    newSection.appendChild(newTable);
    document.getElementById('cartList').appendChild(newSection);
}

                        //可能是連接資料庫的itemId
function createCartList(itemId,itemValue){
        //商品名
    let itemTitle = itemValue.split('|')[0];
    //商品照片 最後連資料庫的照片
    let itemImage = 'img/' + itemValue.split('|')[1];
    // //商品規格
    // let itemFormat = itemValue.split('|')[2];
    //商品價格
    let itemPrice = parseInt(itemValue.split('|')[2]);
    
    //商品規格 不確定是不是這樣用
    let itemFormat = itemValue.split('|')[3];

    //商品數量
    let itemCount = itemValue.split('|')[4];

    //建立每個品項的清單區域
    let divitemList = document.createElement('div');
    divitemList.className = 'item';
    //把div加進去table裡
    newTable.appendChild(divitemList);


    //1.商品圖片及勾選欄

    let divImage = document.createElement('div');
    divImage.className = 'items-detail';

        //勾勾
    let checkBox = document.createElement('input');
    checkBox.type = 'checkbox';
        //照片
    let image = document.createElement('img');
    image.src = itemImage;
    image.width = '80px';

    divImage.appendChild(checkBox);
    divImage.appendChild(image);
        //把資料加進div表格中
    divitemList.appendChild(divImage);

    //2.商品名稱
    let divName = document.createElement('div');
    divName.className('items-detail');
        //商品的id 此處可能會有更動!!!
    divName.id = itemId;  
    divName.innerText = itemTitle;
    
    divitemList.appendChild(divName);

    //3.商品規格
    let divFormat = document.createElement('div');
    divFormat.className = 'items-detail';
        //下拉選單
    let formatSelect = document.createElement('select');
    formatSelect.style.fontSize = 'xx-small';
        //下拉選單的選項

    let formatOption = document.createElement('option');
    formatOption.innerText = itemFormat;

    divFormat.appendChild(formatSelect);
    formatSelect.appendChild(formatOption);

    divitemList.appendChild(divFormat);

    //4.商品價格
    let divCost = document.createElement('div');
    divCost.innerText = itemPrice;
    divitemList.appendChild(divCost);
    //5.商品數量 
    let divCount = document.createElement('div');
    divCount.style.fontSize = 'xx-small';

    //商品從上一頁過來時的數量
    let divInputCount = document.createElement('input');
    divInputCount.type = 'number';
    divInputCount.value = itemCount;
    divInputCount.min = 1;
    divInputCount.addEventListener('click',changeItemCount);

    divCount.appendChild(divInputCount);
    divitemList.appendChild(divCount);


    //6.商品總價
    let divTotal = document.createElement('div');
    divTotal.innerText = itemPrice * itemCount;

    divitemList.appendChild(divTotal);
    //7.刪除鍵

    let divDelete = document.createElement('div');
    div.className = 'delete';

    let btnDelete = document.createElement('button');
    btnDelete.style.fontSize = 'small';
    btnDelete.innerText = '刪除';
    btnDelete.addEventListener('click',deleteItem);

    divDelete.appendChild(aDelete);
    divitemList.appendChild(divDelete);
}

//function deleteItem{
//
//}
//
//function changeItemCount{
//
//}

// function addTotal{

// }
window.addEventListener('load',doFirst);





// $(document).ready(function(){
//     cost = $('#cost').html();
    
//    itemCount =  $("input[type='number']").change(function (e) { 
//         e.preventDefault();
//         total = (itemCount.val()) * cost;
//         $('.total').text(total);
//     });

//     //checkBox 全選的功能
//     $('#allCheck').change(function(){
//         $('.items').find(':checkbox').prop('checked', $(this).is(':checked')?true:false);
//     })
    
