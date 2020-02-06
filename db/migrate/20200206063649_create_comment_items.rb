class CreateCommentItems < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_items do |t|
      t.text :comment, null: false
      t.integer :item_id, null: true, foreign_key: true
      t.integer :user_id, null: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
