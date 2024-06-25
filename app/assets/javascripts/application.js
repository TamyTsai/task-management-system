// require jquery
// require jquery_ujs
//= require_tree .
//= vue/dist/vue.esm
//= components/list

// vue.js

import Vue from 'vue/dist/vue.esm';
import List from 'components/list';
import Rails from "@rails/ujs";
import draggable from 'vuedraggable';

document.addEventListener("turbolinks:load", function(event) {
    let el = document.querySelector('#board');

    if (el) { // 如果el存在的話（id board的html元素存在）
        new Vue({ // 才進行Vue的控制
            // el: '#board'
            // el: el
            el, // ES6中 key與value相同時 可以只寫一個
            data: {
                // <div id="board" data-lists="<%= @lists.to_json(include: :cards) %>">
                lists: JSON.parse(el.dataset.lists)
                // dataset可以抓到html標籤中data屬性中的值，dataset.lists可抓到屬性data-lists中的值
            },
            // components: { List: List } //註冊元件
            // List名字可以亂取  如{ 'abc': List } 
            // ES6中key與value相同時，可以只寫一個
            components: { List, draggable },
            methods: {
                listMoved(event) { // 拖拉後會執行的動作
                    // console.log(event);

                    // 打API 將東西拖拉後的新位置資料 傳到後端 寫入資料庫
                    // 1.蒐集準備 要傳送到後端的資料
                    let data = new FormData();
                    data.append("list[position]", event.moved.newIndex + 1 ); 
                    // 將 event.moved.newIndex + 1 （拖拉後會出現事件 事件中有個key叫moved，其中有newIndex，而newIndex從0開始算（陣列），position從1開始算，所以要+1）寫進 lists資料表的position欄位中
                    // 2.打API
                    Rails.ajax({
                        // 希望打向 像 /lists/2/move 的路徑
                        url: `/lists/${this.lists[event.moved.newIndex].id}/move`, //ES6中 字串串接變數 之寫法
                        // lists[event.moved.newIndex].id 移動到新位置的 清單id
                        type: 'PUT', // 更新：PUT、PATCH （讀取：GET、新建：POST）
                        data,
                        dataType: 'json',
                        success: resp => {
                            console.log(resp);
                        },
                        error: err => {
                            console.log(err);
                        }
                    });
                }
            }
        });
    }
})

