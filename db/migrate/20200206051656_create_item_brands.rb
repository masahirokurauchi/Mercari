class CreateItemBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :item_brands do |t|
      t.integer :item_id, limit: 6, null: false, foreign_key: true
      t.integer :brand_name_id, limit: 6, null: false, foreign_key: true
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.timestamps null: false
    end
  end
end
