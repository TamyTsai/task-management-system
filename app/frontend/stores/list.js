import Vue from 'vue/dist/vue.esm';
import Vuex from 'vuex';
import Rails from '@rails/ujs';

Vue.use(Vuex);

export default new Vuex.Store({
    state: {
        lists: []
    },

    getters: { // 透過getter拿資料
        lists: state => state.lists // ES6箭頭函式簡寫（只有一行可以連大括弧都省略）
    },

    mutations: { // 做一些動作 讓你可以更改state
        UPDATE_LISTS(state, lists) { // 不一定要大寫 參數接state 和要改變的東西
            state.lists = lists; // 請mutation更新lists
        }
    },

    actions: { // action執行mutation // 在mutation或元件中 呼叫或執行這裡的function
        loadList({ commit }) { // 方法被呼叫時 會默默帶一些資料進來 其中有一個object的key為 commit ，所以把commit map進來
            // 呼叫loadList 打api 資料回來透過commit更新狀態（mutations） mutation會操縱state 所以state也會跟著變
            Rails.ajax({
                url: '/lists.json',
                type: 'GET',
                dataType: 'json', // 不需要丟data 因為就是想把東西（清單 卡片 資料）撈回來而已
                success: resp => {
                    commit("UPDATE_LISTS", resp); // 當action被呼叫時，會得到commit 跟commit說 現在拿到一包東西（resp）了 請更新狀態（UPDATE_LISTS）（mutations）
                    console.log(resp);
                    // this.lists = resp;
                    // 將透過API 撈出來（回應）的資料 塞給原本是空陣列的清單
                },
                error: err => {
                    console.log(err);
                } 
            });
        },

        moveList({ commit, state }, event) {
            // console.log(event);

            // 打API 將清單拖拉後的新位置資料 傳到後端 寫入資料庫
            // 1.蒐集準備 要傳送到後端的資料
            let data = new FormData();
            data.append("list[position]", event.moved.newIndex + 1 ); 
            // 將 event.moved.newIndex + 1 （拖拉後會出現事件 事件中有個key叫moved，其中有newIndex，而newIndex從0開始算（陣列），position從1開始算，所以要+1）寫進 lists資料表的position欄位中
            // 2.打API
            Rails.ajax({
                // 希望打向 像 /lists/2/move 的路徑
                url: `/lists/${state.lists[event.moved.newIndex].id}/move`, //ES6中 字串串接變數 之寫法
                // lists[event.moved.newIndex].id 移動到新位置的 清單id
                type: 'PUT', // 更新：PUT、PATCH （讀取：GET、新建：POST）
                data,
                dataType: 'json'
                // success: resp => {
                //     console.log(resp);
                // },
                // error: err => {
                //     console.log(err);
                // }
            });
        }
    }
});