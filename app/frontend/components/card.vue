<!-- .vue為vue.js components的副檔名 -->

<template> <!-- 放html一些結構的東西 -->
    <div>
    <!-- component只能有一個上層元件 所以要再外面再包一個div 讓他們變成一個 -->
        <div class="card" @click="editing = true">
            {{ card.name }}
        </div>

        <div v-if="editing" class="dialog"> <!-- 每個卡片都是一個component 但因為是用v-if 而非 v-show，所以效能不會差 -->
            <div class="inner">
                <a href="#" class="closeButton" @click="close">
                    <i class="fa-solid fa-xmark"></i>
                </a>
                <textarea class="content">{{ card.name }}</textarea>
                <button class="updateButton" @click="update">更新</button>
            </div>
        </div>
    </div>
</template>

<script> // javascript 
export default {
    name: 'Card', // 可寫可不寫，寫了增加易讀性
    data: function() { // data裡給一個function，function裡給一個object
        return {
            editing: false
        }
    },
    props: ['card'],
    methods: {
        close(event) {
            event.preventDefault();
            this.editing = false;
        },

        update(event) {
            event.preventDefault();
            this.editing = false;
        }
    }
}
</script>

<style lang="scss" scoped> /* css */
.card {
    @apply .bg-gray-100 .mb-2 .rounded-sm .px-2 .py-2 .cursor-pointer;
    // .cursor-pointer 鼠標移上去會有手指頭
}

.dialog {
    background-color: rgba(0, 0, 0, 0.7); // tailwind沒有背景顏色透明度寫法 所以這裡直接寫 不用@apply
    @apply .fixed .w-full .h-full .top-0 .left-0 .flex .items-center .justify-center;
    // 垂直置中
    .inner {
        @apply .bg-white .flex .flex-col .px-6 .py-2;
        // flex-col 以縱軸為主軸（直向排序）
        width: 700px;

        .closeButton {
            @apply .text-gray-800 .text-right;
        }
        .content {
            @apply .px-2 .py-2 .border .border-gray-300 .mt-2;

            &:focus {
                @apply .outline-none;
            }
        }
        .updateButton {
            @apply .bg-gray-400 .px-3 .py-2 .mt-2 .rounded;
            &:focus {
                @apply .outline-none;
            }
        }
    }
}
</style>