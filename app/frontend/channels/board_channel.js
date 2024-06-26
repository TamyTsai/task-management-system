// client端 的 連線設定
import consumer from "./consumer"

// consumer.subscriptions.create({ channel: "ChatChannel", room: "Best Room" })
consumer.subscriptions.create("BoardChannel", {
    received(data) { // client端 收server廣播的東西
        // console.log(data);
        if (data.commit) { // 如果收到的廣播（data）中，有commit這包物件
            window.$store.commit(data.commit, JSON.parse(data.payload))
            // 不會直接改state 但會透過Add to list
            // 請vuex store做commit
            // 解析傳過來的檔案

        }
    }
});