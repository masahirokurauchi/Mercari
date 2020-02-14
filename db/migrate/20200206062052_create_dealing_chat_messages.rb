class CreateDealingChatMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :dealing_chat_messages do |t|
      t.text :message, null: false
      t.integer :dealing_id, limit: 6, null: true
      t.integer :user_id, limit: 6, null: true
      t.timestamps null: false
    end
    add_foreign_key :dealing_chat_messages, :dealings
    add_foreign_key :dealing_chat_messages, :users
  end
end
