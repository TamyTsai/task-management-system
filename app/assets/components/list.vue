<!-- .vue為vue.js components的副檔名 -->

<template> <!-- 放html一些結構的東西 -->
    <div class="bg-gray-300 mx-2 w-64 rounded">
    <!-- <div class="list"> -->
      <h2 class="px-3 py-1 font-bold">{{ list.name }}</h2>
      <!-- <h2 class="header">{{ list.name }}</h2> -->
      <!-- 元件跟局部渲染的檔案一樣，不該主動抓資料，應該要由其他地方餵資料過來 -->
    </div>
</template>

<script> // javascript 
export default {
    name: 'List', // 可寫可不寫，寫了增加易讀性
    props: ["list"] // property // 於父層或外層餵資料給元件（list）的手法

    // data: function() { //每個元件 都有自己的 狀態 與 一些資料，所以不能直接在data後接東西，而是要給一個function，然後接該元件 專屬的東西
    //     return {

    //     }
    // }
}
</script>

<style lang="scss" scoped> /* css */
/* scoped讓此處寫的css只會生效於此元件，不會污染到外面 */
 .list {
    @apply .bg-gray-300 .mx-2 .w-64 .rounded;

    .header {
    @apply .px-3 .py-1 .font-bold;
    }
 }

</style>