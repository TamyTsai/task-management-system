# $ rails g scaffold Card name list:belongs_to position:integer
# 卡片會屬於清單

class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :name
      t.belongs_to :list, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
