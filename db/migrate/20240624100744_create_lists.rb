# rails g scaffold List name user:belongs_to position:integer
# 清單 會屬於某個使用者
# 為了要用acts as list套件，所以要有position欄位

class CreateLists < ActiveRecord::Migration[6.1]
  def change
    create_table :lists do |t|
      t.string :name
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
