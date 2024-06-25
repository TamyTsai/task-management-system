<!-- .vue為vue.js components的副檔名 -->

<template> <!-- 放html一些結構的東西 -->
    <div class="bg-gray-300 mx-2 w-64 rounded .px-3 .py-1">
    <!-- <div class="list"> -->
      <h2 class="font-bold">{{ list.name }}</h2>
      <!-- <h2 class="header">{{ list.name }}</h2> -->
      <!-- 元件跟局部渲染的檔案一樣，不該主動抓資料，應該要由其他地方餵資料過來 -->
      <div class="deck">
        <!-- <Card v-for="card in list.cards" :card="card" :key="card.id"></Card> -->
        <Card v-for="card in cards" :card="card" :key="card.id"></Card>
          <!-- 為了避免重複 所以有key -->
          <!-- card.vue 中： props: ["card"] -->
          <!-- :card=「"card"」及 :key="「card」.id"是由前面的 v-for="「card」 in list.cards"來的 -->
          <!-- list.cards 是由 index.html @lists.to_json(include: :cards)來的 -->
          <!-- 元件中 再用 其他元件 -->
        <div class="input-area">
          <!-- 非編輯模式下 出現新增卡片按鈕 -->
          <!-- <button v-if="!editing" class="button bg-gray-400" @click="editing = true">新增卡片</button> -->
          <button v-if="!editing" class="button bg-gray-400" @click="newCard">新增卡片</button>
          
          <!-- 編輯模式下 出現內容輸入框、建立卡片、取消按鈕 -->
          <textarea v-if="editing" class="content" v-model="content"></textarea>
          <!-- data -->
          <button v-if="editing" class="button bg-green-400" @click="createCard">建立卡片</button>
          <button v-if="editing" class="button bg-gray-400" @click="editing = false">取消</button>
          <!-- @ 為 v-on: 之簡寫 -->
          <!-- createCard寫在methods中 -->
          <!-- 這四顆元件會跟 editing這個data屬性連動 -->
        </div>
      </div>
    </div>
</template>

<script> // javascript
import Rails from '@rails/ujs'; // Rails內建的AJAX套件
import Card from 'components/card'; // 引入隔壁的 卡片元件

export default {
    name: 'List', // 可寫可不寫，寫了增加易讀性
    props: ["list"], // property // 於父層或外層餵資料給元件（list）的手法
    components: { Card }, // 註冊card元件 讓這裡可以用該元件
    data: function() { //每個元件 都有自己的 狀態 與 一些資料，所以不能直接在data後接東西，而是要給一個function，然後接該元件 專屬的東西
        return { // 回傳一個物件
          content: '', // html中v-model綁定的東西
          cards: this.list.cards, // 名為cards的 data屬性
          // 因為目前在list這個元件中 所以有被餵食的這個東西進來
          editing: false
        }
    },
    methods: {
      newCard(event) {
        event.preventDefault();
        this.editing = true;
      },

      createCard(event) { // 按下 新增卡片 按鈕後 會執行的動作
        event.preventDefault();
        // console.log(this.content);

        // 打api 讓新增的卡片內容 可以傳送到後端 儲存進資料庫
        let data = new FormData();
        data.append("card[list_id]", this.list.id); // 蒐集資料
        // 要知道卡片是在哪個清單下
        data.append("card[name]", this.content);
        // 在要傳送的資料中 加入name欄位值為this.content的card
        Rails.ajax({
          url: '/cards', // 往/cards送資料
          // card controller中creat action中：format.json { render :show, status: :created, location: @card }
          // show會呈現單一一筆資料，這裡透過push將資料塞進去，變最後一張卡片，所以就會顯示對應的卡片資料
          type: 'POST', // 傳送的方法 // 用POST 會找create方法
          // data: data, // 要傳送的資料
          data,
          dataType: 'json', // 預期傳送的資料格式為json
          success: resp => { // ES6箭頭函式
            // console.log(resp);
            this.cards.push(resp); // 將目前的卡片 推到 卡片堆 中
            // data屬性 有任何變化，畫面上 跟該data有關係的 就會跟著變化 即時更新
            // cards 來自 cards: this.list.cards,
            this.content = ""; // 資料傳送完（api 打完後），清掉輸入框內 文字
            this.editing = false; // 資料傳送完（api 打完後），編輯狀態結束（建立卡片 及 取消 按鈕 消失，新增卡片 按鈕出現）
          },
          error: err => {
            console.log(err);
          }
        });
      }
    }
}
</script>

