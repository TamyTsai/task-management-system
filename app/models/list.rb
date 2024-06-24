class List < ApplicationRecord
  # acts_as_list scope: :user
  # 根據user來做scope

  belongs_to :user # 每個清單 屬於 一個使用者
  has_many :cards, -> { order(position: :asc) }, dependent: :destroy
  # 每個清單 可以有 多張卡片
  # dependent: :destroy  刪除列表時 連同卡片一起刪除
  # [2] pry(main)> u.lists
  # List Load (2.1ms)  SELECT "lists".* FROM "lists" WHERE "lists"."user_id" = $1 ORDER BY "lists"."position" ASC  [["user_id", 1]]

  validates :name, presence: true

end

# rails c
  # [1] pry(main)> u = User.first
  # NOTICE:  identifier "spring app    | 任務管理系統 | started 0 secs ago | development mode" will be truncated to "spring app    | 任務管理系統 | started 0 secs ago | devel"
  #   User Load (0.4ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
  # => #<User id: 1, email: "aaa@bbb.com", created_at: "2024-06-24 09:16:58.409907000 +0000", updated_at: "2024-06-24 09:16:58.409907000 +0000">
  # [2] pry(main)> u.lists
  #   List Load (2.1ms)  SELECT "lists".* FROM "lists" WHERE "lists"."user_id" = $1 ORDER BY "lists"."position" ASC  [["user_id", 1]]
  # => []
  # [3] pry(main)> u.lists.create(name: 'TODO') 於lists資料表中 創建name欄位為TODO的資料 並寫入資料庫 # position欄位的值為acts as list自動填入
  #   TRANSACTION (0.2ms)  BEGIN
  #   User Load (0.3ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
  #   List Load (0.3ms)  SELECT "lists".* FROM "lists" WHERE "lists"."user_id" = $1 AND ("lists"."position" IS NOT NULL) ORDER BY "lists"."position" DESC LIMIT $2  [["user_id", 1], ["LIMIT", 1]]
  #   List Create (2.9ms)  INSERT INTO "lists" ("name", "user_id", "position", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["name", "TODO"], ["user_id", 1], ["position", 1], ["created_at", "2024-06-24 10:28:07.411967"], ["updated_at", "2024-06-24 10:28:07.411967"]]
  #   TRANSACTION (0.3ms)  COMMIT
  # => #<List:0x00000001366ded90 id: 1, name: "TODO", user_id: 1, position: 1, created_at: Mon, 24 Jun 2024 10:28:07.411967000 UTC +00:00, updated_at: Mon, 24 Jun 2024 10:28:07.411967000 UTC +00:00>
  # [4] pry(main)> u.lists.create(name: 'DOING')
  #   TRANSACTION (0.4ms)  BEGIN
  #   User Load (1.6ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
  #   List Load (0.7ms)  SELECT "lists".* FROM "lists" WHERE "lists"."user_id" = $1 AND ("lists"."position" IS NOT NULL) ORDER BY "lists"."position" DESC LIMIT $2  [["user_id", 1], ["LIMIT", 1]]
  #   List Create (2.2ms)  INSERT INTO "lists" ("name", "user_id", "position", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["name", "DOING"], ["user_id", 1], ["position", 2], ["created_at", "2024-06-24 10:28:25.370283"], ["updated_at", "2024-06-24 10:28:25.370283"]]
  #   TRANSACTION (1.1ms)  COMMIT
  # => #<List:0x000000011732ba28 id: 2, name: "DOING", user_id: 1, position: 2, created_at: Mon, 24 Jun 2024 10:28:25.370283000 UTC +00:00, updated_at: Mon, 24 Jun 2024 10:28:25.370283000 UTC +00:00>
  # [5] pry(main)> u.lists.create(name: 'DONE')
  #   TRANSACTION (1.7ms)  BEGIN
  #   User Load (0.5ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
  #   List Load (0.5ms)  SELECT "lists".* FROM "lists" WHERE "lists"."user_id" = $1 AND ("lists"."position" IS NOT NULL) ORDER BY "lists"."position" DESC LIMIT $2  [["user_id", 1], ["LIMIT", 1]]
  #   List Create (0.8ms)  INSERT INTO "lists" ("name", "user_id", "position", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["name", "DONE"], ["user_id", 1], ["position", 3], ["created_at", "2024-06-24 10:28:30.985613"], ["updated_at", "2024-06-24 10:28:30.985613"]]
  #   TRANSACTION (1.3ms)  COMMIT
  # => #<List:0x00000001172be158 id: 3, name: "DONE", user_id: 1, position: 3, created_at: Mon, 24 Jun 2024 10:28:30.985613000 UTC +00:00, updated_at: Mon, 24 Jun 2024 10:28:30.985613000 UTC +00:00>
  # [6] pry(main)> u.lists
  # => [#<List:0x00000001366ded90 id: 1, name: "TODO", user_id: 1, position: 1, created_at: Mon, 24 Jun 2024 10:28:07.411967000 UTC +00:00, updated_at: Mon, 24 Jun 2024 10:28:07.411967000 UTC +00:00>,
  # #<List:0x000000011732ba28 id: 2, name: "DOING", user_id: 1, position: 2, created_at: Mon, 24 Jun 2024 10:28:25.370283000 UTC +00:00, updated_at: Mon, 24 Jun 2024 10:28:25.370283000 UTC +00:00>,
  # #<List:0x00000001172be158 id: 3, name: "DONE", user_id: 1, position: 3, created_at: Mon, 24 Jun 2024 10:28:30.985613000 UTC +00:00, updated_at: Mon, 24 Jun 2024 10:28:30.985613000 UTC +00:00>]
