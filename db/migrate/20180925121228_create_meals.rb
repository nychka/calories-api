class CreateMeals < ActiveRecord::Migration[5.0]
  def change
    create_table :meals do |t|
      t.integer :product_id, null: false, index: true
      t.integer :user_id, null: false, index: true
      t.integer :weight, null: false

      t.timestamps
    end
  end
end
