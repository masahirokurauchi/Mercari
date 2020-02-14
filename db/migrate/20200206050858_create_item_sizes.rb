class CreateItemSizes < ActiveRecord::Migration[5.2]
  def change
    create_table :item_sizes do |t|
      t.integer :item_id, limit: 6, null: false
      t.integer :size_id, limit: 6, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.timestamps null: false
    end
    add_foreign_key :item_sizes, :items
    add_foreign_key :item_sizes, :sizes
  end
end
