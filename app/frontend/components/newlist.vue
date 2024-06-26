<template> 
    <div class="container">
    <button v-if="!creatingList" class="new_button" @click="newList">
        <i class="fas fa-plus"></i> 新增其它列表
    </button>
    <input ref="list_name" v-model="list_name" v-if="creatingList" type="text" class="list_name" placeholder="列表標題">
    <button v-if="creatingList" @click="createList" class="button create_button">建立</button>
    <button v-if="creatingList" @click="creatingList = false"  class="button cancel_button">取消</button>
    </div>
</template>

<script>
export default {
    name: 'Newlist',
    data: function() {
        return { // return 物件回來
            creatingList: false,
            list_name: ''
        }
    },
    methods: {
        newList(event) {
            event.preventDefault();
            this.creatingList = true;
            this.$nextTick(() => { // 點擊建立清單按鈕的當下，還沒有輸入框，所以會變成對未定義的東西focus 而nextTick可以對下一個動作執行裡面的程式碼 所以就可以對按鈕點下後才生成的輸入框做focus
                this.$refs.list_name.focus();
            })
        },
        createList(event) {
            event.preventDefault();
            this.$store.dispatch("createList", this.list_name);
            // this.list_name 為 createList 函式 的參數
            // 把這包物件 透過dispatch方法 叫store 更新這包物件
            this.creatingList = false;
            this.list_name = ''; // 建立完一個清單後 輸入框就清掉
        }
    }
}
</script>

<style lang="scss" scoped>
    .new_button {
    @apply .font-bold .w-full .text-left;

    &:focus {
        @apply .outline-none;
    }
    }

    .list_name {
    @apply .rounded .w-full .px-3 .py-2 .mb-2;

    &:focus {
        @apply .outline-none;
    }
    }

    .button { //泛用型按鈕樣式
    @apply .px-3 .py-1 .rounded .font-bold .text-sm;

    &:focus {
        @apply .outline-none;
    }
    }

    .create_button {
    @apply .bg-gray-400;
    }

    .cancel_button {
    @apply .bg-white;
    }

    .container {
    @apply .bg-gray-300 .px-3 .py-2 .mx-2 .w-64 .h-full .rounded .flex-none;
    }
</style>