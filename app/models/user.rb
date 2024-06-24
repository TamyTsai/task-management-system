# rails g devise User

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lists, -> { order(position: :asc) } 
  # 用lambda物件化block
  # 使用lists方法時，就會按照position欄位值的大小，由小到大撈資料
  has_many :cards
end
