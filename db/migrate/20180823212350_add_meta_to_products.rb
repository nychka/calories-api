class AddMetaToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :meta, :hstore
  end
end
