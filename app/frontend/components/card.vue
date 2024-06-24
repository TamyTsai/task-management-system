<!-- .vue為vue.js components的副檔名 -->

<template> <!-- 放html一些結構的東西 -->
    <div class="card">
        {{ card.name }}
    </div>
</template>

<script> // javascript 
export default {
    name: 'Card', // 可寫可不寫，寫了增加易讀性
    props: ['card']
}
</script>

<style lang="scss" scoped> /* css */
.card {
    @apply .bg-gray-100 .mb-2 .rounded-sm .px-2 .py-2;
}
</style>