# frozen_string_literal: true

class ChangeUserIdToBeBigintInRecipes < ActiveRecord::Migration[7.0]
  def change
    change_column :recipes, user_id, :bigint
  end
end
