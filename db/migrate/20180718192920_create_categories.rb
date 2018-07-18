class CreateCategories < ActiveRecord::Migration[5.0]
  def self.up
    create_table :categories do |t|
      t.hstore :lang
      t.string :image

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
