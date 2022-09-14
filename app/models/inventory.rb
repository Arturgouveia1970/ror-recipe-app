class Inventory < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  has_many :inventory_foods, dependent: :delete_all
  has_many :foods, through: :inventory_foods, dependent: :destroy

  validates :name, presence: true
end
