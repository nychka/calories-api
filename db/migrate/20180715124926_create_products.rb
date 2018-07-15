class CreateProducts < ActiveRecord::Migration[5.0]
  def self.up
    enable_extension 'hstore'

    create_table :products do |t|
      t.hstore :lang
      t.hstore :nutrition
      t.string :image
      t.integer :category_id
      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
