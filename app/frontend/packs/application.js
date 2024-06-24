// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// vue.js

import Vue from 'vue/dist/vue.esm';
import List from 'components/list';

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
            components: { List }
        });
    }
})

