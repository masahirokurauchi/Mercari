class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :customer_token, null: false
      t.integer :user_id, limit: 6, null: true
      t.timestamps null: false
    end
    add_foreign_key :cards, :users
  end
end
