// require jquery
// require jquery_ujs
//= require_tree .

// vue.js

// import Vue from 'vue/dist/vue.esm';

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
            }
        });
    }
})