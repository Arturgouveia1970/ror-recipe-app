class CreateInventoriesFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories_foods do |t|
      t.string :quantity
      t.references :food, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end