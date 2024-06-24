class Card < ApplicationRecord
  acts_as_list scope: :list
  # 根據list來做scope

  belongs_to :list

  validates :name, presence: true
end
