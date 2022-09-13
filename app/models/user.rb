class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # has_many :recipes, foreign_key: user_id, class_name: 'Recipe'
  has_many :inventor
  has_many :recipe
  has_many :inventories
end