<style lang="scss" scoped> /* css */
/* scoped讓此處寫的css只會生效於此元件，不會污染到外面 */
 .list {
    @apply .bg-gray-300 .mx-2 .w-64 .rounded .px-3 .py-1;

    .header {
    @apply .font-bold;
    }

    .deck {
      @apply .mt-2;
    }

    .input-area {
      @apply .mt-2;

      .content {
        @apply .w-full .p-2 .rounded-sm;
        &:focus {
          @apply .outline-none;
        }
      }

      .button {
        @apply .px-3 .py-1 .font-semibold .text-sm .rounded;
        &:focus {
          @apply .outline-none;
        }
      }
    }
 }

</style>

<!-- rails c 建立卡片 -->
  <!-- [1] pry(main)> l1 = List.first
  NOTICE:  identifier "spring app    | 任務管理系統 | started 0 secs ago | development mode" will be truncated to "spring app    | 任務管理系統 | started 0 secs ago | devel"
    List Load (0.4ms)  SELECT "lists".* FROM "lists" ORDER BY "lists"."id" ASC LIMIT $1  [["LIMIT", 1]]
  => #<List:0x0000000114836160 id: 1, name: "TODO", user_id: 1, position: 1, created_at: Mon, 24 Jun 2024 10:28:07.411967000 UTC +00:00, updated_at: Mon, 24 Jun 2024 10:28:07.411967000 UTC +00:00>
  [2] pry(main)> l1.cards.create(name: 'Hello');
    TRANSACTION (0.2ms)  BEGIN
    List Load (0.3ms)  SELECT "lists".* FROM "lists" WHERE "lists"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
    Card Load (1.2ms)  SELECT "cards".* FROM "cards" WHERE "cards"."list_id" = $1 AND ("cards"."position" IS NOT NULL) ORDER BY "cards"."position" DESC LIMIT $2  [["list_id", 1], ["LIMIT", 1]]
    Card Create (3.2ms)  INSERT INTO "cards" ("name", "list_id", "position", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["name", "Hello"], ["list_id", 1], ["position", 1], ["created_at", "2024-06-24 13:30:45.672894"], ["updated_at", "2024-06-24 13:30:45.672894"]]
    TRANSACTION (0.4ms)  COMMIT
  [3] pry(main)> l1.cards.create(name: 'task2');
    TRANSACTION (0.5ms)  BEGIN
    List Load (0.6ms)  SELECT "lists".* FROM "lists" WHERE "lists"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
    Card Load (0.8ms)  SELECT "cards".* FROM "cards" WHERE "cards"."list_id" = $1 AND ("cards"."position" IS NOT NULL) ORDER BY "cards"."position" DESC LIMIT $2  [["list_id", 1], ["LIMIT", 1]]
    Card Create (0.8ms)  INSERT INTO "cards" ("name", "list_id", "position", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["name", "task2"], ["list_id", 1], ["position", 2], ["created_at", "2024-06-24 13:31:03.364823"], ["updated_at", "2024-06-24 13:31:03.364823"]]
    TRANSACTION (1.4ms)  COMMIT
  [5] pry(main)> List.last.cards.create(name: 'done task');
    List Load (0.8ms)  SELECT "lists".* FROM "lists" ORDER BY "lists"."id" DESC LIMIT $1  [["LIMIT", 1]]
    TRANSACTION (0.2ms)  BEGIN
    List Load (0.2ms)  SELECT "lists".* FROM "lists" WHERE "lists"."id" = $1 LIMIT $2  [["id", 3], ["LIMIT", 1]]
    Card Load (0.5ms)  SELECT "cards".* FROM "cards" WHERE "cards"."list_id" = $1 AND ("cards"."position" IS NOT NULL) ORDER BY "cards"."position" DESC LIMIT $2  [["list_id", 3], ["LIMIT", 1]]
    Card Create (0.7ms)  INSERT INTO "cards" ("name", "list_id", "position", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["name", "done task"], ["list_id", 3], ["position", 1], ["created_at", "2024-06-24 13:32:04.203937"], ["updated_at", "2024-06-24 13:32:04.203937"]]
    TRANSACTION (1.9ms)  COMMIT -->