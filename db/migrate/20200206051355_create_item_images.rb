class CreateItemImages < ActiveRecord::Migration[5.2]
  def change
    create_table :item_images do |t|
      t.text :image, null: false
      t.integer :item_id, limit: 6, null: true
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.timestamps null: false
    end
    add_foreign_key :item_images, :items
  end
end
