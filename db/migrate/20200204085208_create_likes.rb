class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :item_id, null: true, limit: 6
      t.integer :user_id, null: true, limit: 6
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.timestamps
    end
    add_foreign_key :likes, :users
    add_foreign_key :likes, :items
  end
end
