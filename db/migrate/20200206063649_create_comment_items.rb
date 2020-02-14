class CreateCommentItems < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_items do |t|
      t.text :comment, null: false
      t.integer :item_id, null: true, limit: 6
      t.integer :user_id, null: true, limit: 6
      t.timestamps null: false
    end
    add_foreign_key :comment_items, :users
    add_foreign_key :comment_items, :items
  end
end
