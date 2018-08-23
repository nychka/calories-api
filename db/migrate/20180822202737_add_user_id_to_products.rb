class AddUserIdToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :user_id, :integer, index:true, foreign_key: true
  end
end
