class CreateAuthentications < ActiveRecord::Migration[5.0]
  def change
    create_table :authentications do |t|
      t.string :provider, null: false
      t.string :access_token, null: false
      t.string :email, null: false
      t.integer :user_id

      t.timestamps
    end
    add_index :authentications, [:provider, :email], unique: true
  end
end
