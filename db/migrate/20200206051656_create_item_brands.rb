class CreateItemBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :item_brands do |t|
      t.integer :item_id, limit: 6, null: false
      t.integer :brand_name_id, limit: 6, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.timestamps null: false
    end
    add_foreign_key :item_brands, :items
    add_foreign_key :item_brands, :brand_names
  end
end
