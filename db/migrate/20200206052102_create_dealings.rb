class CreateDealings < ActiveRecord::Migration[5.2]
  def change
    create_table :dealings do |t|
      t.integer :phase, null: true, default: 0
      t.datetime :buyer_datetime, null: true
      t.datetime :seller_datetime, null: true
      t.integer :item_id, limit: 6, null: true, foreign_key: true
      t.integer :buyer_id, limit: 6, null: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
