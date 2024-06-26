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
import Rails from "@rails/ujs";
import draggable from 'vuedraggable'; // 引入draggable套件 讓 清單 可以被拖拉
import store from 'stores/list'; // 引入自己寫的vuex （不一定要叫store）
import { mapGetters, mapActions } from "vuex";
import List from 'components/list';
import Newlist from 'components/newlist';

document.addEventListener("turbolinks:load", function(event) {
    let el = document.querySelector('#board');

    if (el) { // 如果el存在的話（id board的html元素存在）
        window.$store = store; // 讓store在脫離vue的檔案的地方 也可以用
        new Vue({ // 才進行Vue的控制
            // el: '#board'
            // el: el
            el, // ES6中 key與value相同時 可以只寫一個
            store, // store: store（自己import的名稱） // 所有資料都放在data store
            computed: { // 將資料（lists）拿出來
                //...mapGetters(["lists"]) // map（收集）lists這個getter（唯讀） // ... 代表後面還可以接別的東西
                lists: {
                    get() { // 讀取
                        return this.$store.state.lists;
                    },

                    set(value) { // 寫入 （為了將拖拉後的新位置寫入）
                        this.$store.commit("UPDATE_LISTS", value);
                    }
                }
            },
            // 有store就不用用data了，這包data其他地方也會用到，所以用store集中管理
            // data: {
            //     // <div id="board" data-lists="<%= @lists.to_json(include: :cards) %>">
            //     // lists: JSON.parse(el.dataset.lists)
            //     // dataset可以抓到html標籤中data屬性中的值，dataset.lists可抓到屬性data-lists中的值
            //     lists: []
            // },
            // components: { List: List } //註冊元件
            // List名字可以亂取  如{ 'abc': List } 
            // ES6中key與value相同時，可以只寫一個
            components: { List, Newlist, draggable },
            methods: {
                ...mapActions(["loadList", "moveList"]),
                // listMoved(event) { // 清單 拖拉後會執行的動作
                //     // ..... 改寫到vuex
                // }
            },
            beforeMount() { // vue instance 生命週期中 的 掛載前（已經檢測el存在後）
                this.loadList(); //loadList()函式是寫在vuex action中的 透過mapAction讓這裡也可以用
            }
        });
    }
})

